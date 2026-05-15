import 'package:flutter/material.dart';
import '../models/product.dart';
import '../services/api_service.dart';
import '../utils/app_colors.dart';
import '../utils/app_constants.dart';
import '../utils/app_text_styles.dart';
import '../widgets/product_card.dart';
import '../widgets/product_shimmer_loading.dart';
import '../widgets/error_display_widget.dart';
import 'product_detail_screen.dart';

/// Home Screen displaying products in a responsive grid
class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Future<List<Product>> _productsFuture;
  final ScrollController _scrollController = ScrollController();
  String _searchQuery = '';
  List<Product> _filteredProducts = [];

  @override
  void initState() {
    super.initState();
    _productsFuture = ApiService.fetchProducts();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  /// Retry fetching products
  void _retryFetchProducts() {
    setState(() {
      _productsFuture = ApiService.fetchProducts();
    });
  }

  /// Navigate to product detail screen
  void _navigateToDetail(Product product) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => ProductDetailScreen(product: product),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isPortrait =
        MediaQuery.of(context).orientation == Orientation.portrait;
    final gridColumns = isPortrait
        ? AppConstants.gridColumnsPortrait
        : AppConstants.gridColumnsLandscape;

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(70),
        child: AppBar(
          elevation: 0,
          backgroundColor: AppColors.surface,
          title: Text(
            AppConstants.appName,
            style: AppTextStyles.headlineLarge.copyWith(
              color: AppColors.primary,
              fontWeight: FontWeight.w800,
              letterSpacing: 1,
            ),
          ),
          centerTitle: true,
          actions: [
            Padding(
              padding: const EdgeInsets.all(AppConstants.paddingSmall),
              child: Container(
                decoration: BoxDecoration(
                  color: AppColors.primary.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(AppConstants.borderRadiusSmall),
                ),
                child: IconButton(
                  icon: const Icon(Icons.shopping_cart_outlined),
                  color: AppColors.primary,
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Cart feature coming soon!'),
                        duration: Duration(seconds: 1),
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
      body: FutureBuilder<List<Product>>(
        future: _productsFuture,
        builder: (context, snapshot) {
          // Loading state
          if (snapshot.connectionState == ConnectionState.waiting) {
            return ProductShimmerLoading(itemCount: 6);
          }

          // Error state
          if (snapshot.hasError) {
            return ErrorDisplayWidget(
              message: snapshot.error.toString().replaceFirst('Exception: ', ''),
              onRetry: _retryFetchProducts,
            );
          }

          // No data state
          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return ErrorDisplayWidget(
              message: 'No products found',
              onRetry: _retryFetchProducts,
              icon: Icons.shopping_bag_outlined,
            );
          }

          // Success state - Display products in grid
          final products = snapshot.data!;
          _filteredProducts = _searchQuery.isEmpty
              ? products
              : products
                  .where((p) =>
                      p.title.toLowerCase().contains(_searchQuery.toLowerCase()))
                  .toList();

          return RefreshIndicator(
            onRefresh: () async {
              _retryFetchProducts();
              await _productsFuture;
            },
            color: AppColors.primary,
            child: CustomScrollView(
              controller: _scrollController,
              slivers: [
                // Header section with welcome message
                SliverToBoxAdapter(
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          AppColors.primary.withOpacity(0.08),
                          AppColors.accent.withOpacity(0.05),
                        ],
                      ),
                    ),
                    padding: const EdgeInsets.all(AppConstants.paddingMedium),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Welcome text
                        Text(
                          'Welcome Back! 👋',
                          style: AppTextStyles.headlineLarge.copyWith(
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                        const SizedBox(height: AppConstants.paddingSmall),
                        Text(
                          'Discover amazing products',
                          style: AppTextStyles.bodyMedium.copyWith(
                            color: AppColors.textSecondary,
                          ),
                        ),
                        const SizedBox(height: AppConstants.paddingMedium),
                        // Search bar
                        Container(
                          decoration: BoxDecoration(
                            color: AppColors.surface,
                            borderRadius: BorderRadius.circular(
                              AppConstants.borderRadiusMedium,
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: AppColors.textPrimary.withOpacity(0.1),
                                blurRadius: 10,
                                spreadRadius: 0,
                              ),
                            ],
                          ),
                          child: TextField(
                            onChanged: (value) {
                              setState(() {
                                _searchQuery = value;
                              });
                            },
                            decoration: InputDecoration(
                              hintText: 'Search products...',
                              hintStyle: AppTextStyles.bodyMedium.copyWith(
                                color: AppColors.textHint,
                              ),
                              prefixIcon: Icon(
                                Icons.search,
                                color: AppColors.primary,
                              ),
                              suffixIcon: _searchQuery.isNotEmpty
                                  ? IconButton(
                                      icon: const Icon(Icons.close),
                                      color: AppColors.textSecondary,
                                      onPressed: () {
                                        setState(() {
                                          _searchQuery = '';
                                        });
                                      },
                                    )
                                  : null,
                              border: InputBorder.none,
                              contentPadding: const EdgeInsets.symmetric(
                                horizontal: AppConstants.paddingMedium,
                                vertical: AppConstants.paddingSmall,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                // Results count
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppConstants.paddingMedium,
                      vertical: AppConstants.paddingSmall,
                    ),
                    child: Text(
                      'Found ${_filteredProducts.length} products',
                      style: AppTextStyles.bodySmall.copyWith(
                        color: AppColors.textSecondary,
                      ),
                    ),
                  ),
                ),
                // Products grid
                SliverPadding(
                  padding: const EdgeInsets.all(AppConstants.paddingMedium),
                  sliver: SliverGrid(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: gridColumns,
                      childAspectRatio: 0.75,
                      mainAxisSpacing: AppConstants.paddingMedium,
                      crossAxisSpacing: AppConstants.paddingMedium,
                    ),
                    delegate: SliverChildBuilderDelegate(
                      (context, index) {
                        return ProductCard(
                          product: _filteredProducts[index],
                          onTap: () =>
                              _navigateToDetail(_filteredProducts[index]),
                        );
                      },
                      childCount: _filteredProducts.length,
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
