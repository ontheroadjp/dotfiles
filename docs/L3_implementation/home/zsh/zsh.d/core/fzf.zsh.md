# fzf.zsh

## Purpose and integration

Provides fzf-based shell helpers and ZLE widgets. The history widgets are registered in the vi insert keymap (`home/zsh/zsh.d/core/fzf.zsh:334-368`).

## History selection

`Ctrl+h` lists history local to the current shell process using `fc -IL`; the flags exclude imported and startup history. `Ctrl+Shift+h` selects from the shared history available to the shell. Both searches retain the existing exclusion of `git commit -m` entries and remove duplicate lines. The selected command replaces the editing buffer; cancellation preserves it. Either shortcut aborts the fzf selector (`home/zsh/zsh.d/core/fzf.zsh:336-365`).

The shared-history binding accepts `ESC` followed by `Ctrl+h` as well as the CSI-u sequences listed in the source. A terminal must send a distinguishable sequence for `Ctrl+Shift+h`; the user's Alacritty configuration maps it to `ESC` + `Ctrl+h`. This sequence is also used by `Alt+Ctrl+h`. The terminal configuration is maintained outside this repository (`home/zsh/zsh.d/core/fzf.zsh:362-368`).

## 変更履歴（git log より自動生成）

- 63c82586 feat(#74): separate shell history searches
- 7e86e2f1 feat(zsh): add fzf path-copy helpers and rename vim launchers
- 6b239d55 fix(zsh): load zsh core module eagerly and tune fzf history search
- 6604fd02 fix: restore fzf history binding to ^H
- 66bb9d98 fix: restore vi mode with Esc disabled and bind fzf history to ^R
- 922ceaed feat(fzf): add eject helper for external drives
- 4d1bf5cd refactor(fzf): rename fd-based vim fzf helpers and disable rg variants
- 2e16f836 fix: add optional OR search to vimrg
- 0871ea74 fix: support AND search in vimrg
- 619ee8c1 fix: open selected fzf search result in vim
