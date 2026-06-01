# PythonAnywhere Deployment Quick Checklist

## ⚡ Quick Reference Guide

Print this checklist and check off items as you complete them.

---

## Phase 1: Pre-Deployment (5 minutes)

- [ ] Sign up for PythonAnywhere account
- [ ] Choose Python 3.10 in Web app creation
- [ ] Clone/upload project to `~/maliMALI-marketplace-using-flask`

---

## Phase 2: Automated Setup (3 minutes)

Run in PythonAnywhere Bash Console:

```bash
cd ~/maliMALI-marketplace-using-flask
chmod +x deploy_pythonanywhere.sh
./deploy_pythonanywhere.sh
```

**Script will:**
- [ ] ✅ Create virtual environment
- [ ] ✅ Install dependencies
- [ ] ✅ Create upload directory
- [ ] ✅ Initialize database
- [ ] ✅ Generate SECRET_KEY

**⚠️ SAVE THE GENERATED SECRET_KEY - You'll need it next!**

---

## Phase 3: Manual Configuration (10 minutes)

### A. Virtual Environment
- [ ] Go to **Web** tab
- [ ] Scroll to **Virtualenv** section
- [ ] Enter: `/home/YOURUSERNAME/.virtualenvs/maliMALI-env`
- [ ] Replace `YOURUSERNAME` with your actual username

### B. WSGI Configuration
- [ ] In **Web** tab > **Code** section
- [ ] Click WSGI configuration file link
- [ ] **DELETE ALL EXISTING CONTENT**
- [ ] Copy from: `~/maliMALI-marketplace-using-flask/pythonanywhere_wsgi.py`
- [ ] Update line: `PYTHONANYWHERE_USERNAME = 'YOURUSERNAME'`
- [ ] Click **Save**

### C. Static Files
- [ ] In **Web** tab > **Static files** section
- [ ] URL: `/static/`
- [ ] Directory: `/home/YOURUSERNAME/maliMALI-marketplace-using-flask/app/static/`

### D. Environment Variables
Go to **Web** tab > **Environment variables** section

**CRITICAL (Required):**
- [ ] `SECRET_KEY` = (paste generated key from script output)

**For MPesa Payments (Required if accepting payments):**
- [ ] `MPESA_CONSUMER_KEY`
- [ ] `MPESA_CONSUMER_SECRET`
- [ ] `MPESA_API_URL` = `https://sandbox.safaricom.co.ke` (or production)
- [ ] `MPESA_BUSINESS_SHORT_CODE`
- [ ] `MPESA_PASS_KEY`
- [ ] `MPESA_PHONE_NUMBER`
- [ ] `MPESA_PARTY_A`
- [ ] `MPESA_PARTY_B`
- [ ] `MPESA_INITIATOR_NAME`
- [ ] `MPESA_INITIATOR_PASSWORD`
- [ ] `MPESA_GRANT_TYPE` = `client_credentials`

**Optional but Recommended:**
- [ ] `AFRICASTALKING_API_KEY`
- [ ] `AT_USERNAME`
- [ ] `GOOGLE_MAPS_API_KEY`
- [ ] `IP_INFO_ACCESS_TOKEN`

---

## Phase 4: Launch (2 minutes)

- [ ] Click green **Reload** button at top of Web tab
- [ ] Wait for reload to complete (watch for checkmark)
- [ ] Visit: `https://YOURUSERNAME.pythonanywhere.com`
- [ ] Verify homepage loads successfully

---

## Phase 5: Testing (10 minutes)

### Basic Functionality
- [ ] Homepage loads without errors
- [ ] Can register new user account
- [ ] Can log in successfully
- [ ] Can log out
- [ ] Static files (CSS/images) loading

### Vendor Features (if applicable)
- [ ] Can create vendor account
- [ ] Can upload product images
- [ ] Can create product listings
- [ ] Products appear on marketplace

### Customer Features
- [ ] Can browse products
- [ ] Can add items to cart
- [ ] Shopping cart persists

### Payment Testing (MPesa Sandbox)
- [ ] Can initiate checkout
- [ ] MPesa STK push received on test phone
- [ ] Payment callback works
- [ ] Order status updates after payment

---

## Phase 6: Monitoring (Ongoing)

### First 24 Hours
- [ ] Check error log every 2 hours:
  ```bash
  tail -50 /var/log/YOURUSERNAME.pythonanywhere.com.error.log
  ```
- [ ] Test all critical user flows
- [ ] Monitor for any 500 errors

### Weekly
- [ ] Review error logs
- [ ] Check disk space usage
- [ ] Verify backup strategy working

---

## Troubleshooting Checklist

### If site shows "Something went wrong"
- [ ] Check error log: `tail -100 /var/log/YOURUSERNAME.pythonanywhere.com.error.log`
- [ ] Verify WSGI file has correct paths
- [ ] Confirm virtual environment path correct
- [ ] Check all environment variables set

### If static files not loading
- [ ] Verify Static files mapping in Web tab
- [ ] Check directory exists and has files
- [ ] Reload web app

### If database errors occur
- [ ] Verify database file exists: `ls ~/maliMALI-marketplace-using-flask/app.db`
- [ ] Check migrations applied: `flask db current`
- [ ] Run migrations if needed: `flask db upgrade`

### If MPesa not working
- [ ] Verify all MPesa env vars set
- [ ] Check using sandbox credentials first
- [ ] Verify callback URL registered with Safaricom
- [ ] Check error logs for API responses

---

## Emergency Rollback

If deployment fails critically:

```bash
# Stop the web app (Web tab > Disable button)
# Restore from backup
cd ~/maliMALI-marketplace-using-flask
cp ~/backups/app-backup.db ./app.db
# Re-enable web app
```

---

## Success Criteria

✅ **Deployment Successful When:**
- [ ] Site loads at `https://YOURUSERNAME.pythonanywhere.com`
- [ ] No errors in error log
- [ ] Can register and login
- [ ] Static files displaying
- [ ] Database operations working
- [ ] (Optional) Test payment completes successfully

---

## Estimated Time: 30 minutes total
- Automated setup: 8 minutes
- Manual configuration: 10 minutes
- Testing: 10 minutes
- Buffer: 2 minutes

---

## Quick Commands Reference

```bash
# View error log
tail -100 /var/log/YOURUSERNAME.pythonanywhere.com.error.log

# Activate virtual environment
source ~/.virtualenvs/maliMALI-env/bin/activate

# Run migrations
cd ~/maliMALI-marketplace-using-flask
flask db upgrade

# Generate new SECRET_KEY
python3 -c "import secrets; print(secrets.token_hex(32))"

# Backup database
cp ~/maliMALI-marketplace-using-flask/app.db ~/backups/app-$(date +%Y%m%d).db

# Check Python version
python3 --version

# List installed packages
pip list
```

---

## Support Resources

- **Full Guide:** See `PYTHONANYWHERE_DEPLOYMENT.md`
- **PythonAnywhere Help:** https://help.pythonanywhere.com/
- **MPesa Sandbox:** https://developer.safaricom.co.ke/test_credentials
- **Forum:** https://www.pythonanywhere.com/forums/

---

**Keep this checklist handy for future deployments or updates!**
