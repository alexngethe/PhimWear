# PhimWear Collection - Setup Guide

Complete step-by-step guide to set up and deploy your Flutter web storefront with Firebase.

## Prerequisites

- Flutter SDK (3.0.0 or later)
- Firebase account
- Node.js and npm (for Firebase CLI)
- Chrome or Edge browser for testing

## Part 1: Firebase Setup

### 1.1 Create Firebase Project

1. Go to [Firebase Console](https://console.firebase.google.com/)
2. Click "Add project"
3. Enter project name: **PhimWear Collection**
4. Disable Google Analytics (optional for MVP)
5. Click "Create project"

### 1.2 Enable Firestore Database

1. In Firebase Console sidebar, go to **Build** > **Firestore Database**
2. Click "Create database"
3. Choose "Start in test mode" (we'll update rules later)
4. Select your preferred region (closest to your users)
5. Click "Enable"

### 1.3 Enable Firebase Storage (Optional)

1. Go to **Build** > **Storage**
2. Click "Get started"
3. Choose "Start in test mode"
4. Click "Done"

### 1.4 Register Web App

1. In Project Overview, click the **Web** icon (`</>`)
2. Register app with nickname: **PhimWear Web**
3. Check "Also set up Firebase Hosting"
4. Click "Register app"
5. **Copy the Firebase configuration** - you'll need it in the next step

The configuration looks like this:
```javascript
const firebaseConfig = {
  apiKey: "AIzaSy...",
  authDomain: "your-project.firebaseapp.com",
  projectId: "your-project-id",
  storageBucket: "your-project.appspot.com",
  messagingSenderId: "123456789",
  appId: "1:123456789:web:abc123"
};
```

## Part 2: Configure Flutter Project

### 2.1 Add Firebase Configuration to Flutter

Open `lib/main.dart` and replace the placeholder Firebase config (lines 16-23) with your actual configuration:

```dart
await Firebase.initializeApp(
  options: const FirebaseOptions(
    apiKey: "YOUR_API_KEY",           // Replace with your apiKey
    authDomain: "YOUR_PROJECT_ID.firebaseapp.com",  // Replace
    projectId: "YOUR_PROJECT_ID",      // Replace
    storageBucket: "YOUR_PROJECT_ID.appspot.com",   // Replace
    messagingSenderId: "YOUR_SENDER_ID",  // Replace
    appId: "YOUR_APP_ID",              // Replace
  ),
);
```

### 2.2 Install Dependencies

In your project directory, run:

```bash
flutter pub get
```

This installs all required packages from pubspec.yaml.

## Part 3: Add Sample Products to Firestore

### 3.1 Via Firebase Console

1. Go to Firestore Database in Firebase Console
2. Click "Start collection"
3. Collection ID: **products**
4. Click "Next"
5. Add first document:
   - Document ID: Use **Auto-ID** or enter custom ID like `shoe_001`
   - Add fields (see sample data below)

### 3.2 Sample Product Data

**Product 1:**
```json
{
  "name": "Air Max Runner Pro",
  "description": "Premium running shoes with advanced cushioning and breathable mesh upper. Perfect for long-distance runs and daily training.",
  "price": 8500,
  "imageUrl": "https://images.unsplash.com/photo-1542291026-7eec264c27ff?w=500",
  "images": [
    "https://images.unsplash.com/photo-1542291026-7eec264c27ff?w=500",
    "https://images.unsplash.com/photo-1549298916-b41d501d3772?w=500"
  ],
  "tags": ["running", "sports", "featured"],
  "stock": 15,
  "featured": true,
  "createdAt": "2024-01-15T10:30:00Z"
}
```

**Product 2:**
```json
{
  "name": "Classic Leather Sneakers",
  "description": "Timeless leather sneakers with rubber sole. Versatile style suitable for casual and semi-formal occasions.",
  "price": 6500,
  "imageUrl": "https://images.unsplash.com/photo-1525966222134-fcfa99b8ae77?w=500",
  "images": [
    "https://images.unsplash.com/photo-1525966222134-fcfa99b8ae77?w=500",
    "https://images.unsplash.com/photo-1560769629-975ec94e6a86?w=500"
  ],
  "tags": ["casual", "leather", "featured"],
  "stock": 20,
  "featured": true,
  "createdAt": "2024-01-14T09:00:00Z"
}
```

**Product 3:**
```json
{
  "name": "Urban Street High-Tops",
  "description": "Stylish high-top sneakers with canvas upper and padded ankle support. Perfect for urban streetwear looks.",
  "price": 7200,
  "imageUrl": "https://images.unsplash.com/photo-1514989940723-e8e51635b782?w=500",
  "images": [
    "https://images.unsplash.com/photo-1514989940723-e8e51635b782?w=500",
    "https://images.unsplash.com/photo-1600185365483-26d7a4cc7519?w=500"
  ],
  "tags": ["streetwear", "canvas", "high-top"],
  "stock": 12,
  "featured": false,
  "createdAt": "2024-01-13T14:20:00Z"
}
```

Add at least 3 products for testing.

## Part 4: Deploy Firestore Security Rules

### 4.1 Install Firebase CLI

```bash
npm install -g firebase-tools
```

### 4.2 Login to Firebase

```bash
firebase login
```

### 4.3 Initialize Firebase in Project

In your project directory:

```bash
firebase init
```

- Select: **Firestore** and **Hosting**
- Choose: **Use an existing project**
- Select your Firebase project
- Firestore rules file: `firestore.rules` (already created)
- Firestore indexes file: `firestore.indexes.json` (press enter to accept default)
- Public directory: `build/web`
- Single-page app: **Yes**
- GitHub deploys: **No** (optional)

### 4.4 Deploy Rules

```bash
firebase deploy --only firestore:rules
```

## Part 5: Run Locally

### 5.1 Start Development Server

```bash
flutter run -d chrome
```

Or for Edge:
```bash
flutter run -d edge
```

### 5.2 Test the Application

1. **Home Page**: Verify products load in grid
2. **Product Details**: Click a product, view details
3. **Add to Cart**: Add items to cart
4. **Cart**: View cart, adjust quantities
5. **Checkout**: Fill form, test validation
6. **WhatsApp**: Submit order (opens WhatsApp with message)

## Part 6: Build for Production

### 6.1 Build Web App

```bash
flutter build web --release
```

Output files will be in `build/web/` directory.

### 6.2 Deploy to Firebase Hosting

```bash
firebase deploy --only hosting
```

Your site will be live at: `https://your-project-id.web.app`

### 6.3 Custom Domain (Optional)

1. Go to Firebase Console > Hosting
2. Click "Add custom domain"
3. Follow instructions to verify domain
4. Update DNS records as instructed

## Part 7: Customization

### 7.1 Change Accent Color

Edit `lib/app_theme.dart`, line 5:
```dart
static const Color accentColor = Color(0xFF1E88E5); // Change this hex value
```

Color suggestions:
- Blue: `0xFF1E88E5` (default)
- Green: `0xFF4CAF50`
- Orange: `0xFFFF9800`
- Red: `0xFFE53935`
- Teal: `0xFF009688`

### 7.2 Change Business Phone

Edit `lib/utils/whatsapp_helper.dart`, line 7:
```dart
static const String businessPhone = '254712241239'; // Change to your number
```

Format: Country code + number (no + sign, no spaces)

### 7.3 Change Currency

Edit `lib/utils/currency_helper.dart`, lines 4-6:
```dart
static final NumberFormat _formatter = NumberFormat.currency(
  symbol: 'KES ',  // Change to your currency symbol
  decimalDigits: 0,  // Change to 2 for cents/paise
);
```

### 7.4 Change Business Name

1. **App Title**: Edit `lib/main.dart`, line 38
2. **Header**: Edit `lib/pages/home_page.dart`, line 17
3. **Orders**: Edit `lib/utils/whatsapp_helper.dart`, line 28

## Troubleshooting

### Issue: Products not loading

**Solution:**
1. Check Firebase config in `main.dart` is correct
2. Verify Firestore rules allow reads: `allow read: if true;`
3. Ensure at least one product exists in Firestore
4. Check browser console for errors

### Issue: WhatsApp not opening

**Solution:**
1. Ensure WhatsApp is installed on your device
2. Check phone number format (no + sign)
3. Test URL manually: `https://wa.me/254712241239`
4. For web: Use Chrome or Edge browser

### Issue: Order not saving to Firestore

**Solution:**
1. Check Firestore rules allow creates
2. Verify Firebase initialization is correct
3. Check browser console for errors
4. Ensure all required order fields are present

### Issue: Images not loading

**Solution:**
1. Check image URLs are valid and accessible
2. Use direct image URLs (not redirects)
3. Ensure CORS is enabled for image hosts
4. Test image URL in browser directly

## Next Steps

1. **Add More Products**: Populate your store with real inventory
2. **Customize Design**: Adjust colors, fonts, spacing
3. **Add Authentication**: Implement user accounts (optional)
4. **Payment Integration**: Add M-Pesa or Stripe (optional)
5. **Admin Panel**: Build dashboard to manage products and orders
6. **Analytics**: Add Google Analytics to track conversions

## Support

For issues or questions:
- Check Firebase Console for errors
- Review browser console logs
- Verify all configuration steps completed
- Test with sample data first

## Security Checklist

- [ ] Firebase config added to main.dart
- [ ] Firestore rules deployed
- [ ] Test mode rules updated for production
- [ ] Custom domain SSL configured (if using)
- [ ] Order data properly validated
- [ ] WhatsApp number verified

Your PhimWear Collection storefront is now ready! 🎉
