import 'package:flutter/material.dart';
import 'package:k_beauty_compass/l10n/app_localizations.dart';
import 'package:k_beauty_compass/main.dart';
import './quiz_screen.dart'; // Import the quiz screen

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  List<Map<String, dynamic>> _getOnboardingData(BuildContext context) {
    return [
      {
        'icon': Icons.search_off_rounded,
        'title': AppLocalizations.of(context)!.stopSearchingStartDiscovering,
        'subtitle': AppLocalizations.of(context)!.noMoreEndlessScrolling,
      },
      {
        'icon': Icons.person_search_rounded,
        'title': AppLocalizations.of(context)!.personalizedForYourUniqueSkin,
        'subtitle': AppLocalizations.of(context)!.recommendationsBasedOnYourProfile,
      },
      {
        'icon': Icons.rocket_launch_rounded,
        'title': AppLocalizations.of(context)!.yourKBeautyJourneyStartsNow,
        'subtitle': AppLocalizations.of(context)!.findYourHolyGrailProducts,
      }
    ];
  }

  @override
  Widget build(BuildContext context) {
    final onboardingData = _getOnboardingData(context);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        actions: [
          PopupMenuButton<Locale>(
            icon: const Icon(Icons.language, color: Colors.black),
            onSelected: (Locale locale) {
              KBeautyCompassApp.of(context)?.changeLanguage(locale);
            },
            itemBuilder: (BuildContext context) => <PopupMenuEntry<Locale>>[
              const PopupMenuItem<Locale>(
                value: Locale('en', ''),
                child: Text('English'),
              ),
              const PopupMenuItem<Locale>(
                value: Locale('ko', ''),
                child: Text('한국어'),
              ),
            ],
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                controller: _pageController,
                itemCount: onboardingData.length,
                onPageChanged: (int page) {
                  setState(() {
                    _currentPage = page;
                  });
                },
                itemBuilder: (context, index) {
                  return OnboardingPage(
                    icon: onboardingData[index]['icon'],
                    title: onboardingData[index]['title'],
                    subtitle: onboardingData[index]['subtitle'],
                  );
                },
              ),
            ),
            _buildControls(onboardingData),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  // Builds the bottom controls (dots and button)
  Widget _buildControls(List<Map<String, dynamic>> onboardingData) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Dots indicator
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(
              onboardingData.length,
              (index) => _buildDot(index, context),
            ),
          ),
          // Next or Start Button
          if (_currentPage == onboardingData.length - 1)
            // Show "Get Started" button on the last page
            ElevatedButton(
              onPressed: () {
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const QuizScreen()));
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.pink.shade300,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              ),
              child: Text(
                AppLocalizations.of(context)!.getStarted,
                style: const TextStyle(color: Colors.white, fontSize: 16),
              ),
            )
          else
            // Show "Next" button on other pages
            TextButton(
              onPressed: () {
                _pageController.nextPage(
                  duration: const Duration(milliseconds: 400),
                  curve: Curves.easeInOut,
                );
              },
              child: Text(
                "다음", // TODO: Localize this string
                style: TextStyle(color: Colors.pink.shade300, fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ), 
        ],
      ),
    );
  }

  // Builds a single dot
  Widget _buildDot(int index, BuildContext context) {
    final onboardingData = _getOnboardingData(context);
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      height: 10,
      width: _currentPage == index ? 25 : 10,
      margin: const EdgeInsets.only(right: 5),
      decoration: BoxDecoration(
        color: _currentPage == index ? Colors.pink.shade300 : Colors.grey.shade300,
        borderRadius: BorderRadius.circular(5),
      ),
    );
  }
}

// A single onboarding page widget
class OnboardingPage extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;

  const OnboardingPage({
    super.key,
    required this.icon,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(40.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(
            icon,
            size: 120,
            color: Colors.pink.shade300,
          ),
          const SizedBox(height: 40),
          Text(
            title,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 15),
          Text(
            subtitle,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 16,
              color: Colors.black54,
            ),
          ),
        ],
      ),
    );
  }
}
