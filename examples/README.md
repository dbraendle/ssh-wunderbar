# 📋 ssh-wunderbar Configuration Examples

Ready-to-use configuration examples for different scenarios.

## 🏠 Homelab Setup (`homelab.json`)

Perfect for managing your home infrastructure:
- **Pi-hole** - DNS filtering
- **Home Assistant** - Smart home automation  
- **NAS** - Network storage
- **Plex** - Media server
- **Router** - OpenWrt/pfSense management

```bash
cp examples/homelab.json services.json
./ssh-wunderbar --setup-all
```

## 🏢 Corporate Infrastructure (`corporate.json`)

Enterprise-ready configuration:
- **Production & Staging** environments
- **Database servers** with dedicated users
- **Bastion/Jump host** with custom port
- **Monitoring & CI/CD** servers
- **Shorter key rotation** (90 days) for security

```bash
cp examples/corporate.json services.json
# Customize hostnames for your company
./ssh-wunderbar --setup-all
```

## 👨‍💻 Developer Setup (`developer.json`)

For individual developers:
- **Multiple Git providers** (GitHub, GitLab)
- **Personal VPS** for projects
- **Development boards** (Raspberry Pi)
- **Work laptop** remote access

```bash
cp examples/developer.json services.json
./ssh-wunderbar --setup-all
```

## 🎯 Usage

1. **Copy example** that matches your needs
2. **Customize hostnames** and usernames
3. **Run setup** - ssh-wunderbar handles the rest!

```bash
# Choose your scenario
cp examples/homelab.json services.json

# Edit for your environment  
nano services.json

# Setup everything
./ssh-wunderbar --setup-all
```

## 🔧 Customization Tips

### Change Default Settings
```json
{
  "settings": {
    "default_key_type": "rsa",        // Use RSA instead of ED25519
    "cleanup_old_keys": true,         // Auto-cleanup old keys
    "key_rotation_days": 30           // Rotate keys monthly
  }
}
```

### Add Your Own Services
```json
{
  "services": {
    "my-server": {
      "hostname": "my-server.example.com", 
      "user": "myuser",
      "port": 2222,
      "description": "My custom server"
    }
  }
}
```

### Security Considerations
- **Corporate**: Use shorter rotation periods
- **Homelab**: Longer periods are usually fine
- **Development**: Balance security with convenience

---

**Ready to make your SSH setup wunderbar?** 🎉