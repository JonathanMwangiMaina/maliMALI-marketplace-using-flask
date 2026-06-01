# PythonAnywhere Deployment Guide for maliMALI Marketplace

## 📋 Table of Contents

1. [Prerequisites](#prerequisites)
2. [Quick Start](#quick-start)
3. [Detailed Deployment Steps](#detailed-deployment-steps)
4. [Environment Variables Configuration](#environment-variables-configuration)
5. [Static Files Setup](#static-files-setup)
6. [Database Configuration](#database-configuration)
7. [MPesa Webhook Configuration](#mpesa-webhook-configuration)
8. [Troubleshooting](#troubleshooting)
9. [Production Checklist](#production-checklist)

---

## Prerequisites

### Required Accounts
- ✅ **PythonAnywhere Account** - [Sign up here](https://www.pythonanywhere.com/registration/register/beginner/)
- ✅ **Safaricom Developer Account** (for MPesa) - [Register here](https://developer.safaricom.co.ke/)
- ✅ **Africa's Talking Account** (optional, for SMS) - [Sign up](https://africastalking.com/)
- ✅ **Google Cloud Account** (optional, for Maps) - [Console](https://console.cloud.google.com/)

### Files Included
- `pythonanywhere_wsgi.py` - WSGI configuration file
- `deploy_pythonanywhere.sh` - Automated deployment script
- `requirements.txt` - Python dependencies
- `config.py` - Application configuration

---

## Quick Start

### 1. Upload Project to PythonAnywhere

**Option A: Using Git (Recommended)**
```bash
# In PythonAnywhere Bash Console
cd ~
git clone https://github.com/JonathanMwangiMaina/maliMALI-marketplace-using-flask.git
```

**Option B: Manual Upload**
- Use PythonAnywhere Files tab
- Upload ZIP file
- Extract to `/home/yourusername/maliMALI-marketplace-using-flask`

### 2. Run Deployment Script

```bash
cd ~/maliMALI-marketplace-using-flask
chmod +x deploy_pythonanywhere.sh
./deploy_pythonanywhere.sh
```

### 3. Follow Manual Configuration Steps

The script will output specific instructions for:
- WSGI configuration
- Environment variables
- Static files mapping

---

## Detailed Deployment Steps

### Step 1: Create Web App

1. Log in to PythonAnywhere
2. Go to **Web** tab
3. Click **Add a new web app**
4. Select **Manual configuration**
5. Choose **Python 3.10** (or latest available)
6. Click **Next**

### Step 2: Configure Virtual Environment

1. In Web tab, scroll to **Virtualenv** section
2. Enter virtualenv path:
   ```
   /home/yourusername/.virtualenvs/maliMALI-env
   ```
3. The deployment script creates this automatically

### Step 3: Update WSGI Configuration File

1. In Web tab, scroll to **Code** section
2. Click on WSGI configuration file (e.g., `/var/www/yourusername_pythonanywhere_com_wsgi.py`)
3. **Delete all existing content**
4. Copy entire contents from `pythonanywhere_wsgi.py`
5. Update this line:
   ```python
   PYTHONANYWHERE_USERNAME = 'yourusername'  # Replace with your actual username
   ```
6. Click **Save**

### Step 4: Configure Static Files

1. In Web tab, scroll to **Static files** section
2. Click **Enter URL** and add:

| URL | Directory |
|-----|-----------|
| `/static/` | `/home/yourusername/maliMALI-marketplace-using-flask/app/static/` |

### Step 5: Set Environment Variables

1. In Web tab, scroll to **Environment variables** section
2. Add all required variables (see next section)
3. Click **Save** after each variable

### Step 6: Reload Web App

1. Scroll to top of Web tab
2. Click green **Reload yourusername.pythonanywhere.com** button
3. Wait for reload to complete

### Step 7: Test Deployment

1. Click on your URL: `https://yourusername.pythonanywhere.com`
2. Verify homepage loads
3. Check error logs if issues occur

---

## Environment Variables Configuration

### Critical Security Variables

#### 1. SECRET_KEY (Required)
Generate a secure key:
```bash
python3 -c "import secrets; print(secrets.token_hex(32))"
```
Add to environment variables:
- **Name:** `SECRET_KEY`
- **Value:** (paste generated key)

### Database Configuration

#### 2. DATABASE_URL (Optional - defaults to SQLite)

**For SQLite (Free tier - Default):**
```
sqlite:////home/yourusername/maliMALI-marketplace-using-flask/app.db
```

**For MySQL (Paid tier - Recommended for production):**
```
mysql+pymysql://username:password@username.mysql.pythonanywhere-services.com/dbname
```

### MPesa Payment Integration (Required for Payments)

Get credentials from [Safaricom Developer Portal](https://developer.safaricom.co.ke/):

| Variable Name | Description | Example |
|---------------|-------------|---------|
| `MPESA_CONSUMER_KEY` | MPesa API Consumer Key | `xxxxxxxxxxxxxxxxxxx` |
| `MPESA_CONSUMER_SECRET` | MPesa API Consumer Secret | `xxxxxxxxxxxxxxxxxxx` |
| `MPESA_API_URL` | API Base URL | Sandbox: `https://sandbox.safaricom.co.ke`<br>Production: `https://api.safaricom.co.ke` |
| `MPESA_BUSINESS_SHORT_CODE` | Your Paybill/Till Number | `174379` |
| `MPESA_PASS_KEY` | Lipa Na MPesa Passkey | `xxxxxx...` |
| `MPESA_PHONE_NUMBER` | Your phone number | `254712345678` |
| `MPESA_PARTY_A` | Usually same as shortcode | `174379` |
| `MPESA_PARTY_B` | Usually same as shortcode | `174379` |
| `MPESA_INITIATOR_NAME` | API Initiator username | `testapi` |
| `MPESA_INITIATOR_PASSWORD` | Initiator password | `xxxxxxx` |
| `MPESA_BASIC_AUTHORIZATION` | Base64 encoded credentials | Auto-generated |
| `MPESA_GRANT_TYPE` | OAuth grant type | `client_credentials` |

### Africa's Talking Integration (Optional - for SMS/Airtime)

Get from [Africa's Talking Dashboard](https://account.africastalking.com/):

| Variable Name | Description |
|---------------|-------------|
| `AFRICASTALKING_API_KEY` | Your API Key |
| `AT_USERNAME` | Your AT username (usually `sandbox` for testing) |

### Google Maps Integration (Optional)

Get from [Google Cloud Console](https://console.cloud.google.com/):

| Variable Name | Description |
|---------------|-------------|
| `GOOGLE_MAPS_API_KEY` | Maps JavaScript API Key |

### IP Geolocation (Optional)

Get from [IPInfo](https://ipinfo.io/):

| Variable Name | Description |
|---------------|-------------|
| `IP_INFO_ACCESS_TOKEN` | IPInfo access token |

### File Upload Configuration

| Variable Name | Value | Description |
|---------------|-------|-------------|
| `VENDOR_UPLOAD_PATH` | `/home/yourusername/uploads` | Directory for vendor product images |

---

## Static Files Setup

### Directory Structure

Ensure the following structure exists:
```
/home/yourusername/maliMALI-marketplace-using-flask/
├── app/
│   └── static/
│       ├── css/
│       ├── js/
│       └── images/
└── uploads/  (created by deployment script)
```

### Configure in PythonAnywhere

**Web Tab > Static Files Section:**

Add this mapping:
- **URL:** `/static/`
- **Directory:** `/home/yourusername/maliMALI-marketplace-using-flask/app/static/`

---

## Database Configuration

### SQLite (Free Tier - Default)

The deployment script automatically creates the database at:
```
/home/yourusername/maliMALI-marketplace-using-flask/app.db
```

**Advantages:**
- ✅ Simple setup
- ✅ No additional cost
- ✅ Sufficient for development/testing

**Limitations:**
- ⚠️ Not suitable for high traffic
- ⚠️ No concurrent write support
- ⚠️ Limited to 512MB on free tier

### MySQL (Paid Plans - Recommended for Production)

**Step 1: Create Database**
1. Go to **Databases** tab in PythonAnywhere
2. Click **Create database**
3. Note the connection details

**Step 2: Update DATABASE_URL**
```
mysql+pymysql://username:password@username.mysql.pythonanywhere-services.com/dbname
```

**Step 3: Install MySQL Adapter**
```bash
pip install pymysql
```

**Step 4: Run Migrations**
```bash
cd ~/maliMALI-marketplace-using-flask
source ~/.virtualenvs/maliMALI-env/bin/activate
flask db upgrade
```

---

## MPesa Webhook Configuration

### Why Webhooks Matter

MPesa uses webhooks to notify your application when:
- Payment is successful
- Payment fails
- Transaction is reversed

### Configure Callback URLs

1. Log in to [Safaricom Developer Portal](https://developer.safaricom.co.ke/)
2. Navigate to your app settings
3. Set callback URL to:
   ```
   https://yourusername.pythonanywhere.com/mpesa/callback
   ```

### Test MPesa Integration

**Sandbox Testing:**
1. Use MPesa sandbox credentials
2. Test phone: `254708374149` (sandbox number)
3. Monitor PythonAnywhere error logs for callback data

**Production:**
1. Switch to production credentials
2. Update `MPESA_API_URL` to production endpoint
3. Test with real transactions (small amounts first)

---

## Troubleshooting

### Common Issues and Solutions

#### Issue 1: "Import Error: No module named 'app'"

**Cause:** WSGI file path incorrect

**Solution:**
1. Check WSGI file has correct `PROJECT_HOME` path
2. Verify project uploaded to correct directory
3. Check virtual environment path in Web tab

#### Issue 2: "Database is locked"

**Cause:** SQLite doesn't handle concurrent requests well

**Solution:**
- Upgrade to MySQL (paid plan)
- Or reduce traffic to site
- Or use read-only endpoints

#### Issue 3: "Static files not loading"

**Cause:** Static files mapping incorrect

**Solution:**
1. Verify path in Web tab > Static files
2. Check directory exists: `/home/yourusername/maliMALI-marketplace-using-flask/app/static/`
3. Reload web app

#### Issue 4: "MPesa payments failing"

**Cause:** Incorrect credentials or callback URL

**Solution:**
1. Verify all MPesa environment variables are set
2. Check callback URL registered with Safaricom
3. Test with sandbox credentials first
4. Check error logs: `/var/log/yourusername.pythonanywhere.com.error.log`

#### Issue 5: "500 Internal Server Error"

**Cause:** Application error

**Solution:**
1. Check error log:
   ```bash
   tail -f /var/log/yourusername.pythonanywhere.com.error.log
   ```
2. Look for Python tracebacks
3. Verify all environment variables are set
4. Check database migrations applied

### Viewing Logs

**Error Log (most important):**
```bash
tail -100 /var/log/yourusername.pythonanywhere.com.error.log
```

**Server Log:**
```bash
tail -100 /var/log/yourusername.pythonanywhere.com.server.log
```

**Access Log:**
```bash
tail -100 /var/log/yourusername.pythonanywhere.com.access.log
```

---

## Production Checklist

### Pre-Launch

- [ ] All environment variables configured
- [ ] SECRET_KEY is strong and unique (not default)
- [ ] Database migrations applied successfully
- [ ] Static files loading correctly
- [ ] MPesa sandbox payments working
- [ ] Email functionality tested (if implemented)
- [ ] Error pages customized (404, 500)
- [ ] HTTPS enforced (automatic on PythonAnywhere)

### Security

- [ ] SECRET_KEY changed from default
- [ ] Debug mode disabled (`FLASK_ENV=production`)
- [ ] Database credentials secure
- [ ] API keys not hardcoded in files
- [ ] CORS configured properly (if using API)
- [ ] SQL injection prevention (using SQLAlchemy ORM)
- [ ] XSS prevention (Jinja2 auto-escaping enabled)

### Performance

- [ ] Consider upgrading to paid plan for:
  - Always-on application
  - More CPU/bandwidth
  - MySQL database
  - Custom domain
- [ ] Optimize database queries
- [ ] Enable caching (Flask-Caching)
- [ ] Compress static files
- [ ] Use CDN for images (if high traffic)

### Monitoring

- [ ] Set up error notification emails
- [ ] Monitor error logs regularly
- [ ] Track MPesa transaction success rate
- [ ] Set up uptime monitoring (e.g., UptimeRobot)
- [ ] Monitor disk space usage (uploads folder)

### Backup

- [ ] Export database regularly:
  ```bash
  # For SQLite
  cp ~/maliMALI-marketplace-using-flask/app.db ~/backups/app-$(date +%Y%m%d).db

  # For MySQL
  mysqldump -u username -p dbname > backup.sql
  ```
- [ ] Store backups off-server (Google Drive, Dropbox, etc.)
- [ ] Test backup restoration process

### Going Live

- [ ] Switch MPesa from sandbox to production
- [ ] Update `MPESA_API_URL` to production endpoint
- [ ] Register production callback URLs with Safaricom
- [ ] Test payment flow with real money (small amount)
- [ ] Announce launch to vendors/customers
- [ ] Monitor first few transactions closely

---

## PythonAnywhere Plan Comparison

| Feature | Free | Hacker ($5/mo) | Web Dev ($12/mo) |
|---------|------|----------------|------------------|
| **Storage** | 512MB | 1GB | 10GB |
| **Always On** | ❌ | ✅ | ✅ |
| **MySQL** | ❌ | ✅ | ✅ |
| **Custom Domain** | ❌ | ✅ | ✅ |
| **Daily CPU** | 100s | 2000s | 5000s |
| **Scheduled Tasks** | 1 | 2 | 3 |

**Recommendation:**
- **Free:** Development/testing only
- **Hacker:** Small production sites (<100 daily users)
- **Web Dev:** Production sites with moderate traffic

---

## Additional Resources

### Documentation
- [PythonAnywhere Help](https://help.pythonanywhere.com/)
- [Flask Documentation](https://flask.palletsprojects.com/)
- [Safaricom MPesa API Docs](https://developer.safaricom.co.ke/docs)

### Support
- **PythonAnywhere Forum:** [https://www.pythonanywhere.com/forums/](https://www.pythonanywhere.com/forums/)
- **Email Support:** support@pythonanywhere.com

### Tools
- **Generate SECRET_KEY:** `python3 -c "import secrets; print(secrets.token_hex(32))"`
- **Test MPesa:** Use sandbox credentials and test phone numbers
- **Database Admin:** Use PythonAnywhere's phpMyAdmin (for MySQL)

---

## Next Steps After Deployment

1. **Test thoroughly** - All features, especially payments
2. **Monitor logs** - Watch for errors in first 24 hours
3. **Backup database** - Before making any changes
4. **Scale gradually** - Start with free tier, upgrade as needed
5. **Document changes** - Keep track of configuration changes
6. **Set up monitoring** - UptimeRobot, Sentry, etc.

---

## Need Help?

If you encounter issues not covered in this guide:
1. Check PythonAnywhere error logs first
2. Search [PythonAnywhere forums](https://www.pythonanywhere.com/forums/)
3. Review [Flask troubleshooting guide](https://flask.palletsprojects.com/en/2.2.x/debugging/)
4. Contact PythonAnywhere support (paid plans get priority)

---

**Last Updated:** 2026-06-01
**Deployment Script Version:** 1.0
