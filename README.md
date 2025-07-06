# Jordan Steinke's NixOS & Home-Manager config

A declarative system configuration using NixOS flakes with Home-Manager integration.

## 🖥️ Configurations

| Host | Hardware | Purpose | Features |
|------|----------|---------|----------|
| **desktop-jordan** | HP-Z800 | Workstation & lab node | Full encryption, Searx, Radicale, Stylix |
| **laptop-jordan** | Framework 7640U | Portable workstation | Full encryption, Stylix, optimized for mobile |
| **webserver** | QEMU VM | Web hosting | Minimal, no encryption, server-focused |
| **iso** | Live USB/DVD | Installation media | Portable environment with essential tools, Stylix |

## 📁 Structure

```
├── configurations/          # Host-specific configurations
│   ├── desktop-jordan/     # HP-Z800 workstation config
│   ├── laptop-jordan/      # Framework laptop config
│   ├── webserver/          # Web server VM config
│   └── iso/                # Installation ISO config
├── modules/
│   ├── home-manager/       # User environment modules
│   │   ├── common.nix      # Shared home settings (git, nvim, zsh, etc.)
│   │   ├── gui.nix         # GUI-specific home settings (firefox, i3, etc.)
│   │   └── ...             # Individual module files
│   └── nixos/              # System-level modules
│       ├── common.nix      # Universal system settings
│       ├── gui.nix         # GUI system settings (X11, styling, etc.)
│       ├── japanese.nix    # Japanese input and fonts
│       └── ...             # Service-specific modules
├── secrets/                # Encrypted secrets (sops-nix)
├── flake.nix              # Main flake configuration
└── flake.lock             # Locked dependency versions
```

## ✨ Key Features

### Architecture
- **Flake-based configuration** with shared modules across hosts
- **Home-Manager as NixOS module** for integrated user environment management
- **mkHost helper function** in flake.nix reduces configuration repetition
- **Modular design** with common modules for shared system and GUI settings

### Security & Storage
- **Declarative disk configuration** using [nix-community/disko](https://github.com/nix-community/disko) for reproducible partitioning
- **Full disk encryption** with LUKS on desktop-jordan and laptop-jordan
- **Btrfs subvolumes** with compression and optimized mount options
- **Secrets management** via sops-nix with GPG encryption
- **Automated backups** using Borg with encrypted repositories

### Desktop Environment
- **i3wm** window manager with custom keybindings
- **Stylix theming** for consistent system-wide appearance (desktop-jordan, laptop-jordan, iso)
- **Kitty terminal** with integrated theming
- **Neovim** with LSP support and completion
- **Firefox** with privacy-focused configuration

### Services
- **Searx** private search engine (desktop-jordan only)
- **Radicale** CalDAV/CardDAV server (desktop-jordan only)
- **Dropbox** file synchronization where configured

## 🔐 Secrets Management

- `secrets/common/` - Shared secrets (backup credentials, SSH keys)
- `secrets/desktop-jordan/` - Host-specific secrets (SSL certs, service passwords)

## 📄 License

Available under the MIT License. See [LICENSE](LICENSE) for details.