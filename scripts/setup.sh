#!/bin/bash

# Setup script for Employee Attendance & GPS Tracking App
# This script will install all dependencies and configure the project

set -e

echo "=========================================="
echo "Setup: Employee Attendance GPS Tracker"
echo "=========================================="

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Check Flutter installation
echo -e "${YELLOW}Checking Flutter installation...${NC}"
if ! command -v flutter &> /dev/null; then
    echo -e "${RED}❌ Flutter is not installed${NC}"
    echo "Visit: https://flutter.dev/docs/get-started/install"
    exit 1
fi
echo -e "${GREEN}✅ Flutter found${NC}"
flutter --version

# Check Firebase CLI
echo -e "${YELLOW}Checking Firebase CLI...${NC}"
if ! command -v firebase &> /dev/null; then
    echo -e "${YELLOW}Installing Firebase CLI...${NC}"
    npm install -g firebase-tools
fi
echo -e "${GREEN}✅ Firebase CLI ready${NC}"

# Activate FlutterFire CLI
echo -e "${YELLOW}Activating FlutterFire CLI...${NC}"
flutter pub global activate flutterfire_cli
echo -e "${GREEN}✅ FlutterFire CLI activated${NC}"

# Setup Mobile App
echo -e "${YELLOW}Setting up Mobile App...${NC}"
cd mobile
echo "Installing dependencies..."
flutter pub get
echo -e "${GREEN}✅ Mobile app setup complete${NC}"
cd ..

# Setup Web Dashboard
echo -e "${YELLOW}Setting up Web Dashboard...${NC}"
cd web
echo "Installing dependencies..."
flutter pub get
echo -e "${GREEN}✅ Web dashboard setup complete${NC}"
cd ..

# Setup Cloud Functions
echo -e "${YELLOW}Setting up Cloud Functions...${NC}"
cd firebase/functions
echo "Installing Node dependencies..."
npm install
echo -e "${GREEN}✅ Cloud Functions setup complete${NC}"
cd ../..

# Summary
echo ""
echo "=========================================="
echo -e "${GREEN}Setup Complete!${NC}"
echo "=========================================="
echo ""
echo "Next Steps:"
echo "1. Run 'flutterfire configure' in mobile and web directories"
echo "2. Update Firebase configuration in firebase_options.dart"
echo "3. Add your Google Maps API key"
echo "4. Configure Firestore security rules"
echo "5. Deploy Cloud Functions: 'firebase deploy --only functions'"
echo ""
echo "To start development:"
echo "  - Mobile:  cd mobile && flutter run"
echo "  - Web:     cd web && flutter run -d chrome"
echo ""
echo "For more details, see docs/IMPLEMENTATION_GUIDE.md"
echo ""
