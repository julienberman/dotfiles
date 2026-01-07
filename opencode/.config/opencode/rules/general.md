# General rules
## Communication
- Be concise. Avoid unnecessary preamble or summary.
- Ask clarifying questions before making assumptions on ambiguous requests.

## General style
- Prioritize oncision, clarity, and readbility over cleverness
- All syntax should be standardized

## File organization
- Meta: sections should be separated by two newlines. Subsections should be separated by a single newline
- Section 1: Imports
    - Subsection A: Relevant lanaguage-specific dependencies, alphabetized 
    - Subection B: Relevent project-specific dependences, alphabetized (e.g. `from source.lib.save_data import save_data` or `source("source/lib/helpers/plot.R")`
- Section 2: Main function
    - Subsection A: declare global variables (e.g. constants, input/output directory paths)
    - Subsection B: read data
    - Subsection C: call processing functions 
- Section 3: Processing functions 
    - In order of when they are called by `main`
- Section 4: Main method called. No other code should go here.

## Formatting
### General
- CRITICAL: DO NOT INCLUDE INLINE COMMENTS OR DOCSTRINGS
- Avoid defining helper functions within the scope of a parent function
- Avoid type hints

### Case 
- All variables, dataframe variables, functions, and file names in snake_case
- All class names in CamelCase
- All global variables defined in 2.A in ALL_CAPS

### Naming
- Prioritize concise, descriptive names
- Files that clean raw data: `build_{datasetname}`
- Files that process clean data: `process_{datasetname}`
- Ingestion and output paths: `INDIR_{datasetname}` and `OUTDIR_{datasetname}`

## File loading and saving
- All directory and paths should be instantiated as `Path` objects. If a service only accepts paths as strings, they should be converted when necessary.
- When saving data and/or files, prioritize project-specific write functions (when supported). 

