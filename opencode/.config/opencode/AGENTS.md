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
    - Subsection A: Standard library imports, alphabetized 
    - Subsection B: Third party imports, alphabetized
    - Subection C: Local project-specific dependencies, alphabetized (e.g. `from source.lib.save_data import save_data` or `source("source/lib/helpers/plot.R")`
- Section 2: Main function
    - Subsection A: declare variables (e.g. constants, input/output directory paths)
    - Subsection B: read data (if applicable)
    - Subsection C: call processing functions 
- Section 3: Processing functions 
    - In order of when they are called by `main`
- Section 4: Main method called. No other code should go here.

## Formatting
### General
- CRITICAL: DO NOT INCLUDE INLINE COMMENTS OR DOCSTRINGS
- Avoid defining helper functions within the scope of a parent function

### Naming 
- Prioritize concise, descriptive names
- All variables, dataframe variables, functions, and file names in snake_case
- All class names in CamelCase

# Python project rules

## General
- CRITICAL: Adhere to PEP8 style wherever possible
- Preference: Use spaces, not tabs
- Preference: Limit all lines to a maximum of 79 characters
- Preference: The closing brace/bracket/parenthesis on multiline constructs should line up under the first character of the line that starts the multiline construct

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
## File loading and saving
- Be sure to create output directories / check if they already exist.
- All directory and paths should be instantiated as `Path` objects. If a service only accepts paths as strings, they should be converted when necessary.

# R project rules

## Syntax
- Use tidyverse syntax wherever possible
- Use method chaining with `%>%` wherever possible

Example:
```
    newspapers_clean <- newspapers %>%
        filter(has_newslibrary == 1) %>%
        distinct(nid, date, .keep_all = TRUE) %>%
        left_join(cw_period_date, by = "date") %>%
        select(nid, newspaper_name, date, period, has_newslibrary, coverage, coverage_idx, n_articles) %>%
        mutate(log_n_articles = log(n_articles + 1))
```


# Latex rules

## Tables
- All tables should use the `booktabs` package
- Every table should be structured as follows (order matters):
    - Caption
    - Label (of the form `tab:[table_name]`)
    - open tabular
        - top rule
        - contents of the table
        - bottom rule
    - close tabular
    - open minipage with width equal to `linewidth` for table notes

## Figures
- Every figure should be structured as follows:
    - Caption
    - Label (of the form `fig:[figure_name]`)
    - subfigures, if any
    - open minipage with width equal to `linewidth` for table notes

