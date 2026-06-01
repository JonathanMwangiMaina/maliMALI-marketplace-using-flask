#!/bin/bash

################################################################################
# PythonAnywhere Deployment Script for maliMALI Marketplace
################################################################################
#
# This script automates the deployment of the maliMALI Flask application
# to PythonAnywhere hosting platform.
#
# USAGE:
#   1. Upload this project to PythonAnywhere via Git or File Upload
#   2. Open a Bash console in PythonAnywhere
#   3. Navigate to project directory: cd ~/maliMali-marketplace-using-flask
#   4. Make script executable: chmod +x deploy_pythonanywhere.sh
#   5. Run deployment: ./deploy_pythonanywhere.sh
#
# PREREQUISITES:
#   - PythonAnywhere account (free or paid)
#   - Project uploaded to ~/maliMali-marketplace-using-flask
#   - Python 3.8+ selected in Web app configuration
#
################################################################################

set -e  # Exit on any error

# Color codes for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Logging functions
log_info() {
    echo -e "${BLUE}[INFO]${NC} $1"
}

log_success() {
    echo -e "${GREEN}[SUCCESS]${NC} $1"
}

log_warning() {
    echo -e "${YELLOW}[WARNING]${NC} $1"
}

log_error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

################################################################################
# CONFIGURATION
################################################################################

PROJECT_DIR="$HOME/maliMali-marketplace-using-flask"
UPLOAD_DIR="$HOME/uploads"
VENV_DIR="$HOME/.virtualenvs/maliMALI-env"

log_info "Starting PythonAnywhere deployment for maliMALI Marketplace"
echo "======================================================================"

################################################################################
# Step 1: Verify Project Directory
################################################################################

log_info "Step 1: Verifying project directory..."

if [ ! -d "$PROJECT_DIR" ]; then
    log_error "Project directory not found at $PROJECT_DIR"
    log_error "Please upload the project first or update PROJECT_DIR variable"
    exit 1
fi

cd "$PROJECT_DIR"
log_success "Project directory verified: $PROJECT_DIR"

################################################################################
# Step 2: Create Virtual Environment
################################################################################

log_info "Step 2: Setting up virtual environment..."

if [ ! -d "$VENV_DIR" ]; then
    log_info "Creating virtual environment at $VENV_DIR"
    python3 -m venv "$VENV_DIR"
    log_success "Virtual environment created"
else
    log_warning "Virtual environment already exists at $VENV_DIR"
fi

# Activate virtual environment
source "$VENV_DIR/bin/activate"
log_success "Virtual environment activated"

################################################################################
# Step 3: Upgrade pip and install dependencies
################################################################################

log_info "Step 3: Installing Python dependencies..."

pip install --upgrade pip

if [ -f "requirements.txt" ]; then
    log_info "Installing packages from requirements.txt..."
    pip install -r requirements.txt
    log_success "Dependencies installed successfully"
else
    log_error "requirements.txt not found!"
    exit 1
fi

################################################################################
# Step 4: Create necessary directories
################################################################################

log_info "Step 4: Creating necessary directories..."

# Create upload directory for vendor images
if [ ! -d "$UPLOAD_DIR" ]; then
    mkdir -p "$UPLOAD_DIR"
    log_success "Upload directory created: $UPLOAD_DIR"
else
    log_warning "Upload directory already exists"
fi

# Set proper permissions
chmod 755 "$UPLOAD_DIR"

################################################################################
# Step 5: Database Setup
################################################################################

log_info "Step 5: Setting up database..."

# Check if database exists
if [ ! -f "$PROJECT_DIR/app.db" ]; then
    log_info "Initializing new database..."

    # Initialize migrations if not already done
    if [ ! -d "$PROJECT_DIR/migrations" ]; then
        log_warning "Migrations directory not found - database structure may need setup"
        log_info "You may need to run: flask db init && flask db migrate && flask db upgrade"
    else
        # Apply existing migrations
        flask db upgrade
        log_success "Database migrations applied"
    fi
else
    log_warning "Database already exists at $PROJECT_DIR/app.db"
    log_info "Applying any pending migrations..."
    flask db upgrade
    log_success "Database updated"
fi

################################################################################
# Step 6: Environment Variables Check
################################################################################

log_info "Step 6: Checking environment variables..."

cat << 'EOF'

====================================================================
IMPORTANT: Configure Environment Variables
====================================================================

You MUST set the following environment variables in PythonAnywhere:
(Web tab > Environment Variables section)

REQUIRED FOR SECURITY:
  - SECRET_KEY (generate with: python -c "import secrets; print(secrets.token_hex(32))")

REQUIRED FOR PAYMENTS (MPesa):
  - MPESA_CONSUMER_KEY
  - MPESA_CONSUMER_SECRET
  - MPESA_API_URL
  - MPESA_BUSINESS_SHORT_CODE
  - MPESA_PASS_KEY
  - MPESA_PHONE_NUMBER
  - MPESA_PARTY_A
  - MPESA_PARTY_B
  - MPESA_INITIATOR_NAME
  - MPESA_INITIATOR_PASSWORD
  - MPESA_BASIC_AUTHORIZATION
  - MPESA_GRANT_TYPE

OPTIONAL BUT RECOMMENDED:
  - AFRICASTALKING_API_KEY (for SMS/Airtime features)
  - AT_USERNAME
  - GOOGLE_MAPS_API_KEY (for location features)
  - IP_INFO_ACCESS_TOKEN (for geolocation)
  - VENDOR_UPLOAD_PATH (default: /home/yourusername/uploads)

====================================================================
EOF

################################################################################
# Step 7: Static Files Configuration
################################################################################

log_info "Step 7: Verifying static files..."

if [ -d "$PROJECT_DIR/app/static" ]; then
    log_success "Static files directory found"
    echo ""
    echo "======================================================================"
    echo "CONFIGURE STATIC FILES MAPPING IN PYTHONANYWHERE WEB TAB:"
    echo "======================================================================"
    echo "URL: /static/"
    echo "Directory: $PROJECT_DIR/app/static/"
    echo "======================================================================"
else
    log_warning "Static files directory not found at $PROJECT_DIR/app/static"
fi

################################################################################
# Step 8: WSGI Configuration Instructions
################################################################################

log_info "Step 8: WSGI Configuration..."

echo ""
echo "======================================================================"
echo "WSGI CONFIGURATION INSTRUCTIONS:"
echo "======================================================================"
echo "1. Go to PythonAnywhere Web tab"
echo "2. Scroll to 'Code' section"
echo "3. Click on WSGI configuration file link"
echo "4. Replace ALL contents with the file: pythonanywhere_wsgi.py"
echo "5. Update PYTHONANYWHERE_USERNAME variable in the WSGI file"
echo ""
echo "WSGI file location template:"
echo "/var/www/<yourusername>_pythonanywhere_com_wsgi.py"
echo ""
echo "Source file to copy from:"
echo "$PROJECT_DIR/pythonanywhere_wsgi.py"
echo "======================================================================"

################################################################################
# Step 9: Generate Secret Key
################################################################################

log_info "Step 9: Generating secure SECRET_KEY..."

SECRET_KEY=$(python3 -c "import secrets; print(secrets.token_hex(32))")

echo ""
echo "======================================================================"
echo "GENERATED SECRET KEY (save this securely):"
echo "======================================================================"
echo "$SECRET_KEY"
echo ""
echo "Add this to PythonAnywhere environment variables:"
echo "  Variable name: SECRET_KEY"
echo "  Variable value: $SECRET_KEY"
echo "======================================================================"

################################################################################
# Step 10: Final Instructions
################################################################################

log_success "Deployment preparation complete!"

cat << 'EOF'

====================================================================
FINAL DEPLOYMENT STEPS:
====================================================================

1. ✅ Dependencies installed
2. ✅ Directories created
3. ✅ Database initialized

MANUAL STEPS REQUIRED IN PYTHONANYWHERE WEB TAB:

□ Step 1: Configure Virtual Environment
  - Path: /home/<username>/.virtualenvs/maliMALI-env

□ Step 2: Update WSGI Configuration
  - Copy contents from pythonanywhere_wsgi.py
  - Update PYTHONANYWHERE_USERNAME variable

□ Step 3: Set Environment Variables
  - Add SECRET_KEY (generated above)
  - Add MPesa credentials
  - Add other API keys as needed

□ Step 4: Configure Static Files Mapping
  - URL: /static/
  - Directory: /home/<username>/maliMali-marketplace-using-flask/app/static/

□ Step 5: Reload Web App
  - Click green "Reload" button in Web tab

□ Step 6: Test Application
  - Visit: https://<username>.pythonanywhere.com
  - Check error logs if issues occur

====================================================================
TROUBLESHOOTING:
====================================================================

If you encounter errors:
1. Check error log: /var/log/<username>.pythonanywhere.com.error.log
2. Check server log: /var/log/<username>.pythonanywhere.com.server.log
3. Verify all environment variables are set
4. Verify WSGI file has correct paths
5. Ensure virtual environment path is correct

====================================================================
NEXT STEPS FOR PRODUCTION:
====================================================================

1. Configure MPesa webhooks to point to your PythonAnywhere domain
2. Test payment flow thoroughly in sandbox mode
3. Set up regular database backups
4. Monitor application logs
5. Consider upgrading to paid plan for:
   - Always-on application
   - MySQL database
   - Custom domain support
   - Increased resources

====================================================================
EOF

log_success "Deployment script completed successfully!"
log_info "Please complete the manual steps listed above."

# Deactivate virtual environment
deactivate
