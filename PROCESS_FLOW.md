# ssh-wunderbar Process Flow Documentation

## 🔄 Complete Process Overview

### 1. Installation via dotfiles

```bash
./install.sh
├── Step 4.5: SSH Management Tool
│   ├── IF ssh-wunderbar exists: Update? (y/n)
│   └── ELSE: Install ssh-wunderbar? (y/n)
│       ├── Where to install?
│       │   ├── 1) /usr/local/bin (system-wide, needs sudo)
│       │   ├── 2) ~/.local/bin (user-only)
│       │   └── 3) ~/dotfiles/bin (with dotfiles)
│       └── Download & install ssh-wunderbar + test.sh
└── Step 8: SSH Configuration
    └── Configure SSH keys and servers? (y/n)
        ├── Create ~/.ssh-services.json if not exists
        └── Launch: ssh-wunderbar (interactive)
```

### 2. SSH Services Configuration File

**Location:** `~/.ssh-services.json`

```json
{
  "_comment": "SSH Services Configuration",
  "_managed_by": "ssh-wunderbar",
  "version": "1.0",
  "services": {
    "service-name": {
      "type": "server|git",
      "hostname": "server.com",
      "user": "username", 
      "port": 22,
      "description": "Description"
    }
  },
  "settings": {
    "default_key_type": "ed25519",
    "auto_backup_config": true,
    "cleanup_old_keys": false,
    "key_rotation_days": 365
  }
}
```

### 3. ssh-wunderbar Interactive Flow

```bash
ssh-wunderbar (no args)
├── Load ~/.ssh-services.json
├── IF no services:
│   ├── "No services configured yet"
│   ├── 1) Add new service → BROKEN (calls non-existent function)
│   └── 2) Exit
└── ELSE: Show service menu
    ├── List all services from JSON
    ├── 1) service1 - Setup SSH for service1
    ├── 2) service2 - Setup SSH for service2  
    ├── N) Add new service
    ├── N+1) Setup all services
    └── N+2) Exit
```

### 4. Service Setup Process

```bash
Setup Service "example"
├── Load service config from JSON
├── Show SSH Key Selection Menu:
│   ├── List existing keys from ~/.ssh/
│   │   ├── 1) existing_key1_ed25519
│   │   ├── 2) existing_key2_ed25519
│   │   └── ...
│   ├── N) Generate new key for service
│   ├── N+1) Import key from clipboard
│   ├── N+2) Back to service menu
│   └── N+3) Cancel/Exit
├── User selects key option
├── Configure SSH config entry
├── Ask: Try to copy key to server? (y/n)
│   ├── IF yes: Run ssh-copy-id (or simulate in test mode)
│   └── IF no: Show manual instructions
└── Return to service menu or exit
```

### 5. File Locations & Structure

```
System Files:
├── /usr/local/bin/ssh-wunderbar      # Main executable (if system install)
├── /usr/local/bin/test.sh            # Test mode runner
├── ~/.local/bin/ssh-wunderbar        # Alt: user install
└── ~/dotfiles/bin/ssh-wunderbar      # Alt: dotfiles install

User Configuration:
├── ~/.ssh-services.json              # Services configuration
├── ~/.ssh/config                     # SSH client config (modified)
├── ~/.ssh/service_ed25519            # Private keys
├── ~/.ssh/service_ed25519.pub        # Public keys
└── ~/.ssh/config.backup.*            # Backups

Test Mode:
├── ./test-output/                    # Test directory
├── ./test-output/.ssh/config         # Test SSH config
├── ./test-output/.ssh/service_ed25519 # Mock keys
└── ./test-output/operations.log      # Test log
```

### 6. Command Line Usage

```bash
# Interactive mode
ssh-wunderbar

# Setup specific service
ssh-wunderbar servicename

# Non-interactive setup  
ssh-wunderbar servicename hostname user port

# Service management
ssh-wunderbar --add-service name host user port [description]
ssh-wunderbar --remove-service name
ssh-wunderbar --list
ssh-wunderbar --setup-all
ssh-wunderbar --help

# Test mode
./test.sh                    # Interactive test
./test.sh --clean            # Clean previous test
./test.sh servicename        # Test specific service
```

## 🐛 Current Known Issues

1. **MAJOR:** `add_service_interactive` function doesn't exist
   - Called from empty services menu
   - Breaks first-time user experience

2. **MAJOR:** User services got deleted during template fix
   - `.ssh-services.json` was removed 
   - All configured services lost

3. **Design Issue:** Confusing service vs key selection
   - Users think they're choosing services
   - Actually choosing keys for a specific service

4. **Template Issue:** Auto-includes GitHub without asking
   - FIXED: Now creates empty services object

## 🔧 Immediate Fixes Needed

1. **Create missing function or fix call**
2. **Better empty-state handling** 
3. **Service restoration process**
4. **Clearer UX flow documentation**

## 🎯 User Journey (Intended)

1. Install dotfiles → ssh-wunderbar installed automatically
2. Run install.sh → SSH Configuration step
3. First time: Empty services → Add your servers
4. Configure keys for each server
5. Use ssh-wunderbar anytime to manage more servers

## 🤦‍♂️ What Actually Happens

1. Install dotfiles → ssh-wunderbar installed ✅
2. Run install.sh → SSH Configuration step ✅  
3. First time: Template with GitHub (confusing) ❌
4. OR: Empty services → Broken "Add service" function ❌
5. User frustrated and gives up ❌

**This documentation written because I clearly lost track of my own code! 😡**