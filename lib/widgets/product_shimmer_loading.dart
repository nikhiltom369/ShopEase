import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import '../utils/app_colors.dart';
import '../utils/app_constants.dart';

/// Shimmer loading skeleton for product cards
class ProductShimmerLoading extends StatelessWidget {
  final int itemCount;

  const ProductShimmerLoading({Key? key, this.itemCount = 6}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: const EdgeInsets.all(AppConstants.paddingMedium),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: AppConstants.gridColumnsPortrait,
        childAspectRatio: 0.75,
        mainAxisSpacing: AppConstants.paddingMedium,
        crossAxisSpacing: AppConstants.paddingMedium,
      ),
      itemCount: itemCount,
      itemBuilder: (context, index) => _buildShimmerCard(),
    );
  }

  Widget _buildShimmerCard() {
    return Shimmer.fromColors(
      baseColor: AppColors.shimmerBase,
      highlightColor: AppColors.shimmerHighlight,
      child: Card(
        elevation: AppConstants.elevationMedium,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppConstants.borderRadiusMedium),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(AppConstants.borderRadiusMedium),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Image placeholder
              Expanded(
                child: Container(
                  width: double.infinity,
                  color: AppColors.shimmerBase,
                ),
              ),
              // Details placeholder
              Padding(
                padding: const EdgeInsets.all(AppConstants.paddingSmall),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Title placeholder
                    Container(
                      width: double.infinity,
                      height: 16,
                      color: AppColors.shimmerBase,
                    ),
                    const SizedBox(height: AppConstants.paddingXSmall),
                    // Category placeholder
                    Container(
                      width: 80,
                      height: 12,
                      color: AppColors.shimmerBase,
                    ),
                    const SizedBox(height: AppConstants.paddingSmall),
                    // Price placeholder
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          width: 60,
                          height: 16,
                          color: AppColors.shimmerBase,
                        ),
                        Container(
                          width: 40,
                          height: 16,
                          color: AppColors.shimmerBase,
                        ),
                      ],
                    ),
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
