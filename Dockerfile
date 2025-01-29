# Use an official Ubuntu base image
FROM mcr.microsoft.com/devcontainers/universal:latest

# Set environment variables
ENV DEBIAN_FRONTEND=noninteractive \
    DOTNET_CLI_TELEMETRY_OPTOUT=1 \
    DOTNET_NOLOGO=1

# Install dependencies
RUN apt-get update && apt-get install -y \
    git \
    curl \
    unzip \
    software-properties-common \
    apt-transport-https \
    ca-certificates \
    gnupg \
    && rm -rf /var/lib/apt/lists/*

# Install the latest .NET SDK
RUN curl -fsSL https://dot.net/v1/dotnet-install.sh | bash /dev/stdin --install-dir /usr/share/dotnet --version latest \
    && [ ! -f /usr/bin/dotnet ] || rm /usr/bin/dotnet \
    && ln -s /usr/share/dotnet/dotnet /usr/bin/dotnet

# Install the latest Node.js LTS (for Next.js & NestJS)
RUN curl -fsSL https://deb.nodesource.com/setup_lts.x | bash - \
    && apt-get install -y nodejs \
    && npm install -g npm@latest yarn pnpm

# Install Java JDK 17 for SonarCloud Analysis
RUN apt-get update && apt-get install -y openjdk-17-jdk \
    && java -version

# Install Azure CLI
RUN curl -sL https://aka.ms/InstallAzureCLIDeb | bash

# Install Azure Pipelines Agent
WORKDIR /azp
ARG AZP_AGENT_VERSION=4.248.1

RUN curl -fsSL https://vstsagentpackage.azureedge.net/agent/${AZP_AGENT_VERSION}/vsts-agent-linux-x64-${AZP_AGENT_VERSION}.tar.gz -o agent.tar.gz \
    && mkdir /agent \
    && tar -xzf agent.tar.gz -C /agent \
    && rm agent.tar.gz


WORKDIR /agent
RUN chmod +x config.sh run.sh

# Set up entrypoint for Azure DevOps agent
COPY entrypoint.sh /agent/entrypoint.sh
RUN chmod +x /agent/entrypoint.sh

ENTRYPOINT ["/agent/entrypoint.sh"]
