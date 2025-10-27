import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'services/auth_service.dart';
import 'screens/landing/landing_page.dart';

void main() async {
  // ✅ Ensure Flutter is initialized before anything else (fixes NotInitializedError)
  WidgetsFlutterBinding.ensureInitialized();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => AuthService(),
      child: MaterialApp(
        title: 'Smart Bin Monitoring',
        theme: ThemeData(
          primaryColor: Colors.teal,
          colorScheme: const ColorScheme.light(
            primary: Colors.teal,
            secondary: Colors.orange,
            surface: Colors.white,
          ),
          appBarTheme: const AppBarTheme(
            backgroundColor: Colors.teal,
            foregroundColor: Colors.white,
          ),
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.teal,
              foregroundColor: Colors.white,
            ),
          ),
        ),
        home: const LandingPage(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
