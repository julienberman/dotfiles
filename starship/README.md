### Starship config

Make sure that starship is initialized in terminal.


~/.bashrc:
```
eval "$(starship init bash)"
```

~/.zshrc:
```
eval "$(starship init zsh)"
```

To ensure that the conda environment does not display in the terminal prompt twice, add this command to either ~/.bashrc or ~/.zshrc:
```
conda config --set changeps1 false
```


