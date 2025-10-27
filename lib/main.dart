import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'services/auth_service.dart';
import 'screens/landing/landing_page.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Log Flutter framework errors to console
  FlutterError.onError = (FlutterErrorDetails details) {
    FlutterError.dumpErrorToConsole(details);
    if (kReleaseMode == false) {
      // in debug mode also print stack
      Zone.current.handleUncaughtError(
          details.exception, details.stack ?? StackTrace.current);
    }
  };

  try {
    await Firebase.initializeApp();
    print('Firebase initialized successfully');
  } catch (e, st) {
    print('Failed to initialize Firebase: $e\n$st');
  }

  runZonedGuarded(() {
    runApp(const MyApp());
  }, (error, stack) {
    // Catch async errors
    print('Uncaught zone error: $error\n$stack');
  });
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<AuthService>(
      create: (_) => AuthService(),
      child: MaterialApp(
        title: 'Smart Bin Monitoring',
        theme: ThemeData(
          primaryColor: Colors.teal,
          colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.teal)
              .copyWith(secondary: Colors.orange),
        ),
        // TEMP DEBUG HOME: swap back to LandingPage() after debugging
        home: const DebugHome(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}

class DebugHome extends StatelessWidget {
  const DebugHome({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Debug Home')),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(mainAxisSize: MainAxisSize.min, children: [
            const Text('Basic UI visible — app rendered',
                textAlign: TextAlign.center),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                // quick runtime check: try to navigate to LandingPage
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (_) => const LandingPage()));
              },
              child: const Text('Open LandingPage'),
            ),
            const SizedBox(height: 12),
            ElevatedButton(
              onPressed: () => debugPrintStack(label: 'Manual stack dump'),
              child: const Text('Dump stack to console'),
            ),
            const SizedBox(height: 12),
            const Text('Check your terminal/Debug Console for logs.'),
          ]),
        ),
      ),
    );
  }
}
