# 🎉 ssh-wunderbar

**SSH engineering with wunderbar feeling!**

Transform SSH chaos into organized infrastructure bliss. German precision meets developer happiness.

---

## ✨ Why ssh-wunderbar?

SSH configuration shouldn't be a chore. Whether you're managing 3 servers or 30, ssh-wunderbar makes it **wunderbar**:

- 🔑 **Smart Key Management** - Automatic key type detection (ED25519/RSA/ECDSA)
- 📋 **JSON-Driven Config** - Your infrastructure as code
- 🚀 **Modern CLI** - Built like the tools you love (Docker, Git, npm)
- 🏗️ **Atomic Operations** - Everything works or nothing changes
- 👥 **Team Ready** - Share configs, onboard developers instantly
- 🔄 **Key Rotation** - Security best practices made simple

---

## 🚀 Quick Start

```bash
# Get ssh-wunderbar
git clone https://github.com/your-username/ssh-wunderbar.git
cd ssh-wunderbar

# Interactive setup - choose what you want
./ssh-wunderbar

# Or directly setup a service
./ssh-wunderbar github
```

**That's it!** SSH management, made wunderbar! 🎯

---

## 🛠️ Features

### 🎭 Interactive & Non-Interactive
```bash
# Interactive menu
./ssh-wunderbar                              

# From configuration
./ssh-wunderbar github                       # GitHub SSH
./ssh-wunderbar myserver                     # Your custom server

# Non-interactive setup  
./ssh-wunderbar webserver 192.168.1.100 deploy 22

# Service management
./ssh-wunderbar --add-service prod 10.0.0.1 root 22 "Production server"
./ssh-wunderbar --setup-all                  # Configure everything
./ssh-wunderbar --list                       # Show all services
```

### 🔐 Smart Key Management
- **Auto-Detection**: Recognizes ED25519, RSA, ECDSA, DSA key types
- **Smart Naming**: `server_ed25519`, `server_rsa` - always know what you have
- **Key Reuse**: Use existing keys or generate new ones
- **Clipboard Import**: Paste keys directly from other systems

### 🏗️ JSON-Driven Infrastructure
```json
{
  "services": {
    "production": {
      "hostname": "prod.company.com",
      "user": "deploy", 
      "port": 22,
      "description": "Production server"
    },
    "staging": {
      "hostname": "staging.company.com", 
      "user": "deploy",
      "port": 2222,
      "description": "Staging environment"
    }
  }
}
```

### 🔄 Advanced Operations
```bash
# Key rotation with cleanup
./ssh-wunderbar --rotate-keys production

# Remove services
./ssh-wunderbar --remove-service old-server

# Setup entire infrastructure
./ssh-wunderbar --setup-all
```

---

## 📋 How It Works

### 1. **Service Definition** 
Define your servers in `services.json` or add them interactively.

### 2. **Key Selection**
Choose from existing keys or generate new ones. ssh-wunderbar detects key types automatically.

### 3. **Automatic Deployment** 
Keys are deployed via `ssh-copy-id` with connection testing.

### 4. **SSH Config Generation**
Clean, organized `~/.ssh/config` entries with proper aliases.

### 5. **Ready to Connect**
```bash
ssh myserver  # Instead of ssh user@long-hostname.company.com
```

---

## 🎯 Use Cases

### 👨‍💻 **Individual Developer**
```bash
# Quick server access setup
./ssh-wunderbar --add-service homelab 192.168.1.50 pi 22
./ssh-wunderbar homelab
# Now: ssh homelab 
```

### 👥 **Team Onboarding**
```bash
# Share your services.json with the team
git clone company-infrastructure-config
./ssh-wunderbar --setup-all
# Entire team has identical SSH access
```

### 🏢 **Corporate Infrastructure**
```json
{
  "services": {
    "production-web": {"hostname": "web.prod.company.com", "user": "deploy"},
    "production-db": {"hostname": "db.prod.company.com", "user": "postgres"},
    "staging-web": {"hostname": "web.staging.company.com", "user": "deploy"}
  }
}
```

### 🏠 **Homelab Management**
Perfect for managing multiple Raspberry Pis, NAS systems, and home servers.

---

## 🔧 Installation

### Option 1: Git Clone (Recommended)
```bash
git clone https://github.com/your-username/ssh-wunderbar.git
cd ssh-wunderbar
./ssh-wunderbar --help
```

### Option 2: Direct Download
```bash
curl -O https://raw.githubusercontent.com/your-username/ssh-wunderbar/main/ssh-wunderbar
chmod +x ssh-wunderbar
./ssh-wunderbar --help
```

### Option 3: Add to PATH
```bash
# After cloning/downloading
echo 'export PATH="$PATH:/path/to/ssh-wunderbar"' >> ~/.zshrc
source ~/.zshrc
ssh-wunderbar --help
```

---

## 🧪 Test Mode

**Safe testing without modifying your real SSH configuration!**

```bash
# Test without cleaning previous results
./test.sh myserver

# Test with clean slate  
./test.sh --clean myserver

# Add and test service
./test.sh --add-service testbox 192.168.1.100 pi 22
./test.sh testbox
```

### What Test Mode Does
- ✅ **Isolated Environment**: All files in `test-output/`
- ✅ **Mock SSH Keys**: Generated for testing (not real keys)
- ✅ **Simulated Deployment**: No actual server connections
- ✅ **Interactive Testing**: You control all inputs
- ✅ **Operations Log**: Complete audit trail
- ✅ **Preserved Results**: Multiple tests accumulate

### Test Results
```bash
test-output/
├── operations.log          # Complete test log
└── .ssh/
    ├── config             # Generated SSH config
    ├── server_ed25519     # Mock private key
    └── server_ed25519.pub # Mock public key
```

---

## 🎨 Configuration

### Default services.json
```json
{
  "version": "1.0",
  "services": {
    "github": {
      "type": "git",
      "hostname": "github.com",
      "user": "git", 
      "port": 22,
      "description": "GitHub SSH authentication",
      "readonly": true
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

### Adding Your Servers
```bash
# Interactive
./ssh-wunderbar
# → Choose "Add new service"

# Command line
./ssh-wunderbar --add-service myserver 192.168.1.100 user 22 "My server"

# Manual editing
# Edit services.json and add your server definitions
```

---

## 🛡️ Security Features

- **Automatic Backups**: SSH configs backed up before changes
- **Key Rotation**: Generate new keys and clean up old ones
- **Atomic Operations**: Changes are all-or-nothing
- **Permission Management**: Proper file permissions set automatically
- **Connection Testing**: Verify access before marking as complete

---

## 🚨 Troubleshooting

### Command Not Found
```bash
# Make sure script is executable
chmod +x ssh-wunderbar

# Check path if installed globally
which ssh-wunderbar
echo $PATH
```

### Key Import Issues
```bash
# Check key format
cat your-private-key | head -1
# Should show: -----BEGIN OPENSSH PRIVATE KEY----- or similar

# Verify key is valid
ssh-keygen -l -f your-private-key
```

### Connection Problems
```bash
# Test direct connection first
ssh user@hostname

# Check SSH config
./ssh-wunderbar --list

# Verify key deployment
ssh-copy-id -i ~/.ssh/server_ed25519.pub user@hostname
```

### Missing Dependencies
```bash
# ssh-wunderbar requires jq for JSON parsing
brew install jq          # macOS
apt install jq            # Ubuntu/Debian  
yum install jq            # RHEL/CentOS
```

---

## 🤝 Contributing

We love contributions! ssh-wunderbar is built with wunderbar community spirit.

### Development Setup
```bash
git clone https://github.com/your-username/ssh-wunderbar.git
cd ssh-wunderbar

# Test your changes
./ssh-wunderbar --help

# Run with debug
bash -x ./ssh-wunderbar --list
```

### Contribution Guidelines
- 🧪 **Test thoroughly** - SSH access is critical
- 📝 **Document changes** - Keep README updated  
- 🎯 **Focus on UX** - Make it more wunderbar
- 🔒 **Security first** - Never compromise on safety

---

## 📄 License

MIT License - feel free to use, modify, and distribute!

---

## 🎉 Philosophy

### **"Make It Simple"** 
Complex infrastructure shouldn't require complex tools. One command should do what used to take hours.

### **"Wunderbar Experience"**
Tools should bring joy, not frustration. Every interaction should feel smooth and delightful.

### **"German Engineering"**
Precision, reliability, and attention to detail. Built to work correctly every time.

### **"Community First"**
Great tools are built by great communities. Your feedback makes ssh-wunderbar better.

---

## ❤️ Acknowledgments

Inspired by the amazing DevOps community and the need for better SSH management tools. 

**Built with ❤️ for developers who value their time and sanity.**

---

## 🌟 Star History

If ssh-wunderbar made your SSH management wunderbar, consider starring the repo! ⭐

*SSH engineering with wunderbar feeling!* 🇩🇪⚡

---

**Ready to make your SSH setup wunderbar?**

```bash
git clone https://github.com/your-username/ssh-wunderbar.git
cd ssh-wunderbar  
./ssh-wunderbar
```

**Wunderbar awaits!** 🎉🚀