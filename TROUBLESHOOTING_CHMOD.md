# 🔧 Troubleshooting: "chmod: cannot access 'deploy_pythonanywhere.sh'"

## Problem

You're seeing this error:
```
chmod: cannot access 'deploy_pythonanywhere.sh'
```

## Root Cause

You're not in the correct directory where the file is located.

---

## ✅ Solution (Copy-Paste These Commands)

### Step 1: Navigate to Project Directory

```bash
cd ~/maliMALI-marketplace-using-flask
```

### Step 2: Verify You're in Right Place

```bash
pwd
```

**Expected output:**
```
/home/yourusername/maliMALI-marketplace-using-flask
```

### Step 3: List Files to Confirm

```bash
ls -la deploy_pythonanywhere.sh
```

**Expected output:**
```
-rw-r--r-- 1 yourusername registered_users 11234 Jun 01 12:34 deploy_pythonanywhere.sh
```

### Step 4: Make Executable

```bash
chmod +x deploy_pythonanywhere.sh
```

### Step 5: Verify Permissions Changed

```bash
ls -la deploy_pythonanywhere.sh
```

**Expected output (note the 'x' in permissions):**
```
-rwxr-xr-x 1 yourusername registered_users 11234 Jun 01 12:34 deploy_pythonanywhere.sh
```

### Step 6: Run Deployment

```bash
./deploy_pythonanywhere.sh
```

---

## 🔍 Alternative: Find the File

If the above doesn't work, find where the file is:

```bash
find ~ -name "deploy_pythonanywhere.sh" -type f 2>/dev/null
```

This will show you the exact path. Then navigate to that directory.

---

## 📋 Complete Command Sequence

**Copy and paste this entire block:**

```bash
# Navigate to home directory first
cd ~

# Go to project directory
cd maliMALI-marketplace-using-flask

# Verify location
echo "Current directory: $(pwd)"

# List deployment file
ls -lh deploy_pythonanywhere.sh

# Make executable
chmod +x deploy_pythonanywhere.sh

# Verify it worked
ls -lh deploy_pythonanywhere.sh

# Run deployment
./deploy_pythonanywhere.sh
```

---

## ❌ Common Mistakes

### Mistake 1: Wrong Directory Name
```bash
# WRONG
cd maliMALI-marketplace-using-flask/
```

**Solution:** Make sure you cloned the repo first:
```bash
cd ~
git clone https://github.com/JonathanMwangiMaina/maliMALI-marketplace-using-flask.git
cd maliMALI-marketplace-using-flask
```

### Mistake 2: Typo in Filename
```bash
# WRONG
chmod +x deploy_pythonanywhere
```

**Correct:**
```bash
chmod +x deploy_pythonanywhere.sh
```

### Mistake 3: Not in Home Directory
```bash
# If you get "No such file or directory"
cd ~
cd maliMALI-marketplace-using-flask
```

---

## 🆘 Still Not Working?

### Check if Project Was Cloned

```bash
cd ~
ls -la | grep maliMALI
```

**If you see nothing:**
You haven't cloned the repository yet!

**Fix:**
```bash
git clone https://github.com/JonathanMwangiMaina/maliMALI-marketplace-using-flask.git
```

### Check if File Exists

```bash
cd ~/maliMALI-marketplace-using-flask
ls -la *.sh
```

**If you see "No such file or directory":**
The repository might not have pulled the latest changes.

**Fix:**
```bash
git pull origin main
```

---

## 🎯 Quickest Solution

**Just run this single command block:**

```bash
cd ~ && \
cd maliMALI-marketplace-using-flask && \
pwd && \
ls -lh deploy_pythonanywhere.sh && \
chmod +x deploy_pythonanywhere.sh && \
echo "✅ File is now executable!" && \
./deploy_pythonanywhere.sh
```

**What this does:**
1. Goes to home directory
2. Enters project directory
3. Shows current location
4. Shows the file exists
5. Makes it executable
6. Confirms success
7. Runs deployment

---

## 📞 Need More Help?

**Show me this output:**

```bash
cd ~
pwd
ls -la | grep maliMALI
cd maliMALI-marketplace-using-flask 2>&1
ls -la deploy_pythonanywhere.sh 2>&1
```

Copy the entire output and we can diagnose the exact issue.

---

## ✅ Success Indicators

**You'll know it worked when you see:**

```bash
$ chmod +x deploy_pythonanywhere.sh
$ ls -la deploy_pythonanywhere.sh
-rwxr-xr-x 1 username users 11234 Jun 01 12:34 deploy_pythonanywhere.sh
         ^^^
         These 'x' letters mean "executable" - that's what you want!
```

Then run:
```bash
./deploy_pythonanywhere.sh
```

And you should see colored output starting with:
```
[INFO] Starting PythonAnywhere deployment for maliMALI Marketplace
======================================================================
```

---

**Pro Tip:** If all else fails, you can run the script with bash directly (no chmod needed):

```bash
cd ~/maliMALI-marketplace-using-flask
bash deploy_pythonanywhere.sh
```
