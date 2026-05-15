import 'package:flutter/material.dart';
import '../utils/app_colors.dart';
import '../utils/app_text_styles.dart';

/// Rating display widget
class RatingWidget extends StatelessWidget {
  final double rate;
  final int count;

  const RatingWidget({Key? key, required this.rate, required this.count})
    : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        // Star rating
        ...List.generate(5, (index) {
          return Icon(
            index < rate.floor()
                ? Icons.star_rounded
                : (index < rate)
                ? Icons.star_half_rounded
                : Icons.star_outline_rounded,
            color: AppColors.warning,
            size: 20,
          );
        }),
        const SizedBox(width: 8),
        // Rate value
        Text(
          '$rate',
          style: AppTextStyles.titleMedium.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(width: 8),
        // Review count
        Text('($count reviews)', style: AppTextStyles.bodySmall),
      ],
    );
  }
}
