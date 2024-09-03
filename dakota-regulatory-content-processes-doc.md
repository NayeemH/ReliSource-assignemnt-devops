# Dakota Regulatory Content Processes Documentation

## Table of Contents
1. [Introduction](#introduction)
2. [DAKREF Overview](#dakref-overview)
   2.1 [Purpose and Functionality](#purpose-and-functionality)
   2.2 [Version Compatibility](#version-compatibility)
   2.3 [Release Cycle](#release-cycle)
   2.4 [User Interaction](#user-interaction)
3. [Content Structure](#content-structure)
   3.1 [Modules](#modules)
   3.2 [Source Files](#source-files)
   3.3 [Content Licensing](#content-licensing)
4. [Content Creation Process](#content-creation-process)
   4.1 [Internal Content Creation](#internal-content-creation)
   4.2 [Third-Party Content Integration](#third-party-content-integration)
   4.3 [Content Conversion Tools](#content-conversion-tools)
5. [DAKREF Build Process](#dakref-build-process)
   5.1 [Build Components](#build-components)
   5.2 [Detailed Build Steps](#detailed-build-steps)
   5.3 [State Content Integration](#state-content-integration)
   5.4 [Quality Assurance in Build Process](#quality-assurance-in-build-process)
6. [Source File Formats](#source-file-formats)
   6.1 [Internal Source Files](#internal-source-files)
   6.2 [Third-Party Source Files](#third-party-source-files)
   6.3 [File Structure and Syntax](#file-structure-and-syntax)
7. [Interim Content Review Process](#interim-content-review-process)
   7.1 [Process Overview](#process-overview)
   7.2 [Detailed Review Steps](#detailed-review-steps)
   7.3 [Limitations and Challenges](#limitations-and-challenges)
8. [Tools and Technologies](#tools-and-technologies)
   8.1 [SlickEdit](#slickedit)
   8.2 [RGTools](#rgtools)
   8.3 [Database Technologies](#database-technologies)
9. [Content Management Workflows](#content-management-workflows)
   9.1 [New Content Creation](#new-content-creation)
   9.2 [Content Update Process](#content-update-process)
   9.3 [Deprecation and Removal](#deprecation-and-removal)
10. [Additional Resources](#additional-resources)
    10.1 [Documentation Location](#documentation-location)
    10.2 [Notes on Documentation](#notes-on-documentation)
    10.3 [Guidelines and Best Practices](#guidelines-and-best-practices)
11. [Glossary of Terms](#glossary-of-terms)

## 1. Introduction <a name="introduction"></a>

This comprehensive documentation provides an in-depth overview of Dakota's Regulatory Content Processes as of January 2022. It covers the intricate details of the structure, creation, management, and distribution of regulatory content within the DAKREF system. This guide is intended for technical staff, content creators, and system administrators involved in the maintenance and development of Dakota's regulatory content infrastructure.

The processes outlined in this document are crucial for maintaining the integrity, accuracy, and timeliness of regulatory information provided to Dakota's clients. As regulatory requirements constantly evolve, these processes ensure that Dakota can efficiently update and distribute the most current and relevant information to its user base.

## 2. DAKREF Overview <a name="dakref-overview"></a>

DAKREF (Dakota Reference) is the cornerstone of Dakota's regulatory content management system. It serves as a comprehensive repository of current and historical regulatory information, designed to provide clients with accurate and up-to-date compliance data.

### 2.1 Purpose and Functionality <a name="purpose-and-functionality"></a>

The primary purposes of DAKREF are:

1. To provide a centralized repository for all regulatory content.
2. To maintain historical records of regulatory changes.
3. To enable version-to-version compatibility for client systems.
4. To facilitate the organized distribution of regulatory content to licensed clients.

DAKREF achieves these goals through a structured database system that categorizes content into modules, maintains revision histories, and controls access based on client licensing agreements.

### 2.2 Version Compatibility <a name="version-compatibility"></a>

Version compatibility is a critical feature of DAKREF, ensuring that clients can seamlessly update their systems without loss of historical data or disruption to their compliance processes. To maintain version compatibility:

- Each new version of the reference database incorporates all historical information from previous versions.
- A robust versioning system tracks changes at the content level, allowing for granular updates and rollbacks if necessary.
- Migration scripts are developed and tested to ensure smooth transitions between major versions of the database.

### 2.3 Release Cycle <a name="release-cycle"></a>

DAKREF follows a monthly release cycle, providing regular updates to ensure clients have access to the most current regulatory information. The release process includes:

1. Content freeze date: Typically 5 business days before the end of the month.
2. Build and QA process: 3-4 business days for thorough testing and validation.
3. Release to customers: Usually on the last business day of the month.

Emergency updates may be released off-cycle for critical regulatory changes that cannot wait for the next scheduled release.

### 2.4 User Interaction <a name="user-interaction"></a>

While DAKREF is a comprehensive database of regulatory information, it is designed as a read-only system for end-users. This approach ensures data integrity and consistency across all client installations. Key points regarding user interaction include:

- Users cannot directly add, delete, or modify content within the DAKREF database.
- All content updates are managed centrally by Dakota's Regulatory Group.
- Clients interact with DAKREF content through Dakota's suite of compliance management tools, which provide user-friendly interfaces for accessing and applying the regulatory information.

## 3. Content Structure <a name="content-structure"></a>

The content within DAKREF is organized in a hierarchical structure designed to facilitate easy access, updates, and licensing management.

### 3.1 Modules <a name="modules"></a>

Modules are the primary organizational units within DAKREF. Each module represents a distinct set of regulatory content, often aligned with specific industries, regions, or types of compliance requirements.

Key features of the module system include:

- Hierarchical organization: Modules can contain sub-modules for more granular content organization.
- Interdependencies: Some modules may reference or depend on content from other modules.
- Versioning: Each module is independently versioned, allowing for targeted updates.
- Licensing control: Client access to modules is managed through licensing agreements.

As of January 2022, DAKREF contains over 975 modules, covering a wide range of regulatory domains.

### 3.2 Source Files <a name="source-files"></a>

The content for each module is maintained in a set of source files, primarily in .txt format. These source files are the raw input for the DAKREF build process. Key aspects of source files include:

- File types: Typically, there are 5 files per module, each serving a specific purpose (e.g., domain definitions, questions, reference libraries).
- Editing environment: SlickEdit is the preferred text editor for working with these source files due to its advanced features for handling large text files and support for custom syntax highlighting.
- Version control: Source files are managed through a version control system (details of which are not specified in the original document) to track changes and facilitate collaborative editing.

### 3.3 Content Licensing <a name="content-licensing"></a>

The modular structure of DAKREF allows for flexible licensing arrangements with clients. Key points about content licensing include:

- Granular access control: Clients can be licensed for one or more specific modules based on their regulatory needs.
- Scalability: As clients' needs grow, additional modules can be easily added to their license.
- Usage tracking: The licensing system integrates with Dakota's analytics tools to provide insights into module usage and inform future content development priorities.

## 4. Content Creation Process <a name="content-creation-process"></a>

The content creation process for DAKREF involves both internal content development by Dakota's Regulatory Group and the integration of content from third-party partners.

### 4.1 Internal Content Creation <a name="internal-content-creation"></a>

Dakota's Regulatory Group is responsible for creating and maintaining a significant portion of the content within DAKREF. The internal content creation process involves:

1. Research: Regulatory experts research and analyze new and updated regulations.
2. Content drafting: Information is directly entered into source .txt files using SlickEdit.
3. Peer review: Content undergoes a peer review process within the Regulatory Group.
4. Quality assurance: A final QA check is performed before the content is approved for inclusion in the next DAKREF release.

For newer ProActivity features, some content is initially created in Excel files before being converted to the required .txt format for DAKREF integration.

### 4.2 Third-Party Content Integration <a name="third-party-content-integration"></a>

Dakota partners with specialized content providers to enhance the breadth and depth of regulatory information in DAKREF. The two primary third-party content sources are:

1. BLR (Business & Legal Resources):
   - Provides state-specific regulatory information
   - Delivers content in Word document format
   - Covers approximately 71 subjects per state for all 50 U.S. states

2. Enhesa:
   - Provides international (non-U.S.) regulatory information
   - Delivers content in XML file format
   - Covers a wide range of global jurisdictions and regulatory domains

### 4.3 Content Conversion Tools <a name="content-conversion-tools"></a>

To integrate third-party content into DAKREF, the Regulatory Group uses various conversion tools:

- Word to TXT converter: Custom tool for processing BLR state information
- XML parser: Tool for extracting and formatting Enhesa international content
- Data mapping scripts: Ensure consistent formatting and structure across different content sources

These tools streamline the process of converting diverse input formats into the standardized .txt source files required for DAKREF.

## 5. DAKREF Build Process <a name="dakref-build-process"></a>

The DAKREF build process is a complex operation that transforms the various source files and supplementary data into a cohesive, searchable database of regulatory content.

### 5.1 Build Components <a name="build-components"></a>

The key components involved in the DAKREF build process include:

1. Source files (.txt): The primary content files for each module
2. Module building tool: Dakota's proprietary software for assembling modules
3. Supplementary Excel files: Contain additional data and metadata for the build process
4. Previous DAKREF and MasterRef databases: Used for maintaining historical information and ensuring version compatibility

### 5.2 Detailed Build Steps <a name="detailed-build-steps"></a>

The DAKREF build process follows these detailed steps:

1. Initialization:
   - Load all current source .txt files
   - Initialize the build environment with the latest MasterRef database

2. Module Assembly:
   - For each module, process the associated .txt files using the module building tool
   - Generate a preliminary module structure

3. Data Injection:
   - Integrate data from supplementary Excel files:
     - WHATSNEW: Highlights of changes in the current release
     - Module Ordering: Defines the hierarchical structure of modules
     - Migration Detection: Identifies content that has moved between modules
     - Applicability Accelerators: Enhances content discoverability
     - State Applicability Differences: Manages state-specific regulatory variations

4. Database Construction:
   - Assemble the preliminary DAKREF database structure
   - Apply the indexing SQL script to optimize database performance

5. Historical Data Integration:
   - Merge the new content with historical data from the previous DAKREF release
   - Ensure all historical records are properly maintained and versioned

6. Quality Assurance:
   - Run automated tests to verify database integrity and content consistency
   - Perform manual spot-checks on key content areas

7. Release Candidate Creation:
   - Generate the Release Candidate DAKREF database
   - Conduct final validation tests

### 5.3 State Content Integration <a name="state-content-integration"></a>

The integration of state-specific content follows a parallel process:

1. State File Processing:
   - Process state text files (both current and new content)
   - Typically involves 1 file per subject per state, covering 50 states and approximately 71 subjects per state

2. State Merge Database Creation:
   - Use RG Tools to create the State Merge Database (also known as MasterRef database)
   - This database consolidates all state-specific regulatory information

3. Federal and State Integration:
   - Merge the Federal content database with the State Merge Database
   - This integration creates the comprehensive DAKREF database, covering both federal and state regulations

### 5.4 Quality Assurance in Build Process <a name="quality-assurance-in-build-process"></a>

Quality assurance is integrated throughout the build process:

- Automated checks: Scripts verify data integrity, check for broken links, and ensure consistent formatting
- Manual reviews: Subject matter experts perform targeted reviews of new and updated content
- Regression testing: Ensures that updates do not inadvertently affect existing content or functionality
- Performance testing: Validates that the new build meets performance benchmarks for data retrieval and search operations

## 6. Source File Formats <a name="source-file-formats"></a>

Understanding the structure and format of source files is crucial for maintaining and updating DAKREF content.

### 6.1 Internal Source Files <a name="internal-source-files"></a>

Internal source files are primarily .txt files, with specific formats for different types of content:

1. Domain.txt:
   - Defines the regulatory domains and their hierarchical structure
   - Example structure:
     ```
     [DOMAIN_ID]
     DOMAIN_NAME=Environmental Compliance
     PARENT_DOMAIN=Regulatory Compliance
     DESCRIPTION=Regulations pertaining to environmental protection and conservation
     ```

2. Question.txt:
   - Contains regulatory questions and associated metadata
   - Example structure:
     ```
     [QUESTION_ID]
     QUESTION_TEXT=Does the facility have a Spill Prevention, Control, and Countermeasure (SPCC) plan?
     APPLICABILITY=Facilities storing more than 1,320 gallons of oil in aboveground containers
     GUIDANCE=SPCC plans are required under 40 CFR 112 for facilities that could reasonably be expected to discharge oil into navigable waters
     ```

3. Reflib.txt:
   - Stores detailed reference information and regulatory text
   - Example structure:
     ```
     [REF_ID]
     CITATION=40 CFR 112.7
     TEXT=The Plan must be prepared in accordance with good engineering practices...
     EFFECTIVE_DATE=2002-08-16
     JURISDICTION=Federal
     ```

### 6.2 Third-Party Source Files <a name="third-party-source-files"></a>

Third-party content arrives in various formats before being converted to the standard .txt format:

1. BLR state information:
   - Delivered as Word documents
   - Typically structured with headings for each regulatory topic and subheadings for specific requirements
   - May include tables for comparative state information

2. Enhesa international information:
   - Delivered as XML files
   - Structured with tags for different elements such as regulatory references, requirement text, and applicability criteria
   - Example XML structure:
     ```xml
     <regulation>
       <country>France</country>
       <topic>Waste Management</topic>
       <requirement>
         <text>Companies must maintain a waste register documenting the nature, quantity, and disposal method of all waste generated.</text>
         <legal_reference>Article R541-43 of the Environmental Code</legal_reference>
       </requirement>
     </regulation>
     ```

### 6.3 File Structure and Syntax <a name="file-structure-and-syntax"></a>

To ensure consistency and facilitate automated processing, all source files adhere to strict structural and syntactical rules:

- Section delimiters: Square brackets [] are used to denote new sections or entries
- Key-value pairs: Information is typically stored in key=value format
- Multi-line values: Long text fields use a continuation character (typically a backslash \) at the end of each line
- Comments: Lines beginning with // are treated as comments and ignored during processing
- Cross-references: Special syntax (e.g., @REF:12345) is used to link between different content pieces

Adhering to these formatting rules is crucial