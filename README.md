# dotfiles

Personal configuration files, managed as a **bare Git repository** whose work tree is `$HOME`.
Files are tracked at their real paths (`~/.zshrc`, `~/.config/nvim/...`), so there are no symlinks and no install script.

## What's inside

| Path | Tool |
|---|---|
| `.zshrc`, `.aliases.zsh` | Zsh (Oh My Zsh + Starship) |
| `.gitconfig` | Git (uses `gh` as credential helper) |
| `.config/nvim/` | Neovim (lazy.nvim) |
| `.config/vim/`, `.ideavimrc` | Vim / IdeaVim |
| `.config/tmux/` | tmux (TPM, catppuccin) |
| `.config/kitty/`, `.config/alacritty/` | Terminals |
| `.config/hypr/`, `.config/waybar/`, `.config/swaync/` | Hyprland desktop (hyprlock, hyprpaper, bar, notifications) |
| `.config/yazi/`, `.config/vifm/` | File managers |
| `.config/btop/`, `.config/bashtop/` | System monitors |
| `Pictures/wallpapers/` | Wallpapers |

## Install on a new machine

```bash
# 1. Clone as a bare repo
git clone --bare https://github.com/Krruddy/dotfiles.git "$HOME/.dotfiles"

# 2. Define the helper alias for this shell (it's also in .aliases.zsh)
alias config='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'

# 3. Hide all the other files in $HOME from `config status`
config config --local status.showUntrackedFiles no

# 4. Back up any existing files that would be overwritten
mkdir -p "$HOME/.dotfiles-backup"
config checkout 2>&1 | grep -E '^\s+' | awk '{print $1}' | \
  xargs -I{} sh -c 'mkdir -p "$HOME/.dotfiles-backup/$(dirname "{}")" && mv "$HOME/{}" "$HOME/.dotfiles-backup/{}"'

# 5. Check out the files into $HOME
config checkout
```

If step 5 still reports conflicting files, move them out of the way and run it again.

## Dependencies

Install these with your package manager before opening a new shell. The configs target Arch Linux (the `archlinux` Oh My Zsh plugin and the `update` alias assume a specific distro, so adjust them for yours).

- **Shell:** `zsh`, `starship`, `lsd`, `bat`, `fzf`, `zoxide`
- **Editors:** `neovim`, `git`, `gh`
- **Terminal / multiplexer:** `kitty` or `alacritty`, `tmux`
- **Files / monitoring:** `yazi`, `vifm`, `btop`
- **Desktop (optional):** `hyprland`, `hyprlock`, `hyprpaper`, `waybar`, `swaync`
- **Optional:** `nvm`, `pass-cli` (Proton Pass). Comment out their lines in `.zshrc` if you don't use them.

### Oh My Zsh and its plugins

```bash
# Oh My Zsh, keeping the tracked .zshrc
RUNZSH=no KEEP_ZSHRC=yes sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# Third-party plugins referenced in .zshrc
ZSH_CUSTOM="${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}"
git clone https://github.com/zsh-users/zsh-syntax-highlighting "$ZSH_CUSTOM/plugins/zsh-syntax-highlighting"
git clone https://github.com/zsh-users/zsh-autosuggestions     "$ZSH_CUSTOM/plugins/zsh-autosuggestions"

# Make zsh the login shell
chsh -s "$(command -v zsh)"
```

### tmux plugins

```bash
git clone https://github.com/tmux-plugins/tpm ~/.config/tmux/plugins/tpm
git clone https://github.com/catppuccin/tmux.git ~/.config/tmux/plugins/catppuccin/tmux
```

Then start tmux and press `prefix` + `I` (prefix is `Ctrl+Space`) to install the remaining plugins.

### Neovim

Open `nvim` once. lazy.nvim installs the plugins, and Mason installs the LSP servers and tools.

### Yazi

```bash
ya pkg install    # installs the plugins pinned in package.toml
```

## Day-to-day usage

Use `config` exactly like `git`:

```bash
config status
config add ~/.config/nvim/lua/mappings.lua
config commit -m "nvim: update mappings"
config push
```

Pull updates on another machine with `config pull`.

## Known gaps

- `.config/nvim/init.lua` requires `config.lazy`, but `.config/nvim/lua/config/lazy.lua` isn't tracked. Add it (`config add`) or Neovim will fail at startup.
- `.zshrc` sets `STARSHIP_CONFIG=~/.config/starship/starship.toml`, which isn't tracked. Starship falls back to its defaults.
- The `sz` alias uses `$ZSHELL_CONFIG`, which isn't defined anywhere.
