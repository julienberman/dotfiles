# Python project rules
Primarily for data science projects.

## File organization
- Meta: sections should be separated by two newlines. Subsections should be separated by a single newline
- Section 1: Imports
    - Subsection A: Relevant python dependencies, alphabetized (e.g. `import pandas as pd`)
    - Subection B: Relevent project-specific dependences, alphabetized (e.g. `from source.lib.save_data import save_data`)
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
- Avoid unnecessary `try...except...` handling
- Avoid defining helper functions within the scope of a parent function

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

## Pandas syntax
- Prioritize concise and reable syntax
- Utilize method chaining wherever possible
    - .assign(...) for mutating variables
    - .groupby(...).agg({...}) for group-level aggregation
    - .groupby(...).transform() for in-place group-level operations
    - .query(...) for simple filtration, .loc[...] for complex filtration
    - .merge( ..., how = ..., on = [...]) for merging
    - .drop(columns=[...]) for removing columns
    - .select(columns=[...]) for selecting columns (pyjanitor)
    - .sort_values(by=[...]) for sorting
- Avoid excessive subfunctions and helper functions. Each function should accomplish a cohesive task

Example:

```
def clean_congress_twitter(df):
    df_clean = (
        df
        .clean_names()
        .rename(columns={"id": "message_id", "screen_name": "user_name", "link": "url", "time": "date"})
        .assign(message_id = lambda x: x['message_id'].astype(str))
        .assign(text = lambda x: clean_text(x['text'], lower=True))
        .assign(date = lambda x: clean_date(pd.to_datetime(x["date"], errors="coerce")))
        .assign(source = lambda x: clean_text(x['source'], lower=True))
        .drop(columns=['user_name'])
        .drop_duplicates(subset=['message_id'])
        .convert_dtypes()
    )
    return df_clean
```


