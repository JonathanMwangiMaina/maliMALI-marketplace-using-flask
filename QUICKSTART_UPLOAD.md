# ⚡ Quick Start: Upload to PythonAnywhere in 5 Minutes

## 🎯 Your Mission

Upload `maliMALI-marketplace-using-flask` to PythonAnywhere and get it running in under 10 minutes.

---

## 📋 Prerequisites (2 minutes)

1. **Create PythonAnywhere Account**
   - Visit: https://www.pythonanywhere.com/registration/register/beginner/
   - Sign up (FREE account is fine)
   - Verify your email
   - Log in

✅ **Account created? Let's go!**

---

## 🚀 Upload Steps (3 minutes)

### Step 1: Open Bash Console

1. Log in to https://www.pythonanywhere.com/
2. Click **"Consoles"** tab (top menu)
3. Click **"Bash"** button (under "Start a new console")
4. A black terminal window opens

### Step 2: Clone Your Project

Copy and paste this command into the Bash console:

```bash
cd ~ && git clone https://github.com/JonathanMwangiMaina/maliMALI-marketplace-using-flask.git
```

**Press Enter** and wait ~30 seconds.

You'll see:
```
Cloning into 'maliMALI-marketplace-using-flask'...
remote: Enumerating objects: ...
remote: Counting objects: ...
Receiving objects: 100% ...
```

### Step 3: Verify Upload

```bash
cd maliMALI-marketplace-using-flask && ls -la
```

You should see a list of files including:
- `app/`
- `config.py`
- `deploy_pythonanywhere.sh` ⭐
- `requirements.txt`
- And more...

### Step 4: Make Script Executable

```bash
chmod +x deploy_pythonanywhere.sh
```

✅ **Upload complete!**

---

## 🎬 Run Deployment (5 minutes)

Now run the automated deployment script:

```bash
./deploy_pythonanywhere.sh
```

**What happens:**
- ✅ Creates virtual environment
- ✅ Installs Python packages
- ✅ Sets up database
- ✅ Generates SECRET_KEY (SAVE THIS!)
- ✅ Gives you next steps

**The script will output:**
1. A SECRET_KEY (save it!)
2. Instructions for WSGI configuration
3. Environment variables to set
4. Static files mapping

---

## 📝 Manual Configuration (5 minutes)

After the script finishes, you need to do 4 things in PythonAnywhere Web tab:

### 1️⃣ Create Web App (if not done)

- Go to **Web** tab
- Click **"Add a new web app"**
- Choose **Manual configuration**
- Select **Python 3.10**

### 2️⃣ Set Virtual Environment Path

In Web tab, find **"Virtualenv"** section:
- Enter: `/home/yourusername/.virtualenvs/maliMALI-env`
- Replace `yourusername` with YOUR PythonAnywhere username

### 3️⃣ Update WSGI Configuration

In Web tab, find **"Code"** section:
- Click on WSGI configuration file link
- **DELETE ALL EXISTING CONTENT**
- Open new Bash console and run:
  ```bash
  cat ~/maliMALI-marketplace-using-flask/pythonanywhere_wsgi.py
  ```
- Copy the output and paste into WSGI file
- Update this line:
  ```python
  PYTHONANYWHERE_USERNAME = 'yourusername'  # Change to YOUR username
  ```
- Click **Save**

### 4️⃣ Configure Static Files

In Web tab, find **"Static files"** section:
- Click **"Enter URL"**
- URL: `/static/`
- Directory: `/home/yourusername/maliMALI-marketplace-using-flask/app/static/`
- Replace `yourusername` with YOUR username

### 5️⃣ Set Environment Variables

In Web tab, find **"Environment variables"** section:

**Add this variable (MINIMUM):**
- Name: `SECRET_KEY`
- Value: (paste the SECRET_KEY from deployment script output)

**For full functionality, also add MPesa variables** (see script output or `.env.example`)

---

## 🎉 Launch!

1. In Web tab, scroll to top
2. Click green **"Reload yourusername.pythonanywhere.com"** button
3. Wait 10 seconds
4. Click your site URL: `https://yourusername.pythonanywhere.com`

**If it loads: SUCCESS! 🎊**

---

## ❌ Troubleshooting

### "Something went wrong" error?

Check error log:
```bash
tail -50 /var/log/yourusername.pythonanywhere.com.error.log
```

**Common fixes:**
- WSGI file path incorrect → Check `PROJECT_HOME` variable
- Virtual env path wrong → Verify path in Web tab
- SECRET_KEY not set → Add in Environment Variables section

### Need detailed help?

Open: `PYTHONANYWHERE_DEPLOYMENT.md` (14 KB troubleshooting guide)

---

## 📊 Your Progress

- [ ] PythonAnywhere account created
- [ ] Project cloned via Git
- [ ] Deployment script executed
- [ ] SECRET_KEY saved
- [ ] Web app created
- [ ] Virtual environment path set
- [ ] WSGI file updated
- [ ] Static files configured
- [ ] Environment variables set
- [ ] Web app reloaded
- [ ] Site loading successfully

---

## 🎯 Complete Commands Summary

**Copy-paste these in order:**

```bash
# 1. Clone project
cd ~ && git clone https://github.com/JonathanMwangiMaina/maliMALI-marketplace-using-flask.git

# 2. Navigate and verify
cd maliMALI-marketplace-using-flask && ls -la

# 3. Make script executable
chmod +x deploy_pythonanywhere.sh

# 4. Run deployment
./deploy_pythonanywhere.sh

# 5. View WSGI file content (for copying)
cat pythonanywhere_wsgi.py

# 6. Check if site is running (after configuration)
curl -I https://yourusername.pythonanywhere.com
```

---

## ⏱️ Time Estimate

- Account creation: 2 min
- Upload via Git: 2 min
- Run deployment script: 3 min
- Manual configuration: 5 min
- Testing: 2 min

**Total: ~15 minutes** to fully deployed site

---

## 📚 Next Steps After Success

1. **Test all features** (registration, login, product listing)
2. **Set up MPesa** (if accepting payments)
3. **Read production checklist** in `PYTHONANYWHERE_DEPLOYMENT.md`
4. **Set up backups** (database, uploads)

---

## 🆘 Need Help?

1. **Quick Reference:** `DEPLOYMENT_CHECKLIST.md`
2. **Full Guide:** `PYTHONANYWHERE_DEPLOYMENT.md`
3. **PythonAnywhere Forum:** https://www.pythonanywhere.com/forums/
4. **Error Logs:** Check `/var/log/yourusername.pythonanywhere.com.error.log`

---

**Ready? Let's deploy! 🚀**

Start here: https://www.pythonanywhere.com/
