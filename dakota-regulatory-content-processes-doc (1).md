### 6.3 File Structure and Syntax (continued) <a name="file-structure-and-syntax"></a>

Adhering to these formatting rules is crucial for maintaining consistency and enabling efficient automated processing. Additional syntactical elements include:

- Version tags: Each content piece includes a version tag (e.g., @VERSION:2.1) to track changes over time
- Applicability markers: Special markers (e.g., @APPLY_IF:INDUSTRY=Manufacturing) define the scope of applicability for specific regulations
- Conditional text: Syntax like {IF:CONDITION}text{ENDIF} allows for dynamic content generation based on specific criteria
- Metadata fields: Each content piece includes metadata such as @AUTHOR, @LAST_UPDATED, and @REVIEW_STATUS

Example of a complex content piece with multiple syntactical elements:

```
[REG_12345]
@VERSION:3.2
@AUTHOR:J.Smith
@LAST_UPDATED:2022-01-15
@REVIEW_STATUS:Approved

TITLE=Hazardous Waste Management Requirements
TEXT=Facilities generating more than 100 kg of hazardous waste per month must: \
1) Obtain an EPA identification number \
2) Comply with accumulation time limits \
3) Ensure proper container labeling and management \
4) Maintain detailed waste manifests

@APPLY_IF:INDUSTRY=Manufacturing,Chemical
@APPLY_IF:WASTE_GENERATION>100kg/month

EXCEPTIONS={IF:STATE=California}Additional state-specific requirements apply. \
See @REF:CA_HAZWASTE for details.{ENDIF}

REFERENCES=@REF:40CFR262,@REF:RCRA_GUIDELINES
```

This structured approach ensures that content can be easily parsed, updated, and dynamically presented based on user-specific criteria.

## 7. Interim Content Review Process <a name="interim-content-review-process"></a>

Between DAKREF releases, an interim process is used to view and review module work. This process is critical for quality assurance and content validation prior to the final release build.

### 7.1 Process Overview <a name="process-overview"></a>

The interim review process involves several steps to convert source files into reviewable database formats:

1. REM File Generation: Convert source text files into REM (Regulatory Entity Model) files
2. Module Database Creation: Build individual module databases for isolated testing
3. SQL Server Database Population: Transfer data to a SQL Server environment for comprehensive review
4. Testing Database Creation: Generate specific databases for different testing purposes

### 7.2 Detailed Review Steps <a name="detailed-review-steps"></a>

1. REM File and Module.db Creation:
   - Use RGTools to process source text files
   - Generate REM files which represent an intermediate data format
   - Create Module.db files for each module, containing structured content data

2. SQL Server Database Population:
   - Execute the DatToSybase.bat script to transfer data from Module.db to a SQL Server database
   - This step involves data transformation and normalization to fit the SQL Server schema

3. Specialized Database Creation:
   - Generate a Sybase database for testing revisions (non-functional for release)
   - Create a DAKREF SQL Server Database for testing Abridged links (non-functional for release)
   - Develop a DAKREF SQL Server Database for testing Applicability Accelerators (AAs) and State Applicability Differences (SADs)

4. Content Review:
   - Regulatory experts access the testing databases to review content changes
   - Use specialized tools to compare new content against the previous release
   - Verify accuracy, completeness, and consistency of regulatory information

5. Feedback and Iteration:
   - Document any issues or necessary changes
   - Update source files based on review feedback
   - Re-run the process to generate updated review databases as needed

### 7.3 Limitations and Challenges <a name="limitations-and-challenges"></a>

The current interim review process faces several challenges:

1. Reliance on Legacy Technology:
   - Some components of the process use outdated tools and scripts
   - This increases the risk of system failures and complicates maintenance

2. Performance Issues:
   - The process of generating multiple databases can be time-consuming
   - This can delay feedback cycles and slow down the overall content update process

3. Limited QA Capabilities:
   - The DAKREF build process wasn't originally designed for easy viewing of content changes
   - This makes comprehensive QA review more challenging and time-intensive

4. Data Consistency:
   - Multiple intermediate databases increase the risk of data inconsistencies
   - Extra validation steps are required to ensure data integrity across all stages

5. Scalability Concerns:
   - As the volume of regulatory content grows, the current process may become increasingly inefficient

To address these challenges, there are ongoing efforts to modernize the review process, including the development of more efficient database technologies and streamlined review tools.

## 8. Tools and Technologies <a name="tools-and-technologies"></a>

The DAKREF system relies on a variety of tools and technologies for content creation, management, and distribution. Understanding these tools is crucial for maintaining and evolving the DAKREF ecosystem.

### 8.1 SlickEdit <a name="slickedit"></a>

SlickEdit is the primary text editor used by the Regulatory Group for working with source files.

Key features utilized in DAKREF content management:
- Syntax highlighting: Custom rules for DAKREF-specific syntax
- Macro support: Automated routines for common editing tasks
- Multi-file search and replace: Facilitates large-scale content updates
- Version control integration: Seamless interaction with the version control system

### 8.2 RGTools <a name="rgtools"></a>

RGTools is a proprietary suite of utilities developed by Dakota for managing the DAKREF build and review process.

Components of RGTools include:
- Build REM Files: Converts source text files to Regulatory Entity Model format
- Build Module.db: Generates individual module databases
- Blobs Creation: Handles large object data within the database
- Import/Export tab: Facilitates data transfer between different database formats

Usage guidelines:
- Access control: RGTools access is restricted to authorized Regulatory Group members
- Training requirements: New team members undergo specific training on RGTools usage
- Version management: Regular updates to RGTools are pushed to ensure compatibility with evolving DAKREF requirements

### 8.3 Database Technologies <a name="database-technologies"></a>

DAKREF utilizes multiple database technologies throughout its lifecycle:

1. SQL Server:
   - Primary database for the release version of DAKREF
   - Supports complex queries and efficient data retrieval
   - Used for final QA and customer-facing deployments

2. Sybase:
   - Used in the interim review process
   - Supports legacy components of the DAKREF ecosystem

3. SQLite:
   - Employed for Module.db files in the build process
   - Provides a lightweight, file-based database solution for individual modules

Each database technology plays a specific role in the DAKREF lifecycle, from development and testing to final deployment.

## 9. Content Management Workflows <a name="content-management-workflows"></a>

Effective content management is crucial for maintaining the accuracy and relevance of DAKREF. The following workflows outline the processes for creating, updating, and retiring content within the system.

### 9.1 New Content Creation <a name="new-content-creation"></a>

The process for adding new regulatory content to DAKREF involves several steps:

1. Content Identification:
   - Regulatory experts identify new regulations or guidelines requiring coverage
   - Determine the appropriate module(s) for the new content

2. Draft Creation:
   - Author creates initial draft in the appropriate source file format
   - Apply necessary metadata and structural elements

3. Peer Review:
   - At least two other regulatory experts review the draft
   - Check for accuracy, clarity, and adherence to DAKREF standards

4. Revision and Approval:
   - Author addresses feedback and makes necessary revisions
   - Final approval from a senior regulatory expert

5. Integration:
   - New content is integrated into the DAKREF build process
   - Verify proper indexing and cross-referencing

6. QA and Release:
   - Content undergoes final QA in the pre-release DAKREF build
   - Included in the next scheduled DAKREF release

### 9.2 Content Update Process <a name="content-update-process"></a>

Updating existing content follows a similar but streamlined process:

1. Change Identification:
   - Monitor regulatory changes and client feedback
   - Flag content requiring updates

2. Update Drafting:
   - Make necessary changes in the source files
   - Update version tags and metadata

3. Differential Review:
   - Conduct a focused review on the changes and their implications
   - Ensure updates don't inadvertently affect related content

4. Approval and Integration:
   - Obtain approval for the updates
   - Integrate changes into the next build cycle

5. Version Control:
   - Ensure proper versioning of updated content
   - Maintain change logs for client reference

### 9.3 Deprecation and Removal <a name="deprecation-and-removal"></a>

When regulatory content becomes obsolete, a careful process is followed:

1. Obsolescence Evaluation:
   - Regularly review content for relevance and accuracy
   - Identify regulations that have been superseded or repealed

2. Deprecation Marking:
   - Mark obsolete content with deprecation tags
   - Update metadata to reflect deprecation status

3. Client Notification:
   - Inform clients of upcoming content removals
   - Provide guidance on transitioning to new regulations if applicable

4. Archival Process:
   - Move deprecated content to an archive database
   - Maintain historical records for reference and compliance history

5. Reference Cleanup:
   - Remove or update any references to the deprecated content in other modules
   - Ensure integrity of remaining content

## 10. Additional Resources <a name="additional-resources"></a>

To support the ongoing maintenance and development of DAKREF, various additional resources are available to the Regulatory Group and other authorized personnel.

### 10.1 Documentation Location <a name="documentation-location"></a>

Comprehensive documentation for Regulatory's operations is stored in:

```
G:\Shared drives\The Dakota Way\The Dakota Way\4. Product Development\c. Regulatory
```

Note: As of January 2022, there were some issues with documentation access and accuracy:
- The correct file for regulatory database release builds was not posted.
- The Regulatory Group lacked permissions to post the correct file.

Steps are being taken to resolve these issues and ensure all team members have access to up-to-date documentation.

### 10.2 Notes on Documentation <a name="notes-on-documentation"></a>

When referring to the documentation, keep in mind:

- Currency: Some details in The Dakota Way documentation may be outdated.
- Verification: Always cross-reference documentation with current practices.
- Update Process: A formal process for regularly reviewing and updating documentation is being developed.

### 10.3 Guidelines and Best Practices <a name="guidelines-and-best-practices"></a>

Regulatory's guidelines contain detailed instructions on various aspects of the DAKREF ecosystem:

1. Source File Editing:
   - Naming conventions for new content
   - Best practices for structuring complex regulatory information
   - Guidelines for cross-referencing and linking related content

2. Quality Assurance:
   - Checklists for content review at various stages
   - Procedures for handling conflicting regulations
   - Standards for clarity and consistency in regulatory language

3. Tool Usage:
   - Detailed guides for each component of RGTools
   - Best practices for efficient use of SlickEdit in content creation
   - Troubleshooting common issues in the build process

4. Collaboration and Communication:
   - Protocols for peer review and feedback
   - Standards for documenting decisions and changes
   - Guidelines for interacting with third-party content providers

5. Continuous Improvement:
   - Process for suggesting and implementing improvements to DAKREF
   - Framework for evaluating new technologies and methodologies

These guidelines are regularly updated to reflect current best practices and lessons learned from ongoing operations.

## 11. Glossary of Terms <a name="glossary-of-terms"></a>

To ensure clear communication and understanding across all teams working with DAKREF, the following glossary provides definitions for key terms and acronyms:

- **AA (Applicability Accelerators)**: Tools used to enhance content discoverability based on specific criteria.
- **BLR (Business & Legal Resources)**: Third-party provider of state-specific regulatory information.
- **DAKREF (Dakota Reference)**: The core regulatory content database system developed and maintained by Dakota.
- **Enhesa**: Third-party provider of international (non-US) regulatory information.
- **MasterRef**: Another term for the State Merge Database, which consolidates all state-specific regulatory information.
- **Module**: The primary organizational unit within DAKREF, representing a distinct set of regulatory content.
- **ProActivity**: A suite of compliance management tools that interface with DAKREF content.
- **REM (Regulatory Entity Model)**: An intermediate data format used in the DAKREF build process.
- **RG Tools (Regulatory Group Tools)**: Proprietary suite of utilities for managing the DAKREF build and review process.
- **SAD (State Applicability Differences)**: Tools for managing state-specific variations in regulatory applicability.
- **SlickEdit**: The primary text editor used for working with DAKREF source files.
- **WHATSNEW**: A document highlighting changes and updates in each DAKREF release.

This glossary should be regularly updated to include new terms and concepts as the DAKREF system evolves.

