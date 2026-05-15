import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:shimmer/shimmer.dart';
import '../models/product.dart';
import '../utils/app_colors.dart';
import '../utils/app_constants.dart';
import '../utils/app_text_styles.dart';

/// Reusable Product Card widget
/// Displays a product with image, title, price, and rating
class ProductCard extends StatefulWidget {
  final Product product;
  final VoidCallback onTap;

  const ProductCard({Key? key, required this.product, required this.onTap})
    : super(key: key);

  @override
  State<ProductCard> createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  bool _isHovered = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );

    _scaleAnimation = Tween<double>(begin: 1.0, end: 0.95).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _onHoverStart() {
    if (!_isHovered) {
      setState(() => _isHovered = true);
      _controller.forward();
    }
  }

  void _onHoverEnd() {
    if (_isHovered) {
      setState(() => _isHovered = false);
      _controller.reverse();
    }
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => _onHoverStart(),
      onExit: (_) => _onHoverEnd(),
      child: GestureDetector(
        onTap: () {
          _onHoverEnd();
          widget.onTap();
        },
        onTapDown: (_) => _onHoverStart(),
        onTapCancel: _onHoverEnd,
        child: ScaleTransition(
          scale: _scaleAnimation,
          child: Card(
            elevation: _isHovered ? AppConstants.elevationLarge : AppConstants.elevationMedium,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(AppConstants.borderRadiusMedium),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(AppConstants.borderRadiusMedium),
              child: Stack(
                children: [
                  // Gradient background on hover
                  if (_isHovered)
                    Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [
                            AppColors.primary.withOpacity(0.05),
                            AppColors.accent.withOpacity(0.05),
                          ],
                        ),
                      ),
                    ),
                  // Main column
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Product Image with Hero animation
                      Expanded(
                        child: Hero(
                          tag: 'product_${widget.product.id}',
                          child: Container(
                            width: double.infinity,
                            color: AppColors.divider,
                            child: Stack(
                              children: [
                                CachedNetworkImage(
                                  imageUrl: widget.product.image,
                                  fit: BoxFit.cover,
                                  placeholder: (context, url) =>
                                      _buildImagePlaceholder(),
                                  errorWidget: (context, url, error) =>
                                      Container(
                                    color: AppColors.divider,
                                    child: const Icon(
                                      Icons.image_not_supported_outlined,
                                      color: AppColors.textHint,
                                    ),
                                  ),
                                ),
                                // Discount badge (optional)
                                if (_isHovered)
                                  Positioned(
                                    top: AppConstants.paddingSmall,
                                    right: AppConstants.paddingSmall,
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: AppConstants.paddingSmall,
                                        vertical: AppConstants.paddingXSmall,
                                      ),
                                      decoration: BoxDecoration(
                                        color: AppColors.error,
                                        borderRadius: BorderRadius.circular(
                                          AppConstants.borderRadiusSmall,
                                        ),
                                      ),
                                      child: Text(
                                        'Hot',
                                        style: AppTextStyles.labelSmall
                                            .copyWith(
                                          color: AppColors.surface,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      // Product Details
                      Padding(
                        padding: const EdgeInsets.all(AppConstants.paddingSmall),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Product Title
                            Text(
                              widget.product.title,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: AppTextStyles.titleMedium.copyWith(
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const SizedBox(height: AppConstants.paddingXSmall),
                            // Category Badge
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: AppConstants.paddingSmall,
                                vertical: AppConstants.paddingXSmall,
                              ),
                              decoration: BoxDecoration(
                                color: AppColors.primary.withOpacity(0.1),
                                borderRadius: BorderRadius.circular(
                                  AppConstants.borderRadiusSmall,
                                ),
                              ),
                              child: Text(
                                widget.product.category.toUpperCase(),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: AppTextStyles.labelSmall.copyWith(
                                  color: AppColors.primary,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            const SizedBox(height: AppConstants.paddingSmall),
                            // Price and Rating Row
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                // Price
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Price',
                                      style: AppTextStyles.labelSmall.copyWith(
                                        color: AppColors.textSecondary,
                                      ),
                                    ),
                                    Text(
                                      '\$${widget.product.price.toStringAsFixed(2)}',
                                      style: AppTextStyles.headlineSmall.copyWith(
                                        color: AppColors.primary,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                                // Rating
                                if (widget.product.rating != null)
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: AppConstants.paddingSmall,
                                      vertical: AppConstants.paddingXSmall,
                                    ),
                                    decoration: BoxDecoration(
                                      color: AppColors.warning.withOpacity(0.1),
                                      borderRadius: BorderRadius.circular(
                                        AppConstants.borderRadiusSmall,
                                      ),
                                    ),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        const Icon(
                                          Icons.star_rounded,
                                          color: AppColors.warning,
                                          size: 16,
                                        ),
                                        const SizedBox(width: 4),
                                        Text(
                                          widget.product.rating!.rate
                                              .toStringAsFixed(1),
                                          style: AppTextStyles.labelSmall
                                              .copyWith(
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  /// Build image placeholder while loading
  Widget _buildImagePlaceholder() {
    return Shimmer.fromColors(
      baseColor: AppColors.shimmerBase,
      highlightColor: AppColors.shimmerHighlight,
      child: Container(color: AppColors.shimmerBase),
    );
  }
}
