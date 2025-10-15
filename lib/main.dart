import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'app_theme.dart';
import 'providers/product_provider.dart';
import 'providers/cart_provider.dart';
import 'pages/home_page.dart';
import 'pages/product_page.dart';
import 'pages/cart_page.dart';
import 'pages/checkout_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Firebase
  // IMPORTANT: Replace with your Firebase configuration from Firebase Console
  await Firebase.initializeApp(
    options: const FirebaseOptions(
      apiKey: "YOUR_API_KEY",
      authDomain: "YOUR_PROJECT_ID.firebaseapp.com",
      projectId: "YOUR_PROJECT_ID",
      storageBucket: "YOUR_PROJECT_ID.appspot.com",
      messagingSenderId: "YOUR_SENDER_ID",
      appId: "YOUR_APP_ID",
    ),
  );

  runApp(const PhimWearApp());
}

class PhimWearApp extends StatelessWidget {
  const PhimWearApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ProductProvider()),
        ChangeNotifierProvider(create: (_) => CartProvider()),
      ],
      child: MaterialApp(
        title: 'PhimWear Collection',
        debugShowCheckedModeBanner: false,
        theme: AppTheme.lightTheme,
        initialRoute: '/',
        routes: {
          '/': (context) => const HomePage(),
          '/product': (context) => const ProductPage(),
          '/cart': (context) => const CartPage(),
          '/checkout': (context) => const CheckoutPage(),
        },
      ),
    );
  }
}
