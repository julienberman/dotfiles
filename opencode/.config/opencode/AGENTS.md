I'm Julien. You're my agent. We will be working together a lot, so I thought it could be worth introducing myself. I am an economist who cares deeply about data, software, and attention to detail. I am extremly precise in my thinking. I expect you to be as well.

I love to build. In particular, I love to solve complex problems with simple solutions. I absolutely love to find ways to reduce complexity when solving problems. Why write 100 lines of code, when 10 will do?

I am also obsessed with organization. Every piece of text and piece of code needs to go in the proper directory and file. Your job is to help keep me organized.

# Communication Preferences
- Be concise. Avoid unnecessary preamble or summary.
- Prioritize concision, clarity, and readbility over cleverness
- Questions are read only.A question is a request for an answer, not for changes. If a question begins with "why does", "how hard would it be", "what is the purpose", "can X do Y", "should we", or otherwise asks rather than instructs: answer it, and do not edit any files
- Even if the answer is obvious and the change is trivial, still answer first and offer the change. Ask before making it.

# Coding preferences

## General
- Keep things simple. Channel "yagni" energy unless told otherwise.
- Try to reduce code and bloat, where possible
- Be careful with destructive actions that are not explicitly requested by the user.
- If the development environment uses docker containers, make sure to execute all commands and tests inside the appropriate container. Avoid running code on the host machine.
- Avoid excessive comments. Comments should only be used above class and method definitions to clarify functionality, and only if necessary. They should be very concise.
- Keep comments and documentation up-to-date.
- Prioritize concise, descriptive variable, method, and class names
- Use spaces, not tabs
- Tests are good, but endless "smoke tests" and "regression tests" are useless and bloat the codebase. Tests should be focused, not slop.

## Pull Requests
- Make sure titles follow conventions from the repo. Titles should be simple and easy to understand, i.e. `fix(web): new threads no longer spike CPU`
- PR descriptions should aim for simplicity. Open with a minimal, clear description of the problem. Follow up with how you solved it.
- Add a blurb at the end about what model is making the changes.
- Rebase onto the latest version of `main` before opening. Stale branches conflict and waste a review round.
- When asked to monitor or babysit a PR: poll checks and comments newer than the last push; verify each bot finding against the source before acting on it; fix real ones and dismiss false positives with a written reason; fix CI failures. If nothing is new, stay quiet. Do not poste filler comments.

## Typescript
- Never use `any`. 
- Write TypeScript in a way that Matt Pocock would be proud.

## Python
- Adhere to PEP8 style wherever possible
- Avoid excessive subfunctions and helper functions. Each function should accomplish a cohesive task.
- All directory and paths should be instantiated as `Path` objects. If a service only accepts paths as strings, they should be converted when necessary.

### Pandas
- Utilize method chaining wherever possible
    - .assign(...) for mutating variables
    - .groupby(...).agg({...}) for group-level aggregation
    - .groupby(...).transform() for in-place group-level operations
    - .query(...) for simple filtration, .loc[...] for complex filtration
    - .merge( ..., how = ..., on = [...]) for merging
    - .drop(columns=[...]) for removing columns
    - .select(columns=[...]) for selecting columns (pyjanitor)
    - .sort_values(by=[...]) for sorting

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

## R
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


## Latex
### Tables
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

### Figures
- Every figure should be structured as follows:
    - Caption
    - Label (of the form `fig:[figure_name]`)
    - subfigures, if any
    - open minipage with width equal to `linewidth` for table notes

