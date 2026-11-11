import 'package:flutter/material.dart';

import '../../theme/app_theme.dart';
import '../../data/mock_data.dart';
import '../../models/app_models.dart';
import '../../widgets/crochet_image.dart';

class PatternDetailScreen extends StatefulWidget {
  final ProductItem? product;
  final int initialStep;
  final VoidCallback onBack;
  final VoidCallback? onAddToCart;
  final Function(String makerName)? onMakerTap;

  const PatternDetailScreen({
    super.key,
    this.product,
    this.initialStep = 1,
    required this.onBack,
    this.onAddToCart,
    this.onMakerTap,
  });

  @override
  State<PatternDetailScreen> createState() => _PatternDetailScreenState();
}

class _PatternDetailScreenState extends State<PatternDetailScreen> {
  late int _currentStep;
  int _selectedColorIndex = 0;

  final List<Color> _swatchColors = [
    const Color(0xFFD4798D), // Blush Pink
    const Color(0xFF6B8F77), // Sage Green
    const Color(0xFFF3E9D2), // Cream
    const Color(0xFFDCA852), // Mustard
  ];

  @override
  void initState() {
    super.initState();
    _currentStep = widget.initialStep.clamp(1, MockData.bunnySteps.length);
  }

  @override
  Widget build(BuildContext context) {
    final product = widget.product ?? MockData.products.first;
    final stepData = MockData.bunnySteps[_currentStep - 1];
    final progressFraction = _currentStep / MockData.bunnySteps.length;
    final progressPercent = (progressFraction * 100).round();

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Image with back button overlay
              Stack(
                children: [
                  Container(
                    width: double.infinity,
                    height: 250,
                    margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(24),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.08),
                          blurRadius: 10,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: CrochetImage(
                      imagePath: product.imagePath,
                      borderRadius: BorderRadius.circular(24),
                    ),
                  ),
                  Positioned(
                    top: 20,
                    left: 28,
                    child: GestureDetector(
                      onTap: widget.onBack,
                      child: Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: Colors.white.withValues(alpha: 0.9),
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withValues(alpha: 0.1),
                              blurRadius: 4,
                            ),
                          ],
                        ),
                        child: const Icon(
                          Icons.arrow_back_ios_new,
                          size: 16,
                          color: AppColors.textPrimary,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Title and Price
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              product.title,
                              style: AppTypography.serif(
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                                color: AppColors.textPrimary,
                              ),
                            ),
                            const SizedBox(height: 2),
                            Row(
                              children: [
                                GestureDetector(
                                  onTap: widget.onMakerTap != null
                                      ? () => widget.onMakerTap!(product.maker)
                                      : null,
                                  child: Text(
                                    'by ${product.maker} ',
                                    style: AppTypography.sans(
                                      fontSize: 12,
                                      color: widget.onMakerTap != null ? AppColors.primary : AppColors.textSecondary,
                                      fontWeight: widget.onMakerTap != null ? FontWeight.bold : FontWeight.normal,
                                    ),
                                  ),
                                ),
                                const Icon(Icons.star, size: 12, color: Color(0xFFECA332)),
                                Text(
                                  ' ${product.rating} (${product.reviewsCount})',
                                  style: AppTypography.sans(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                    color: AppColors.textPrimary,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        Text(
                          'Rs ${product.price.toString().replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},')}',
                          style: AppTypography.serif(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: AppColors.primary,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),

                    // Specs chips: Hook, Yarn, Level
                    Row(
                      children: [
                        _buildSpecChip('Hook', product.hookSize),
                        const SizedBox(width: 8),
                        _buildSpecChip('Yarn', product.yarnType),
                        const SizedBox(width: 8),
                        _buildSpecChip('Level', product.difficulty),
                      ],
                    ),
                    const SizedBox(height: 16),

                    // Custom color swatches
                    Text(
                      'Custom color',
                      style: AppTypography.sans(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: AppColors.textPrimary,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: List.generate(_swatchColors.length, (index) {
                        final isSelected = _selectedColorIndex == index;
                        return GestureDetector(
                          onTap: () {
                            setState(() {
                              _selectedColorIndex = index;
                            });
                          },
                          child: Container(
                            margin: const EdgeInsets.only(right: 12),
                            padding: const EdgeInsets.all(2.5),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: isSelected ? AppColors.primary : Colors.transparent,
                                width: 2,
                              ),
                            ),
                            child: Container(
                              width: 24,
                              height: 24,
                              decoration: BoxDecoration(
                                color: _swatchColors[index],
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: Colors.black.withValues(alpha: 0.1),
                                  width: 0.5,
                                ),
                              ),
                            ),
                          ),
                        );
                      }),
                    ),
                    const SizedBox(height: 20),

                    // Pattern tracker header
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Pattern step $_currentStep/${MockData.bunnySteps.length}',
                          style: AppTypography.sans(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: AppColors.primary,
                          ),
                        ),
                        Text(
                          '$progressPercent%',
                          style: AppTypography.sans(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: AppColors.primary,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 6),

                    // Progress bar
                    ClipRRect(
                      borderRadius: BorderRadius.circular(4),
                      child: LinearProgressIndicator(
                        value: progressFraction,
                        backgroundColor: AppColors.borderLight,
                        valueColor: const AlwaysStoppedAnimation<Color>(AppColors.primary),
                        minHeight: 6,
                      ),
                    ),
                    const SizedBox(height: 14),

                    // Instruction box (with crafting tip)
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: AppColors.surface,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: AppColors.borderLight),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            stepData.instruction,
                            style: AppTypography.sans(
                              fontSize: 13,
                              fontWeight: FontWeight.bold,
                              color: AppColors.textPrimary,
                            ),
                          ),
                          const SizedBox(height: 6),
                          Text(
                            stepData.craftingTip,
                            style: AppTypography.sans(
                              fontSize: 12,
                              color: AppColors.textSecondary,
                              fontStyle: FontStyle.italic,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 16),

                    // Back & Next Step Buttons
                    Row(
                      children: [
                        Expanded(
                          child: SizedBox(
                            height: 44,
                            child: OutlinedButton(
                              onPressed: _currentStep > 1
                                  ? () {
                                      setState(() {
                                        _currentStep--;
                                      });
                                    }
                                  : null,
                              style: OutlinedButton.styleFrom(
                                padding: EdgeInsets.zero,
                              ),
                              child: const Text('Back'),
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: SizedBox(
                            height: 44,
                            child: ElevatedButton(
                              onPressed: _currentStep < MockData.bunnySteps.length
                                  ? () {
                                      setState(() {
                                        _currentStep++;
                                      });
                                    }
                                  : null,
                              style: ElevatedButton.styleFrom(
                                backgroundColor: AppColors.sage,
                                padding: EdgeInsets.zero,
                              ),
                              child: Text(
                                _currentStep == MockData.bunnySteps.length
                                    ? 'Completed!'
                                    : 'Next step',
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    if (widget.onAddToCart != null) ...[
                      const SizedBox(height: 14),
                      SizedBox(
                        width: double.infinity,
                        height: 50,
                        child: ElevatedButton.icon(
                          onPressed: widget.onAddToCart,
                          icon: const Icon(Icons.shopping_bag_outlined, size: 18),
                          label: Text(
                            'Add to Cart • Rs ${product.price.toString().replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},')}',
                          ),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.primary,
                          ),
                        ),
                      ),
                    ],
                    const SizedBox(height: 24),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSpecChip(String label, String value) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
        decoration: BoxDecoration(
          color: AppColors.surfaceWarm,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: AppColors.borderLight),
        ),
        child: Column(
          children: [
            Text(
              label,
              style: AppTypography.sans(
                fontSize: 10,
                color: AppColors.textMuted,
              ),
            ),
            const SizedBox(height: 2),
            Text(
              value,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: AppTypography.sans(
                fontSize: 11,
                fontWeight: FontWeight.bold,
                color: AppColors.textPrimary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
