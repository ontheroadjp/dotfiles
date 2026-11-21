# fzf.zsh

## Purpose and integration

Provides fzf-based shell helpers and ZLE widgets. The history widgets are registered in the vi insert keymap (`home/zsh/zsh.d/core/fzf.zsh:334-368`).

## History selection

`Ctrl+h` lists history local to the current shell process using `fc -IL`; the flags exclude imported and startup history. `Ctrl+Shift+h` selects from the shared history available to the shell. Both searches retain the existing exclusion of `git commit -m` entries and remove duplicate lines. The selected command replaces the editing buffer; cancellation preserves it. Either shortcut aborts the fzf selector (`home/zsh/zsh.d/core/fzf.zsh:336-365`).

The shared-history binding accepts `ESC` followed by `Ctrl+h` as well as the CSI-u sequences listed in the source. A terminal must send a distinguishable sequence for `Ctrl+Shift+h`; the user's Alacritty configuration maps it to `ESC` + `Ctrl+h`. This sequence is also used by `Alt+Ctrl+h`. The terminal configuration is maintained outside this repository (`home/zsh/zsh.d/core/fzf.zsh:362-368`).
