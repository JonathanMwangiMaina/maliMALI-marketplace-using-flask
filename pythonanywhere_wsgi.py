"""
WSGI Configuration for PythonAnywhere Deployment
=================================================

This file should be copied to:
/var/www/<yourusername>_pythonanywhere_com_wsgi.py

Replace <yourusername> with your actual PythonAnywhere username.

SETUP INSTRUCTIONS:
1. Upload this project to PythonAnywhere
2. Copy this file to the WSGI path shown above
3. Configure environment variables in PythonAnywhere Web tab
4. Set up static files mappings
5. Reload the web app
"""

import sys
import os

# ============================================================================
# CONFIGURATION - UPDATE THESE VALUES
# ============================================================================

# Replace with your PythonAnywhere username
PYTHONANYWHERE_USERNAME = 'JonathanMwangiMaina'

# Project directory path
PROJECT_HOME = f'/home/JonathanMwangiMaina/maliMali-marketplace-using-flask'

# ============================================================================
# PATH CONFIGURATION
# ============================================================================

# Add project directory to Python path
if PROJECT_HOME not in sys.path:
    sys.path.insert(0, PROJECT_HOME)

# ============================================================================
# ENVIRONMENT VARIABLES
# ============================================================================
# NOTE: For production, set these via PythonAnywhere Web tab > Environment Variables
# This section serves as a fallback for development/testing

# Security
os.environ.setdefault('SECRET_KEY', 'CHANGE-THIS-TO-A-SECURE-RANDOM-STRING')

# Database Configuration
# For SQLite (Free tier)
os.environ.setdefault(
    'DATABASE_URL',
    f'sqlite:///{PROJECT_HOME}/app.db'
)

# For MySQL (Paid tier) - Uncomment and configure:
# os.environ.setdefault(
#     'DATABASE_URL',
#     'mysql+pymysql://username:password@username.mysql.pythonanywhere-services.com/dbname'
# )

# File Upload Path
os.environ.setdefault(
    'VENDOR_UPLOAD_PATH',
    f'/home/{PYTHONANYWHERE_USERNAME}/uploads'
)

# MPesa Integration (REQUIRED for payment processing)
# Get these from Safaricom Developer Portal: https://developer.safaricom.co.ke/
os.environ.setdefault('MPESA_CONSUMER_KEY', 'MTu0PS4Ke2drQ0BeTz9c4lJAK4Mpmi3Hob24lcuGQbhFVxm1')
os.environ.setdefault('MPESA_CONSUMER_SECRET', 'dm9QRKLZtWBY9GuzPuATtKnoiqxppKXajPDX9CUab3WGc9mWpurhVBfTi8IW3jQs')
os.environ.setdefault('MPESA_API_URL', 'https://sandbox.safaricom.co.ke/oauth/v1/generate?grant_type=client_credentials')  # or production URL
os.environ.setdefault('MPESA_PARTY_A', '600984')  # Your shortcode
os.environ.setdefault('MPESA_PARTY_B', '600000')  # Your shortcode
os.environ.setdefault('MPESA_PHONE_NUMBER', '254708374149'
os.environ.setdefault('MPESA_BUSINESS_SHORT_CODE', '174379')
os.environ.setdefault('MPESA_PASS_KEY', 'bfb279f9aa9bdbcf158e97dd71a467cd2e0c893059b10f78e6b72ada1ed2c919')
os.environ.setdefault('MPESA_INITIATOR_PASSWORD', 'Safaricom123!!')
os.environ.setdefault('MPESA_INITIATOR_NAME', 'testapi')
os.environ.setdefault('MPESA_BASIC_AUTHORIZATION', 'TVR1MFBTNEtlMmRyUTBCZVR6OWM0bEpBSzRNcG1pM0hvYjI0bGN1R1FiaEZWeG0xOmRtOVFSS0xadFdCWTlHdXpQdUFUdEtub2lxeHBwS1hhalBEWDlDVWFiM1dHYzltV3B1cmhWQmZUaThJVzNqUXM=')
os.environ.setdefault('MPESA_GRANT_TYPE', '/oauth/v1/generate?grant_type=client_credentials')

# Africa's Talking Integration (for SMS/Airtime)
# Get credentials from: https://africastalking.com/
os.environ.setdefault('AFRICASTALKING_API_KEY', 'qXq4j1cx2')
os.environ.setdefault('AT_USERNAME', '')  # Your Africa's Talking username

# Google Maps Integration
# Get API key from: https://console.cloud.google.com/
os.environ.setdefault('GOOGLE_MAPS_API_KEY', '')

# IP Info Integration
# Get token from: https://ipinfo.io/
os.environ.setdefault('IP_INFO_ACCESS_TOKEN', 'c2771c0603cc31')

# ============================================================================
# LOGGING CONFIGURATION (Optional but recommended)
# ============================================================================

import logging

# Configure logging to PythonAnywhere error log
logging.basicConfig(
    level=logging.INFO,
    format='%(asctime)s [%(levelname)s] %(name)s: %(message)s',
    handlers=[
        logging.StreamHandler(sys.stderr)
    ]
)

logger = logging.getLogger(__name__)
logger.info(f'Initializing maliMALI application from {PROJECT_HOME}')

# ============================================================================
# APPLICATION IMPORT
# ============================================================================

try:
    from app import app as application
    logger.info('Successfully imported Flask application')
except Exception as e:
    logger.error(f'Failed to import Flask application: {e}')
    raise

# ============================================================================
# WSGI APPLICATION
# ============================================================================

# PythonAnywhere expects the WSGI application to be named 'application'
# The import above handles this: 'from app import app as application'

# Optional: Add application context
if __name__ == '__main__':
    # This block won't run on PythonAnywhere (WSGI mode)
    # but useful for local testing
    application.run(debug=False)
