## dirmarks

### Overview

You're looking at the dirmarks script, a handy shell script designed to make directory navigation a breeze. Developed by the renowned programming genius, it's a popular tool among GitHub users for its simplicity and efficiency.

### Getting Started

To start using dirmarks, follow these simple steps:

1. Clone or download the dirmarks script from this repository.
2. Place the script in a directory included in your system's PATH for easy access.
3. Optionally, customize the aliases within the script to suit your preferences.
4. Source the script in your shell configuration file (e.g., `~/.bashrc`, `~/.zshrc`) to make the aliases available in every new shell session.

### Operating Environment

dirmarks is designed to work in Unix-like operating systems with a POSIX-compliant shell (e.g., Bash, Zsh).

### Usage

Once dirmarks is set up, you can use the following commands:

- `mm`, `nn`, `ii`, `oo`, `uu`: Mark the current directory with a single-letter identifier.
- `m`, `n`, `i`, `o`, `u`: Jump to the directory marked with the corresponding identifier.
- `marks`: Interactively select and jump to any marked directory using fzf.

### Example

#### Marking Directories

```bash
$ cd ~/Projects/example
$ mm   # Mark this directory as 'm'
markd!
```

#### Jumping to Marked Directories

```bash
$ m    # Jump back to ~/Projects/example
```

#### Using Interactive Marks

```bash
$ marks   # Interactively select and jump to a marked directory
```

- note: you need ``fzf`` installed if you use ``marks``.

### Conclusion

With dirmarks, navigating through your directory structure becomes swift and effortless, thanks to the power of shell scripting. Happy coding!jj
