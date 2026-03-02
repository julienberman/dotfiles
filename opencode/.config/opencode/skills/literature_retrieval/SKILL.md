---
name: literature_retrieval 
description: retrieve, catalog, and cite academic papers. The user provides a topic area (required), a target directory (required), a list of journals or databases within which to search (optional), and a .bib file (optional). The agent retrieves relevant papers, names them appropriately, stores them in the target directory, and cites them in the .bib file.
allowed-tools: Bash(python*), Bash(pip*), Bash(curl*), Bash(wget*), Bash(mkdir*), Bash(ls*), Read, Write, Edit, WebSearch, WebFetch
argument-hint: <topic-or-query> <target-directory> [journals] [bib-file]
---

# literature_retrieval: retrieve, catalog, and cite academic papers 

**CRITICAL RULE: Never truncate or abridge the full paper. Never.** Ensure that the entire PDF of the paper is downloaded and stored in the target directory. There are no exceptions.

**CRITICAL RULE: Never read a full PDF. Never.** If it is necessary to read the paper in order to cite the PDF accurately, use the `split_pdf` skill and read only the minimum amount of text to produce the citation. Reading a full PDF will either crash the session with an unrecoverable "prompt too long" error - destroying all context - or produce hallucinated output. There are no exceptions.

## When This Skill Is Invoked

The user wants you to collect academic literature pertaining to a particular topic. The input is:
- REQUIRED: A search query or description of the topic(s) (e.g. "economic models for the spread of misinformation")
- REQUIRED: A file path to store the downloaded PDFs (e.g. ./source/paper/literature)
- OPTIONAL: A list of journals or databases within which to search (e.g., "NBER, Quarterly Journal of Economics, American Economic Review")
- OPTIONAL: A .bib file that stores the citations.

**Important:** You cannot run a search if the user does not provide the search query or the file path. If the user invokes this skill without specifying either the search query or the file path, ask them. Do not guess.

## Step 1: Search 
1. Use WebSearch to find relevant papers. Prioritize papers that are heavily cited.
2. If a list of relevant journals is provided, only consider papers published in those journals.

**Important:** You may run into OAuth / credentials issues. In those cases, compile a list of citations (with links) to the relevant articles for the user to manually download.

## Step 2: Acquire
1. Verify the target directory exists. If it does NOT already exist, create it.
2. Use WebFetch or Bash (curl/wget) to download relevant PDFs and save them to the target directory.
3. Rename PDFs according to the following rules:
- last name of first author
- last name of second author (if there are more than three authors, list only "et-al")
- year of publication
- one, two, or three-word phrase summarizing the gist of the paper title.
Separate the above fields with "-". (e.g. "gentzkow-shapiro-2014-competition")

**If a list of unretrievable citations is compiled:**
1. Check to see if `to_retrieve.md` exists in the target directory. If it does not, create it.
2. Append the list of citations to `to_retrieve.md`
3. Check to see whether any of the citations in `to_retrieve.md` have been retrieved and are stored in the target directory. If so, remove these links from `to_retrieve.md`.

**Directory convention:**
```
literature/
├── gentzkow-shapiro-2014-competition.pdf                    
```

## Step 3: Cite 
Invoke the `split_pdf` skill on the newly-downloaded PDF to read and process thepaper. Only process the minimum number of splits necessary to cite the paper accurately.

**If a .bib file is provided**
Provide a BibTeX citation for each downloaded PDF. Citations should follow the Chicago Manual of Style. BibTeX citations should be sorted in the .bib file alphabetically. The label should be produced according to the following rule:
- last name of first author
- year of publication
- one, two, or three-word phrase summarizing the gist of the paper title
Do not separate the above fields. (e.g. "gentzkow2014competition")

## Quick Reference
| Step | Action |
|------|--------|
| **Search** | Search the web or provided databases for relevant papers|
| **Acquire** | Download papers to target directory, or store list of unretrievable papers|
| **Cite** | Generate BibTeX citations and store them alphabetially in the provided .bib file. |
