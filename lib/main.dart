import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:k_beauty_compass/l10n/app_localizations.dart';
import 'screens/onboarding_screen.dart'; // Import the onboarding screen

void main() {
  runApp(const KBeautyCompassApp());
}

class KBeautyCompassApp extends StatefulWidget {
  const KBeautyCompassApp({super.key});

  @override
  State<KBeautyCompassApp> createState() => _KBeautyCompassAppState();

  static _KBeautyCompassAppState? of(BuildContext context) =>
      context.findAncestorStateOfType<_KBeautyCompassAppState>();
}

class _KBeautyCompassAppState extends State<KBeautyCompassApp> {
  Locale _locale = const Locale('en', '');

  void changeLanguage(Locale locale) {
    setState(() {
      _locale = locale;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      onGenerateTitle: (context) => AppLocalizations.of(context)!.kBeautyCompass,
      locale: _locale,
      theme: ThemeData(
        primarySwatch: Colors.pink,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        fontFamily: 'Pretendard', // A popular font for Korean apps
      ),
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('en', ''), // English
        Locale('ko', ''), // Korean
      ],
      home: const SplashScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    // Navigate to onboarding screen after a delay
    Future.delayed(const Duration(seconds: 3), () {
      if (mounted) {
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const OnboardingScreen()));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Placeholder for the logo
            Icon(
              Icons.explore_outlined, // Compass icon as a placeholder
              size: 100,
              color: Colors.pink.shade300,
            ),
            const SizedBox(height: 20),
            Builder(builder: (context) {
              return Text(
                AppLocalizations.of(context)!.kBeautyCompass,
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              );
            }),
          ],
        ),
      ),
    );
  }
}
