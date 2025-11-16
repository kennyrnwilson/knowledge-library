# Windows (Native) Node.js + npm — Complete Reference (Standalone Only)

> Scope: **Standard Windows installs** (outside WSL) using the official Node.js MSI installer. This guide focuses on **user-local installs** and avoids admin-level installs for safer permission handling.

**Part of:** [Node.js Resources](./README.MD) → [Software Development](../README.MD) → [Professional](../../README.md) → [Literature Notes](../../../README.md)

---

## Recommended Install (User-Local)

* Download the **Windows Installer (.msi)** from [nodejs.org](https://nodejs.org/)
* Run the installer, keep defaults checked:

  * Installs Node.js & npm under `C:\Program Files\nodejs\`
  * Adds Node.js & npm to your **user PATH** (no admin rights required)
  * Installs npm alongside Node.js

> ⚠️ **Recommendation:** Use a **user-local install** and avoid requiring administrator privileges. This keeps global packages and executables under your user profile, avoiding permission issues.

---

## Installation Locations

| Component                        | Path                                                                   |
| -------------------------------- | ---------------------------------------------------------------------- |
| **Node.js & npm executables**    | `C:\Program Files\nodejs\` (contains `node.exe`, `npm.cmd`, `npx.cmd`) |
| **Global npm executables (bin)** | `C:\Users\kenne\AppData\Roaming\npm\`                                  |
| **Global npm packages**          | `C:\Users\kenne\AppData\Roaming\npm\node_modules\`                     |
| **npm cache**                    | `C:\Users\kenne\AppData\Local\npm-cache\`                              |
| **User npm config (optional)**   | `C:\Users\kenne\.npmrc`                                                |

---

## PATH Setup

The installer adds the following to your **user PATH**:

* `C:\Program Files\nodejs\`
* `C:\Users\kenne\AppData\Roaming\npm`

Check with:

```powershell
[Environment]::GetEnvironmentVariable('Path','User')
where.exe node
where.exe npm
[Environment]::GetEnvironmentVariable('Path','User')
```

Expected output:

* `where.exe node` → `C:\Program Files\nodejs\node.exe`
* `where.exe npm` → `C:\Program Files\nodejs\npm.cmd`

---

## Global Package Behavior

When you run:

```powershell
npm install -g typescript
```

| Item                     | Location                                                      |
| ------------------------ | ------------------------------------------------------------- |
| Installed package folder | `C:\Users\kenne\AppData\Roaming\npm\node_modules\typescript\` |
| Executable shim          | `C:\Users\kenne\AppData\Roaming\npm\tsc.cmd`                  |

Check with:

```powershell
npm root -g
where.exe tsc
```

### Global prefix (what it is and why it matters)

npm installs global packages under the directory defined by the `prefix` configuration. Concretely:

- Global modules folder: `<prefix>\node_modules` (shown by `npm root -g`)
- Global executable shims: on Windows these are placed directly in `<prefix>` (for example `tsc.cmd`), so the prefix directory must be on your `PATH` for executables to be discoverable.

What `npm root -g` does:

- `npm root -g` is a diagnostic command that prints the absolute path to the global `node_modules` directory currently used by npm.
- In other words, it reveals the `<prefix>\node_modules` folder for the active npm configuration.
- This is where all globally installed packages are stored (for example, `typescript`, `eslint`, etc.).
- Use `npm bin -g` to show where global executable shims (like `tsc.cmd`) are placed — this is typically the parent directory of what `npm root -g` returns.
- Example:

```powershell
# show the global modules folder and the global bin folder
npm root -g
npm bin -g
```

- With `nvm-windows` these commands will reflect the active Node version's globals (each version keeps its own global folder), so switching versions changes the values returned by `npm root -g` and `npm bin -g`.

Default `prefix` values on Windows:

- Standalone Node MSI installs typically use `%APPDATA%\npm` (for example `C:\Users\<you>\AppData\Roaming\npm`).
- With `nvm-windows`, each Node version keeps its own globals under the version folder; changing a global `prefix` is usually not recommended when using `nvm-windows`.

Why this matters:

- If `prefix` points to a system folder (for example `C:\Program Files\nodejs`) you will usually need administrator rights to install global packages.
- Pointing `prefix` at a folder you control (for example `C:\dev\npm-global`) avoids permission errors and keeps global tools under your user account.

Commands to inspect and change `prefix`:

```powershell
# show effective prefix
npm config get prefix

# show where global modules live
npm root -g

# change prefix (writes to user npmrc by default)
npm config set prefix "C:\dev\npm-global"

# newer npm supports explicit location when setting
npm config set prefix "C:\dev\npm-global" --location=user
```

Updating PATH so global shims are found

After changing `prefix`, ensure the prefix folder is on your user `PATH`. A safe PowerShell method is:

```powershell
$old = [Environment]::GetEnvironmentVariable('Path','User')
[Environment]::SetEnvironmentVariable('Path', "$old;C:\dev\npm-global", 'User')
```

Open a new terminal for the change to take effect. `setx` can also be used but may truncate long PATH values on some systems.

Notes and best practices:

- Prefer keeping per-version globals when using `nvm-windows` rather than globally changing `prefix`.
- After changing `prefix` you may need to reinstall global packages so their shims are created in the new location.
- When troubleshooting, run `npm config ls -l` to see the merged configuration and where each value originated.

---

## npm Cache

The npm cache is a local storage directory where npm keeps copies of downloaded packages to speed up future installations.

Location: `C:\Users\kenne\AppData\Local\npm-cache\`

What it does:

- Stores compressed copies of all packages you've ever installed (both local and global).
- When you install a package, npm first checks the cache before downloading from the registry.
- Significantly speeds up repeated installs across different projects.
- Prevents re-downloading the same package version multiple times.

Common cache commands:

```powershell
# Show cache location
npm config get cache

# Verify cache integrity (checks for corruption)
npm cache verify

# Clear the entire cache (useful for troubleshooting)
npm cache clean --force
```

Notes:

- The cache is managed automatically by npm — you rarely need to interact with it.
- npm periodically runs garbage collection to remove old/unused cached packages.
- Clearing the cache is safe but will slow down the next package install as npm re-downloads everything.
- Cache corruption is rare but can cause install failures; running `npm cache verify` or `npm cache clean --force` can resolve these issues.

---

## npx on Windows (Standalone)

* **Local-first:** If a project has `node_modules\.bin\<tool>.cmd`, `npx <tool>` runs that version.
* **Global fallback:** Uses globally installed tools if no local copy.
* **On-demand:** If not found, downloads a temporary copy.

Example:

```powershell
npm i -D prettier
npx prettier --version   # runs the project’s local Prettier
```

---

## Environment Variables

| Variable            | Purpose                                  | Typical Value                                                    |
| ------------------- | ---------------------------------------- | ---------------------------------------------------------------- |
| `PATH`              | Makes Node/npm and global bins available | `C:\Program Files\nodejs\`; `C:\Users\kenne\AppData\Roaming\npm` |
| `NODE_PATH`         | Extra module lookup path (optional)      | *(unset by default)*                                             |
| `NPM_CONFIG_PREFIX` | Custom global prefix (optional)          | e.g., `C:\dev\npm-global`                                        |

Check with:

```powershell
npm config get prefix
npm config get cache
```

---

## Diagnostics & Verification

| Command                                   | Purpose                              | Expected Result                                         |
| ----------------------------------------- | ------------------------------------ | ------------------------------------------------------- |
| `where.exe node`                              | Shows location of Node executable    | `C:\Program Files\nodejs\node.exe`                      |
| `where.exe npm`                               | Shows location of npm wrapper        | `C:\Program Files\nodejs\npm.cmd`                       |
| `node -v`                                 | Prints installed Node.js version     | e.g. `v20.x.x`                                          |
| `npm -v`                                  | Prints installed npm version         | e.g. `10.x.x` or `11.x.x`                               |
| `npm root -g`                             | Shows global node\_modules directory | `C:\Users\kenne\AppData\Roaming\npm\node_modules`       |
| `npm config get prefix`                   | Shows global installation prefix     | `C:\Users\kenne\AppData\Roaming\npm` (or custom prefix) |
| `npm config get cache`                    | Shows npm cache location             | `C:\Users\kenne\AppData\Local\npm-cache`                |
| `npm list -g --depth=0`                   | Lists globally installed packages    | A list of package names and versions                    |
| `where.exe tsc` (after installing typescript) | Shows global executable location     | `C:\Users\kenne\AppData\Roaming\npm\tsc.cmd`            |

---

## Best Practices

* Prefer user-local installs to avoid permission issues.
* Use `npx` to run one-off tools without polluting global installs.
* Optionally set a custom global prefix to keep global tools in a separate folder:

```powershell
npm config set prefix "C:\\dev\\npm-global"
setx PATH "$([Environment]::GetEnvironmentVariable('Path','User'));C:\\dev\\npm-global"
```

---

## Quick Reference Table

| Item           | Path                                               |
| -------------- | -------------------------------------------------- |
| Node.exe       | `C:\Program Files\nodejs\node.exe`                 |
| npm / npx      | `C:\Program Files\nodejs\npm.cmd`, `npx.cmd`       |
| Global bin     | `C:\Users\kenne\AppData\Roaming\npm\`              |
| Global modules | `C:\Users\kenne\AppData\Roaming\npm\node_modules\` |
| npm cache      | `C:\Users\kenne\AppData\Local\npm-cache\`          |
| npmrc (user)   | `C:\Users\kenne\.npmrc`                            |

---

## Related Resources

- [Node.js Resources Overview](./README.MD) - Overview of all Node.js reference materials
- [Software Development](../README.MD) - Software development guides and references
- [Professional Learning](../../README.md) - Professional development and career resources

## Navigation

- 🔗 [Node.js](./README.MD) - Up to Node folder
- 🔗 [Software Development](../README.MD) - Up to Software Development
- 🔗 [Professional](../../README.md) - Up to Professional resources
- 🔗 [Literature Notes](../../../README.md) - Up to Literature Notes home

---

*Last updated: 2025-11-14*
