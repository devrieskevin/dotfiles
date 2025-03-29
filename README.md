# Dotfiles

## Stow

The dotfiles are currently mostly managed on my current workspace using [GNU Stow](https://www.gnu.org/software/stow/).

The way to use stow in a general sense for these dotfiles would be using the following example command:

```bash
stow --dir=path/to/dotfiles/project --target=$HOME path/to/dotfiles/project
```

Since by default the stow directory is taken to be the current directory and the target directory is taken to be the parent of the stow directory,
in the case this project is placed in `~/dotfiles` and we want to stow all dotfiles in this project into the dotfiles of the home directory,
we can simplify this to the following commands:

```bash
pushd ~/dotfiles
stow .
popd
```

The `pushd` and `popd` commands are optional and may be replaced by navigating to `~/dotfiles` using `cd` or an equivalent command.

Checking for conflicts using the `--simulate` option may be preferable before running stow on the dotfiles, but might not be strictly needed as Stow does not delete nything that it doesn't own.
This means that Stow will not delete plain files or symlinks that do not point to files in the stow directory.
