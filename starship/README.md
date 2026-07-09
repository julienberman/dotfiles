## Starship config

Custom shell prompt.

### System dependencies
```bash
brew install starship
```

### Initialization

Add the following commands to either the `~/.bashrc` or `~/.zshrc` files.

To ensure that starship is initialized in terminal:
```bash
eval "$(starship init bash)"
```
or
```bash
eval "$(starship init zsh)"
```
```
```

To ensure that the conda environment does not display in the terminal prompt twice:

```bash
conda config --set changeps1 false
```


