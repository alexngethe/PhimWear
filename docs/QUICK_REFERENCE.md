# Quick Reference Guide

Essential commands and configurations for PhimWear Collection storefront.

## Quick Commands

### Development
```bash
# Install dependencies
flutter pub get

# Run in Chrome
flutter run -d chrome

# Run in Edge
flutter run -d edge

# Hot reload
Press 'r' in terminal

# Hot restart
Press 'R' in terminal
```

### Production
```bash
# Clean build
flutter clean

# Build for web
flutter build web --release

# Deploy to Firebase
firebase deploy

# Deploy only hosting
firebase deploy --only hosting

# Deploy only rules
firebase deploy --only firestore:rules
```

### Firebase CLI
```bash
# Install Firebase CLI
npm install -g firebase-tools

# Login
firebase login

# Initialize project
firebase init

# Check project
firebase projects:list
```

## Key Files to Edit

### Business Configuration

| File | Line | What to Change |
|------|------|----------------|
| `lib/main.dart` | 16-23 | Firebase configuration |
| `lib/app_theme.dart` | 5 | Accent color |
| `lib/utils/whatsapp_helper.dart` | 7 | WhatsApp phone number |
| `lib/utils/currency_helper.dart` | 4-6 | Currency symbol and format |

### Firebase Config Template
```dart
await Firebase.initializeApp(
  options: const FirebaseOptions(
    apiKey: "AIzaSy...",                              // From Firebase Console
    authDomain: "your-project.firebaseapp.com",       // From Firebase Console
    projectId: "your-project-id",                     // From Firebase Console
    storageBucket: "your-project.appspot.com",        // From Firebase Console
    messagingSenderId: "123456789",                   // From Firebase Console
    appId: "1:123456789:web:abc123",                  // From Firebase Console
  ),
);
```

## Color Customization

Replace hex value in `lib/app_theme.dart`:

```dart
static const Color accentColor = Color(0xFF1E88E5); // Blue
```

**Color Palette:**
- Blue: `0xFF1E88E5` (Default)
- Green: `0xFF4CAF50`
- Orange: `0xFFFF9800`
- Red: `0xFFE53935`
- Purple: `0xFF9C27B0`
- Teal: `0xFF009688`
- Pink: `0xFFE91E63`

## WhatsApp Phone Format

Edit `lib/utils/whatsapp_helper.dart`:

```dart
static const String businessPhone = '254712241239';
```

**Format Rules:**
- No `+` sign
- No spaces or hyphens
- Include country code
- Examples:
  - Kenya: `254712345678`
  - US: `12025551234`
  - UK: `447700900000`

## Adding Products to Firestore

### Via Firebase Console

1. Go to Firestore Database
2. Click "Start collection"
3. Collection ID: `products`
4. Add document with these fields:

**Required Fields:**
- `name` (string)
- `description` (string)
- `price` (number)
- `imageUrl` (string)
- `images` (array)
- `tags` (array)
- `stock` (number)
- `featured` (boolean)
- `createdAt` (string - ISO 8601)

**Example:**
```json
{
  "name": "Nike Air Max",
  "description": "Classic running shoe...",
  "price": 8500,
  "imageUrl": "https://...",
  "images": ["https://...", "https://..."],
  "tags": ["running", "featured"],
  "stock": 10,
  "featured": true,
  "createdAt": "2024-01-15T10:00:00Z"
}
```

## Image URLs

**Free Stock Photo Sources:**
- Unsplash: `https://images.unsplash.com/photo-{id}?w=500`
- Pexels: `https://images.pexels.com/photos/{id}/pexels-photo-{id}.jpeg?w=500`

**Tips:**
- Use direct image URLs
- Recommended size: 500-1000px width
- Format: JPG or PNG
- Ensure images are public (no authentication required)

## Firestore Security Rules

Current rules (for MVP):
```javascript
// Products: Everyone can read, no one can write
match /products/{productId} {
  allow read: if true;
  allow write: if false;
}

// Orders: Anyone can create, admins only can read
match /orders/{orderId} {
  allow create: if request.resource.data.items.size() > 0;
  allow read, update, delete: if false;
}
```

**Deploy rules:**
```bash
firebase deploy --only firestore:rules
```

## Responsive Breakpoints

Defined in `lib/utils/responsive_helper.dart`:

- **Mobile**: < 600px (2 columns)
- **Tablet**: 600-900px (3 columns)
- **Laptop**: 900-1200px (4 columns)
- **Desktop**: > 1200px (5 columns)

## State Management

### Product Provider
```dart
// Access products
Provider.of<ProductProvider>(context).products

// Load products
Provider.of<ProductProvider>(context, listen: false).loadProducts()
```

### Cart Provider
```dart
// Access cart
final cart = Provider.of<CartProvider>(context);

// Add item
cart.addItem(product, quantity: 2);

// Remove item
cart.removeItem(productId);

// Get total
cart.totalAmount;
cart.itemCount;
```

## Common Issues & Fixes

### Issue: "Firebase not initialized"
**Fix:** Ensure Firebase config is correct in `lib/main.dart`

### Issue: "Products not loading"
**Fix:**
1. Check Firebase config
2. Verify Firestore rules allow reads
3. Add at least one product to Firestore

### Issue: "Build failed"
**Fix:**
```bash
flutter clean
flutter pub get
flutter build web --release
```

### Issue: "WhatsApp not opening"
**Fix:**
1. Check phone number format (no + sign)
2. Ensure WhatsApp is installed
3. Test in Chrome or Edge browser

### Issue: "Images not displaying"
**Fix:**
1. Verify image URLs are valid
2. Test URLs in browser
3. Ensure URLs are public (no auth required)

## Testing Checklist

- [ ] Products display on homepage
- [ ] Can click product to view details
- [ ] Can add items to cart
- [ ] Cart badge shows correct count
- [ ] Can adjust quantities in cart
- [ ] Cart total calculates correctly
- [ ] Can remove items from cart
- [ ] Checkout form validates inputs
- [ ] Order saves to Firestore
- [ ] WhatsApp opens with correct message
- [ ] Cart clears after order

## Performance Tips

1. **Optimize Images**: Use compressed images (< 200KB)
2. **Limit Products**: Start with 10-20 products for testing
3. **Enable Caching**: Images are cached automatically
4. **Production Build**: Always use `--release` flag for deployment
5. **Firebase Indexes**: Let Firebase auto-create needed indexes

## Deployment URLs

After deployment, your app will be available at:

- **Firebase Hosting**: `https://your-project-id.web.app`
- **Custom Domain**: Configure in Firebase Console > Hosting

## Environment-Specific Configs

### Development
- Use test products
- Test phone number
- Verbose error messages

### Production
- Real inventory
- Business phone number
- Error logging to Firebase
- Analytics enabled

## Useful Links

- [Flutter Web Docs](https://flutter.dev/web)
- [Firebase Console](https://console.firebase.google.com/)
- [Firestore Documentation](https://firebase.google.com/docs/firestore)
- [WhatsApp API](https://faq.whatsapp.com/general/chats/how-to-use-click-to-chat)

## File Sizes (for reference)

After `flutter build web --release`:
- Typical build size: 2-5 MB
- Main.dart.js: ~1-2 MB (compressed)
- Assets: Varies based on images

---

**Quick Help:** If stuck, check `docs/SETUP_GUIDE.md` for detailed instructions.
