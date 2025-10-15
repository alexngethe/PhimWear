# PhimWear Collection - Flutter Web Storefront

A modern, responsive e-commerce storefront built with Flutter Web and Firebase for the PhimWear Collection shoe store.

## Features

- **Product Catalog**: Responsive grid layout displaying shoes with images, prices, and tags
- **Product Details**: Detailed product view with image gallery, description, and stock info
- **Shopping Cart**: Full cart management with quantity controls and real-time total calculation
- **Checkout Process**: Form-based checkout with validation for delivery details
- **WhatsApp Integration**: Orders automatically open WhatsApp with prefilled order message to +254712241239
- **Firebase Backend**: Firestore for product/order data, Storage for images (optional)
- **Responsive Design**: Works seamlessly on mobile, tablet, and desktop web browsers
- **Modern UI**: Clean, minimal design with customizable accent color (default: #1E88E5)

## Tech Stack

- **Frontend**: Flutter Web (Dart)
- **Backend**: Firebase (Firestore Database, Storage)
- **State Management**: Provider
- **Hosting**: Firebase Hosting
- **Order Notifications**: WhatsApp Web API

## Project Structure

```
lib/
├── main.dart                 # App entry point with Firebase initialization
├── app_theme.dart            # Theme configuration (colors, typography)
├── models/
│   ├── product.dart          # Product data model
│   ├── cart_item.dart        # Cart item model
│   └── order.dart            # Order and delivery details models
├── services/
│   ├── firestore_service.dart   # Firestore CRUD operations
│   └── storage_service.dart     # Firebase Storage operations
├── providers/
│   ├── product_provider.dart    # Product state management
│   └── cart_provider.dart       # Cart state management
├── pages/
│   ├── home_page.dart           # Product grid homepage
│   ├── product_page.dart        # Product details page
│   ├── cart_page.dart           # Shopping cart page
│   └── checkout_page.dart       # Checkout and order submission
├── widgets/
│   ├── product_card.dart        # Product grid item widget
│   └── cart_item_widget.dart   # Cart item display widget
└── utils/
    ├── whatsapp_helper.dart     # WhatsApp integration
    ├── responsive_helper.dart   # Responsive breakpoints
    └── currency_helper.dart     # Currency formatting (KES)
```

## Getting Started

### Prerequisites

- Flutter SDK 3.0.0 or later
- Firebase account
- Node.js and npm (for Firebase CLI)
- Chrome or Edge browser

### Installation

1. **Clone/Download this project**

2. **Install Flutter dependencies:**
   ```bash
   flutter pub get
   ```

3. **Set up Firebase:**
   - Follow the complete setup guide in `docs/SETUP_GUIDE.md`
   - Create Firebase project
   - Enable Firestore and Storage
   - Add sample products from `docs/sample_products.json`
   - Update Firebase config in `lib/main.dart`

4. **Run locally:**
   ```bash
   flutter run -d chrome
   ```

5. **Build for production:**
   ```bash
   flutter build web --release
   ```

6. **Deploy to Firebase Hosting:**
   ```bash
   firebase deploy
   ```

## Configuration

### Change Accent Color

Edit `lib/app_theme.dart`, line 5:
```dart
static const Color accentColor = Color(0xFF1E88E5); // Change hex value
```

### Change WhatsApp Number

Edit `lib/utils/whatsapp_helper.dart`, line 7:
```dart
static const String businessPhone = '254712241239'; // Your number
```

### Change Currency

Edit `lib/utils/currency_helper.dart`, lines 4-6:
```dart
static final NumberFormat _formatter = NumberFormat.currency(
  symbol: 'KES ',       // Your currency
  decimalDigits: 0,     // 0 for whole numbers, 2 for cents
);
```

## User Flow

1. **Browse Products**: User views product grid on homepage
2. **View Details**: Clicks product to see full details and images
3. **Add to Cart**: Selects quantity and adds items to cart
4. **Review Cart**: Views cart, adjusts quantities, sees total
5. **Checkout**: Fills delivery form with validation
6. **Submit Order**: Order saves to Firestore
7. **WhatsApp**: App opens WhatsApp with prefilled order message
8. **Confirmation**: Cart clears, success message shown

## Firestore Data Structure

### Products Collection
```
products/
  └── {productId}/
      ├── name: string
      ├── description: string
      ├── price: number
      ├── imageUrl: string
      ├── images: array
      ├── tags: array
      ├── stock: number
      ├── featured: boolean
      └── createdAt: string (ISO 8601)
```

### Orders Collection
```
orders/
  └── {orderId}/
      ├── orderId: string
      ├── businessName: string
      ├── items: array of objects
      ├── total: number
      ├── delivery: object
      │   ├── fullName: string
      │   ├── phone: string
      │   ├── address: string
      │   ├── city: string
      │   └── postalCode: string
      ├── notes: string
      ├── status: string
      ├── webClient: boolean
      └── createdAt: string
```

## Security Rules

The `firestore.rules` file contains:
- Public read access for products
- Validated create access for orders
- Admin-only access for modifications

For production, tighten rules and add Firebase Authentication.

## Dependencies

Key packages used:
- `firebase_core` - Firebase initialization
- `cloud_firestore` - Firestore database
- `firebase_storage` - File storage
- `provider` - State management
- `url_launcher` - WhatsApp integration
- `intl` - Currency formatting
- `cached_network_image` - Image caching

See `pubspec.yaml` for full list.

## Customization Ideas

- Add product search functionality
- Implement size selection for shoes
- Add customer reviews and ratings
- Create admin dashboard for product management
- Integrate payment gateway (M-Pesa, Stripe)
- Add order tracking feature
- Implement user authentication
- Add wishlist functionality
- Enable product filtering by tags/price

## Deployment Checklist

- [ ] Firebase project created
- [ ] Firestore and Storage enabled
- [ ] Sample products added
- [ ] Firebase config updated in main.dart
- [ ] Security rules deployed
- [ ] App tested locally
- [ ] Production build created
- [ ] Deployed to Firebase Hosting
- [ ] WhatsApp integration tested
- [ ] Custom domain configured (optional)

## Support & Troubleshooting

See `docs/SETUP_GUIDE.md` for detailed troubleshooting steps.

Common issues:
- Products not loading → Check Firebase config and Firestore rules
- WhatsApp not opening → Verify phone number format
- Build errors → Run `flutter clean` then `flutter pub get`

## License

This project is created for PhimWear Collection.

## Contact

Business WhatsApp: +254712241239

---

Built with Flutter Web 💙 | Powered by Firebase 🔥
