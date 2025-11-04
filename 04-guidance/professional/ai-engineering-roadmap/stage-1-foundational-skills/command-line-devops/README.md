# 1.5 Command Line & DevOps Basics

Master the terminal and basic deployment concepts.

---

## 📚 What You'll Learn

- **Terminal Basics**: File navigation, file viewing and editing, piping and redirection, permissions and ownership
- **Shell Scripting Basics**: Script basics, variables and control flow, useful commands for scripts
- **Understanding Servers**: Client-server architecture, ports and networking, SSH and remote connections, environment variables
- **Deployment Basics**: Deployment platforms, deploying a simple application, environment configuration, logs and debugging, basic monitoring

---

## 🔗 Learning Resources

### Related Areas
- [1.4 Web Development & APIs](../web-development-apis/README.md)
- [1.6 Math Foundations](../math-foundations/README.md)
- [Stage 1 Overview](../README.md)

---

## Terminal Basics

The command line is your direct interface with your computer.

### File Navigation

- [ ] **pwd** (print working directory)
- [ ] **ls/la** (list files and directories)
- [ ] **cd** (change directory)
- [ ] **mkdir** (create directory)
- [ ] **cp** (copy files/directories)
- [ ] **mv** (move/rename files)
- [ ] **rm/rmdir** (remove files/directories)

**Practice:** Complete 10+ file operations

### File Viewing and Editing

- [ ] **cat** (view file contents)
- [ ] **head/tail** (view beginning/end of file)
- [ ] **less/more** (scroll through files)
- [ ] **nano/vim** (text editors)
- [ ] **grep** (search file contents)
- [ ] **find** (search for files)

**Practice:** View and search through files

### Piping and Redirection

- [ ] **Standard streams** (stdin, stdout, stderr)
- [ ] **Piping** (|) - chain commands
- [ ] **Redirection** (>, >>) - write to files
- [ ] **Input redirection** (<)
- [ ] **Command substitution** ($())

**Practice:** Chain 5+ commands with pipes

### Permissions and Ownership

- [ ] **ls -l** (understand permissions)
- [ ] **chmod** (change permissions)
- [ ] **chown** (change ownership)
- [ ] **sudo** (run as administrator)
- [ ] **User and group basics**

**Practice:** Modify permissions on multiple files

---

## Shell Scripting Basics

Automating repetitive tasks saves time.

### Script Basics

- [ ] **Create .sh file**
- [ ] **Add shebang** (#!/bin/bash)
- [ ] **Make executable** (chmod +x)
- [ ] **Run scripts**
- [ ] **Arguments** ($1, $2, $@)

**Practice:** Create 3+ executable scripts

### Variables and Control Flow

- [ ] **Create variables** (VAR="value")
- [ ] **Use variables** ($VAR)
- [ ] **If statements** (if/then/else)
- [ ] **For loops** (iterate over items)
- [ ] **While loops** (conditional loops)

**Practice:** Write scripts with loops and conditions

### Useful Commands for Scripts

- [ ] **echo** (print output)
- [ ] **read** (get user input)
- [ ] **test** (conditionals)
- [ ] **grep** (search text)
- [ ] **awk/sed** (text processing)

**Practice:** Build utility scripts

---

## Understanding Servers

How internet servers actually work.

### Client-Server Architecture

- [ ] **Understand client-server model**
- [ ] **HTTP requests and responses**
- [ ] **Web servers** (Apache, Nginx)
- [ ] **Server processes** (listening on ports)
- [ ] **Stateless vs stateful** services

**Practice:** Trace request/response cycle

### Ports and Networking

- [ ] **localhost (127.0.0.1)**
- [ ] **Port numbers** (80, 443, 8000, etc.)
- [ ] **Start local server** (python -m http.server)
- [ ] **Test with curl/Postman**
- [ ] **Network interfaces** (0.0.0.0, 127.0.0.1)

**Practice:** Run servers on different ports

### SSH and Remote Connections

- [ ] **SSH basics** (connect to remote server)
- [ ] **Generate SSH keys** (public/private)
- [ ] **SSH without password** (key auth)
- [ ] **SCP** (secure copy)
- [ ] **Basic server administration**

**Practice:** Connect to and manage remote server

### Environment Variables

- [ ] **Set environment variables** (export VAR=value)
- [ ] **Use in Python** (os.environ)
- [ ] **Store secrets** in env variables
- [ ] **Different configs** (dev/prod)
- [ ] **.env files** (python-dotenv)

**Practice:** Use environment variables in 3+ applications

---

## Deployment Basics

Getting code to production is a core skill.

### Deployment Platforms

- [ ] **Heroku** (Platform-as-a-Service)
- [ ] **Railway.app** (modern Heroku alternative)
- [ ] **Render** (static + dynamic hosting)
- [ ] **VPS options** (DigitalOcean, Linode)
- [ ] **AWS basics** (EC2, S3, Lambda)

**Practice:** Compare deployment options for your use case

### Deploying a Simple Application

- [ ] **Prepare code** (requirements.txt, Procfile)
- [ ] **Push to Git repository**
- [ ] **Connect platform** to repository
- [ ] **Deploy** (automatic from Git)
- [ ] **Monitor** deployment

**Practice:** Deploy FastAPI app to Heroku/Railway

### Environment Configuration

- [ ] **Set environment variables** on platform
- [ ] **Manage secrets** (API keys, passwords)
- [ ] **Different configs** (dev/staging/prod)
- [ ] **Database setup** on platform
- [ ] **Domain configuration** (custom domains)

**Practice:** Configure 3+ deployed applications

### Logs and Debugging

- [ ] **View application logs**
- [ ] **Stream logs** in real-time
- [ ] **Search logs** for errors
- [ ] **Add logging** to application
- [ ] **Debug production issues**

**Practice:** Debug issues in deployed application

### Basic Monitoring

- [ ] **Monitor uptime** (status pages)
- [ ] **CPU and memory** usage
- [ ] **Error rate** tracking
- [ ] **Response time** monitoring
- [ ] **Alerts** for issues

**Practice:** Set up monitoring for deployed app

---

## ✅ Learning Checklist

- [ ] Navigate filesystem with terminal
- [ ] Write shell scripts
- [ ] Understand ports and networking
- [ ] Use SSH for remote access
- [ ] Deploy application to internet
- [ ] Manage environment variables

---

*Last updated: 2025-11-03*
