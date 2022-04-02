# Debian Bootstrap

A simple script to install essential tools for my works

## How to use

```bash
./bootstrap.sh -h
```

```bash
Optional arguments for custom use:
      -i: install something (support: chrome, vscode, latex, ibus, zsh, git, curl, buildtools, fnm, wget, suckless, flameshot )
      -u: update something (support: dwm, dwmblock, dmenu)
      -h: Show this message
```

### Install a tool

```bash
./bootstrap -i vscode
```

### Update a tool

```bash
./bootstrap -u dwm
```
