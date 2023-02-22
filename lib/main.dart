import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:litnine_app/provider/currentLitnineClientProvider.dart';
import 'package:litnine_app/services/database_service.dart';
import 'package:litnine_app/services/email_service.dart';
import 'package:litnine_app/services/location_provider.dart';
import 'package:litnine_app/provider/newLitnineUser_provider.dart';
import 'package:litnine_app/provider/shoppingCartProvider.dart';
import 'package:litnine_app/services/auth_service.dart';
import 'package:litnine_app/services/order_service.dart';
import 'package:litnine_app/services/permission_service.dart';
import 'package:provider/provider.dart';
import 'app.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  await Firebase.initializeApp();
  runApp(
    MultiProvider(
      providers: [
        Provider<AuthService>(create: (context)=>AuthService()),
        Provider<DatabaseService>(create: (context)=>DatabaseService()),
        Provider<LocationService>(create: (context)=>LocationService()),
        Provider<EmailService>(create: (context)=>EmailService()),
        Provider<OrderService>(create: (context)=>OrderService()),
        Provider<PermissionService>(create: (context)=>PermissionService()),
        ChangeNotifierProvider(create: (context) => NewClientProvider()),
        ChangeNotifierProvider(create: (context) => CurrentLitnineClientProvider()),
        ChangeNotifierProvider(create: (context) => ShoppingCartProvider()),
      ],
      child: const App(),
    ),
  );
}

