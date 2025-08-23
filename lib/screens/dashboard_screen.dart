import 'package:flutter/material.dart';
import 'package:k_beauty_compass/l10n/app_localizations.dart';
import 'package:k_beauty_compass/main.dart';
import 'package:url_launcher/url_launcher.dart';
import '../models/product_model.dart';
import '../services/recommendation_service.dart';

class DashboardScreen extends StatefulWidget {
  final Map<int, List<int>> quizAnswers;

  const DashboardScreen({super.key, required this.quizAnswers});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  bool _isLoading = true;
  late Map<String, Product> _recommendedRoutine;
  final RecommendationService _recommendationService = RecommendationService();

  @override
  void initState() {
    super.initState();
    _initializeRecommendations();
  }

  Future<void> _initializeRecommendations() async {
    _recommendedRoutine = await _recommendationService.getRecommendations(widget.quizAnswers);
    Future.delayed(const Duration(seconds: 2), () {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    });
  }

  void _showLegalDisclaimer(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(AppLocalizations.of(context)!.legalDisclaimer),
        content: Text(AppLocalizations.of(context)!.legalDisclaimerText),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text(AppLocalizations.of(context)!.close),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: _isLoading ? _buildLoadingScreen() : _buildDashboardScreen(),
    );
  }

  Widget _buildLoadingScreen() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const CircularProgressIndicator(),
          const SizedBox(height: 20),
          Text(
            AppLocalizations.of(context)!.findingYourPerfectMatch,
            style: const TextStyle(fontSize: 18, color: Colors.black54),
          ),
        ],
      ),
    );
  }

  Widget _buildDashboardScreen() {
    return CustomScrollView(
      slivers: [
        SliverAppBar(
          backgroundColor: Colors.white,
          pinned: true,
          expandedHeight: 120.0,
          flexibleSpace: FlexibleSpaceBar(
            titlePadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            title: Text(
              AppLocalizations.of(context)!.todaysBeautyCompass,
              style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
            ),
            background: Container(color: Colors.white),
          ),
          actions: [],
        ),
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  AppLocalizations.of(context)!.yourPersonalizedRoutine,
                  style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
        SliverList(
          delegate: SliverChildBuilderDelegate(
            (context, index) {
              final routineStep = _recommendedRoutine.keys.elementAt(index);
              final product = _recommendedRoutine.values.elementAt(index);
              return ProductCard(routineStep: routineStep, product: product);
            },
            childCount: _recommendedRoutine.length,
          ),
        ),
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 20.0),
            child: TextButton(
              onPressed: () => _showLegalDisclaimer(context),
              child: Text(
                AppLocalizations.of(context)!.legalDisclaimer,
                style: const TextStyle(color: Colors.grey, fontSize: 12, decoration: TextDecoration.underline),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class ProductCard extends StatelessWidget {
  final String routineStep;
  final Product product;

  const ProductCard({super.key, required this.routineStep, required this.product});

  Future<void> _launchUrl() async {
    final Uri url = Uri.parse(product.affiliateUrl);
    if (!await launchUrl(url)) {
      print("Could not launch $url");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      elevation: 2,
      shadowColor: Colors.grey.shade50,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: InkWell(
        onTap: _launchUrl,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              SizedBox(
                width: 80,
                height: 80,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.network(
                    product.imageUrl,
                    fit: BoxFit.cover,
                    loadingBuilder: (context, child, loadingProgress) {
                      if (loadingProgress == null) return child;
                      return const Center(child: CircularProgressIndicator());
                    },
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        color: Colors.grey.shade200,
                        child: const Icon(Icons.image_not_supported, color: Colors.grey, size: 40),
                      );
                    },
                  ),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      routineStep.toUpperCase(),
                      style: const TextStyle(fontSize: 12, color: Colors.pink, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      product.name,
                      style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 4),
                    Text(product.brand, style: const TextStyle(fontSize: 14, color: Colors.black54)),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
