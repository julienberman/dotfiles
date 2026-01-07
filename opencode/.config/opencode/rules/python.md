# Python project rules

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


