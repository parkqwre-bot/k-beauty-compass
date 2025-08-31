import 'package:flutter/material.dart';
import 'package:k_beauty_compass/l10n/app_localizations.dart';
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
  late List<Product> _recommendedProducts;
  final RecommendationService _recommendationService = RecommendationService();
  String? _errorMessage;
  late PageController _pageController; // Controller declared here

  @override
  void initState() {
    super.initState();
    _pageController = PageController(viewportFraction: 0.85); // Initialized here
    _initializeRecommendations();
  }

  @override
  void dispose() {
    _pageController.dispose(); // Disposed here
    super.dispose();
  }

  Future<void> _initializeRecommendations() async {
    try {
      _recommendedProducts = await _recommendationService.getRecommendations(widget.quizAnswers);
    } catch (e) {
      if (mounted) {
        setState(() {
          _errorMessage = '추천 제품을 불러오는 데 실패했습니다: ${e.toString()}';
        });
      }
    } finally {
      Future.delayed(const Duration(seconds: 1), () {
        if (mounted) {
          setState(() {
            _isLoading = false;
          });
        }
      });
    }
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
      body: _isLoading ? _buildLoadingScreen() : _buildDashboardContent(),
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

  Widget _buildDashboardContent() {
    if (_errorMessage != null) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(
            _errorMessage!,
            style: const TextStyle(color: Colors.red, fontSize: 16),
            textAlign: TextAlign.center,
          ),
        ),
      );
    }

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
        ),
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  AppLocalizations.of(context)!.yourPersonalizedRoutine,
                  style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),
                if (_recommendedProducts.isEmpty)
                  const Text("아쉽지만, 현재 조건에 맞는 추천 제품이 없습니다. 퀴즈를 다시 시도해보세요."),
              ],
            ),
          ),
        ),
        SliverToBoxAdapter(
          child: Column(
            children: [
              SizedBox(
                height: 450,
                child: PageView.builder(
                  controller: _pageController,
                  itemCount: _recommendedProducts.length,
                  itemBuilder: (context, index) {
                    final product = _recommendedProducts[index];
                    return ProductCard(product: product);
                  },
                ),
              ),
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_back_ios),
                    onPressed: () {
                      _pageController.previousPage(
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeInOut,
                      );
                    },
                  ),
                  const SizedBox(width: 24),
                  IconButton(
                    icon: const Icon(Icons.arrow_forward_ios),
                    onPressed: () {
                      _pageController.nextPage(
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeInOut,
                      );
                    },
                  ),
                ],
              ),
            ],
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
  final Product product;

  const ProductCard({super.key, required this.product});

  Future<void> _launchUrl() async {
    if (product.affiliateUrl.isNotEmpty) {
      final Uri url = Uri.parse(product.affiliateUrl);
      if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
        print("Could not launch $url");
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
      elevation: 4,
      shadowColor: Colors.grey.shade200,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 5,
              child: Center(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: product.imageUrl.isNotEmpty
                      ? Image.network(
                          product.imageUrl,
                          fit: BoxFit.contain,
                          loadingBuilder: (context, child, loadingProgress) {
                            if (loadingProgress == null) return child;
                            return const Center(child: CircularProgressIndicator());
                          },
                          errorBuilder: (context, error, stackTrace) {
                            return Container(
                              color: Colors.grey.shade200,
                              child: const Icon(Icons.image_not_supported, color: Colors.grey, size: 50),
                            );
                          },
                        )
                      : Container(
                          color: Colors.grey.shade200,
                          child: const Icon(Icons.image_not_supported, color: Colors.grey, size: 50),
                        ),
                ),
              ),
            ),
            const SizedBox(height: 16),
            Text(
              product.name,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 8),
            Expanded(
              flex: 3,
              child: SingleChildScrollView(
                child: Text(
                  product.recommendation,
                  style: const TextStyle(fontSize: 14, color: Colors.black54),
                ),
              ),
            ),
            const Spacer(),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: product.affiliateUrl.isNotEmpty ? _launchUrl : null,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.pink.shade300,
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text(
                  "보러 가기", // TODO: Localize this string
                  style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
