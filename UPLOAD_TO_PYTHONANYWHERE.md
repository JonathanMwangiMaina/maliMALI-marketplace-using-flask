# 🚀 Upload Project to PythonAnywhere - Step-by-Step Guide

## Overview

This guide shows you exactly how to upload the maliMALI marketplace project to PythonAnywhere. Choose the method that works best for you.

---

## 📋 Prerequisites

- [ ] PythonAnywhere account created ([Sign up here](https://www.pythonanywhere.com/registration/register/beginner/))
- [ ] Email verified
- [ ] Logged into PythonAnywhere dashboard

---

## Method 1: Git Clone (Recommended) ⭐

**Best for:** If your project is on GitHub
**Time:** 2 minutes
**Advantages:** Easy updates, version control

### Steps:

1. **Open PythonAnywhere Bash Console**
   - Go to: https://www.pythonanywhere.com/
   - Click **"Consoles"** tab
   - Click **"Bash"** to open a new console

2. **Clone the Repository**
   ```bash
   cd ~
   git clone https://github.com/JonathanMwangiMaina/maliMALI-marketplace-using-flask.git
   ```

3. **Verify Upload**
   ```bash
   cd maliMALI-marketplace-using-flask
   ls -la
   ```

   You should see:
   ```
   app/
   migrations/
   config.py
   main.py
   requirements.txt
   deploy_pythonanywhere.sh
   pythonanywhere_wsgi.py
   PYTHONANYWHERE_DEPLOYMENT.md
   ... (other files)
   ```

4. **Make Deployment Script Executable**
   ```bash
   chmod +x deploy_pythonanywhere.sh
   ```

✅ **Done!** Proceed to running the deployment script.

---

## Method 2: Upload ZIP File

**Best for:** If you don't have Git or prefer manual upload
**Time:** 5 minutes

### Steps:

#### Part A: Create ZIP Archive (On Your Local Machine)

**Option A1: Using Command Line (Mac/Linux)**
```bash
# Navigate to the parent directory containing the project
cd /workspace/claude-workspace/jonathanmainast29_yahoo.com/JonathanMwangiMaina/

# Create ZIP file
zip -r maliMALI-marketplace.zip maliMALI-marketplace-using-flask/ -x "*.git*" "*.pyc" "*__pycache__*" "*.db"
```

**Option A2: Using File Explorer (Windows)**
1. Navigate to `C:\Users\YourName\Projects\` (or wherever your project is)
2. Right-click on `maliMALI-marketplace-using-flask` folder
3. Select **"Send to" > "Compressed (zipped) folder"**
4. Name it: `maliMALI-marketplace.zip`

**Option A3: Using File Explorer (Mac)**
1. Navigate to your project location
2. Right-click on `maliMALI-marketplace-using-flask` folder
3. Select **"Compress"**
4. Rename to: `maliMALI-marketplace.zip`

#### Part B: Upload to PythonAnywhere

1. **Go to Files Tab**
   - Log in to PythonAnywhere
   - Click **"Files"** tab at top

2. **Navigate to Home Directory**
   - You should be at `/home/yourusername/`
   - If not, click **"Home"** in the breadcrumb

3. **Upload ZIP File**
   - Scroll down to **"Upload a file"** section
   - Click **"Choose File"**
   - Select `maliMALI-marketplace.zip`
   - Click **"Upload"**
   - Wait for upload to complete (progress bar)

4. **Extract ZIP File**
   - In the Files tab, find `maliMALI-marketplace.zip`
   - Click on it (opens file viewer)
   - Click **"Extract"** button
   - Wait for extraction to complete

   **OR** use Bash console:
   ```bash
   cd ~
   unzip maliMALI-marketplace.zip
   ```

5. **Verify Extraction**
   - You should see `maliMALI-marketplace-using-flask/` folder
   - Click on it to explore contents

6. **Make Deployment Script Executable**
   - Open a **Bash console**
   - Run:
   ```bash
   cd ~/maliMALI-marketplace-using-flask
   chmod +x deploy_pythonanywhere.sh
   ```

✅ **Done!** Proceed to running the deployment script.

---

## Method 3: Manual File Upload

**Best for:** Small projects or individual file updates
**Time:** 10-15 minutes
**Not Recommended for full deployment** (too many files)

### Steps:

1. **Create Project Directory**
   - Go to **Files** tab
   - Navigate to `/home/yourusername/`
   - Click **"New directory"**
   - Name: `maliMALI-marketplace-using-flask`
   - Click **"Create"**

2. **Upload Files Individually**
   - Navigate into the new directory
   - Use **"Upload a file"** section
   - Upload each file one by one:
     - `config.py`
     - `main.py`
     - `requirements.txt`
     - `deploy_pythonanywhere.sh`
     - `pythonanywhere_wsgi.py`
     - etc.

3. **Create Subdirectories**
   - Create `app/` directory
   - Upload files from `app/` folder
   - Repeat for `migrations/`, etc.

⚠️ **Warning:** This method is tedious and error-prone. Use Method 1 or 2 instead.

---

## Method 4: Using FileZilla/SFTP (Advanced)

**Best for:** Experienced users familiar with SFTP
**Time:** 5 minutes
**Requires:** Paid PythonAnywhere plan (SSH access)

### Prerequisites:
- PythonAnywhere paid account (Hacker plan or higher)
- FileZilla or other SFTP client installed

### Steps:

1. **Get SSH Credentials**
   - Go to **Account** tab in PythonAnywhere
   - Find **SSH access** section
   - Note your hostname: `ssh.pythonanywhere.com`
   - Your username: `yourusername`
   - Your password: (PythonAnywhere account password)

2. **Connect with FileZilla**
   - Host: `sftp://ssh.pythonanywhere.com`
   - Username: `yourusername`
   - Password: (your password)
   - Port: `22`
   - Click **"Connect"**

3. **Upload Project**
   - Navigate to `/home/yourusername/`
   - Drag and drop `maliMALI-marketplace-using-flask` folder
   - Wait for upload to complete

4. **Set Permissions**
   - Open Bash console in PythonAnywhere
   ```bash
   chmod +x ~/maliMALI-marketplace-using-flask/deploy_pythonanywhere.sh
   ```

✅ **Done!** Proceed to running the deployment script.

---

## Verification Checklist

After upload, verify the project structure:

```bash
# In PythonAnywhere Bash console
cd ~/maliMALI-marketplace-using-flask
ls -la
```

**You should see:**
- [ ] `app/` directory
- [ ] `migrations/` directory
- [ ] `config.py`
- [ ] `main.py`
- [ ] `requirements.txt`
- [ ] `deploy_pythonanywhere.sh` (executable)
- [ ] `pythonanywhere_wsgi.py`
- [ ] `PYTHONANYWHERE_DEPLOYMENT.md`
- [ ] `DEPLOYMENT_CHECKLIST.md`
- [ ] `.env.example`

**Check file count:**
```bash
find . -type f | wc -l
```
Should be 40+ files (including migrations)

---

## Common Upload Issues

### Issue 1: "Permission Denied" when running script

**Solution:**
```bash
chmod +x ~/maliMALI-marketplace-using-flask/deploy_pythonanywhere.sh
```

### Issue 2: ZIP extraction fails

**Symptoms:** "Not a zip file" error

**Solutions:**
- Ensure ZIP file uploaded completely (check file size)
- Try extracting via Bash: `unzip maliMALI-marketplace.zip`
- Re-upload if corrupted

### Issue 3: Files missing after upload

**Solution:**
- Check `.gitignore` - some files may not be in Git repo
- Create missing files manually in PythonAnywhere Files tab
- Ensure hidden files included in ZIP (`.env.example`, etc.)

### Issue 4: Git clone fails with authentication error

**For Private Repositories:**
```bash
# Use personal access token
git clone https://yourusername:YOUR_GITHUB_TOKEN@github.com/JonathanMwangiMaina/maliMALI-marketplace-using-flask.git
```

**OR** set up SSH keys (advanced):
```bash
ssh-keygen -t rsa -b 4096 -C "your_email@example.com"
cat ~/.ssh/id_rsa.pub
# Add this key to GitHub > Settings > SSH Keys
git clone git@github.com:JonathanMwangiMaina/maliMALI-marketplace-using-flask.git
```

---

## What's Next?

After successful upload:

1. **Run Deployment Script**
   ```bash
   cd ~/maliMALI-marketplace-using-flask
   ./deploy_pythonanywhere.sh
   ```

2. **Follow Output Instructions**
   - The script will guide you through remaining steps
   - Copy WSGI configuration
   - Set environment variables
   - Configure static files

3. **Refer to Documentation**
   - Quick reference: `DEPLOYMENT_CHECKLIST.md`
   - Detailed guide: `PYTHONANYWHERE_DEPLOYMENT.md`

---

## Quick Commands Reference

```bash
# Navigate to project
cd ~/maliMALI-marketplace-using-flask

# List files
ls -la

# Make script executable
chmod +x deploy_pythonanywhere.sh

# Run deployment
./deploy_pythonanywhere.sh

# View README
cat PYTHONANYWHERE_DEPLOYMENT.md | less

# Check if Git is available
which git

# View deployment checklist
cat DEPLOYMENT_CHECKLIST.md
```

---

## Estimated Upload Times

| Method | Size | Speed | Time |
|--------|------|-------|------|
| **Git Clone** | ~5 MB | Fast | 30s - 2 min |
| **ZIP Upload** | ~3 MB | Medium | 1-5 min |
| **Manual Upload** | N/A | Slow | 10-20 min |
| **SFTP** | ~5 MB | Fast | 2-5 min |

*Times vary based on internet connection speed*

---

## Need Help?

- **PythonAnywhere Docs:** https://help.pythonanywhere.com/pages/UploadingAndDownloadingFiles/
- **Git Issues:** https://help.pythonanywhere.com/pages/ExternalVCS/
- **Forum:** https://www.pythonanywhere.com/forums/

---

**Once upload is complete, you're ready to run the deployment script! 🚀**

Proceed to: `DEPLOYMENT_CHECKLIST.md`
