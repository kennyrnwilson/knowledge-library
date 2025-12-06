# Git Auto-Push Documentation

Automatic git commit and push system for the knowledge-library project.

## Overview

This system automatically commits and pushes your changes to GitHub without requiring any VS Code extensions. It uses simple bash scripts and can run in the background.

## Files Created

- `auto-push.sh` - Manual commit and push (run on demand)
- `watch-and-push.sh` - Background watcher (monitors for changes every 10 seconds)
- `git-auto.sh` - Manager script (start/stop/status)

## Quick Start

### Start Auto-Push Watcher

```bash
./git-auto.sh start
```

This will:
- Start monitoring for file changes
- Automatically commit and push every 10 seconds if changes are detected
- Run in the background

### Stop Auto-Push Watcher

```bash
./git-auto.sh stop
```

### Check Status

```bash
./git-auto.sh status
```

### View Live Logs

```bash
./git-auto.sh logs
```

Press `Ctrl+C` to exit log viewer.

## Usage Modes

### Mode 1: Automatic Background Watcher

**Best for:** Active work sessions where you're making frequent changes

```bash
# Start watcher when you begin working
./git-auto.sh start

# Work on your files normally
# Changes are automatically committed and pushed every 10 seconds

# Stop watcher when done
./git-auto.sh stop
```

### Mode 2: Manual Push

**Best for:** Occasional updates or when you want control over commits

```bash
# Make your changes
# When ready to commit and push:
./auto-push.sh
```

### Mode 3: VS Code Task

**Best for:** Running from within VS Code

1. Press `Ctrl+Shift+P`
2. Type "Tasks: Run Task"
3. Choose either:
   - "Git: Auto Commit and Push" (one-time)
   - "Git: Start Auto-Push Watcher" (background)

## Configuration

### Change Check Interval

Edit `watch-and-push.sh` and change:

```bash
SLEEP_INTERVAL=10  # Change to desired seconds
```

### Customize Commit Messages

Edit `auto-push.sh` or `watch-and-push.sh` and modify:

```bash
COMMIT_MSG="Auto-save: $TIMESTAMP"
```

### Auto-Save in VS Code

Already configured in `.vscode/settings.json`:
- Files auto-save after 1 second of inactivity
- `files.autoSave: "afterDelay"`
- `files.autoSaveDelay: 1000`

## Troubleshooting

### Watcher won't start

Check if already running:
```bash
./git-auto.sh status
```

If stuck, force stop and restart:
```bash
pkill -f watch-and-push.sh
rm /tmp/git-auto-push.pid
./git-auto.sh start
```

### Changes not being pushed

Check logs:
```bash
./git-auto.sh logs
```

Common issues:
- Git credentials not configured
- Network connection issues
- Merge conflicts

### Too many commits

Increase the `SLEEP_INTERVAL` in `watch-and-push.sh` to reduce frequency (e.g., set to 60 for once per minute).

## Tips

1. **Start watcher on boot:** Add to your shell startup file:
   ```bash
   cd /home/kenne/projects/knowledge-library && ./git-auto.sh start
   ```

2. **Create an alias:**
   ```bash
   # Add to ~/.bashrc
   alias kb-auto='cd /home/kenne/projects/knowledge-library && ./git-auto.sh'

   # Then use:
   kb-auto start
   kb-auto stop
   kb-auto status
   ```

3. **View commit history:**
   ```bash
   git log --oneline -20
   ```

## Security Note

This system pushes to GitHub automatically. Ensure:
- You have SSH keys configured (no password prompts)
- You're comfortable with automatic commits
- Sensitive files are in `.gitignore`

## Advanced: Running at System Startup

To start the watcher automatically when your system boots, add to your `~/.bashrc`:

```bash
# Auto-start git watcher for knowledge-library
if [ -d "/home/kenne/projects/knowledge-library" ]; then
    cd /home/kenne/projects/knowledge-library && ./git-auto.sh start > /dev/null 2>&1
fi
```
