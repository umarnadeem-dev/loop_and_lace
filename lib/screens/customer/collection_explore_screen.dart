import 'package:flutter/material.dart';

import '../../theme/app_theme.dart';
import '../../data/mock_data.dart';
import '../../models/app_models.dart';
import '../../widgets/crochet_image.dart';

class CollectionExploreScreen extends StatefulWidget {
  final VoidCallback onBack;
  final Function(ProductItem) onProductTap;
  final Function(String makerName)? onMakerTap;
  final VoidCallback onCustomOrderTap;

  const CollectionExploreScreen({
    super.key,
    required this.onBack,
    required this.onProductTap,
    this.onMakerTap,
    required this.onCustomOrderTap,
  });

  @override
  State<CollectionExploreScreen> createState() => _CollectionExploreScreenState();
}

class _CollectionExploreScreenState extends State<CollectionExploreScreen> {
  String _selectedFilter = 'All';
  final List<String> _filters = ['All', 'Handmade', 'Patterns'];

  @override
  Widget build(BuildContext context) {
    // Curated Autumn Drop & Granny Square items
    final allCollectionItems = [
      ...MockData.products.where((p) =>
          p.title.toLowerCase().contains('granny') ||
          p.category == 'Wearables' ||
          p.category == 'Bags' ||
          p.category == 'Blankets'),
      ...MockData.patterns.where((p) =>
          p.title.toLowerCase().contains('granny') ||
          p.category == 'Wearables' ||
          p.category == 'Blankets'),
    ];

    final filteredItems = allCollectionItems.where((item) {
      if (_selectedFilter == 'Handmade') return !item.isPattern;
      if (_selectedFilter == 'Patterns') return item.isPattern;
      return true;
    }).toList();

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, size: 18, color: AppColors.textPrimary),
          onPressed: widget.onBack,
        ),
        title: Text(
          'Autumn Drop',
          style: AppTypography.serif(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: AppColors.textPrimary,
          ),
        ),
        centerTitle: false,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Editorial Hero Card
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(18),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [
                      Color(0xFF8B254D),
                      Color(0xFFA23963),
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(22),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.primary.withValues(alpha: 0.2),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                            decoration: BoxDecoration(
                              color: Colors.white.withValues(alpha: 0.25),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Text(
                              'SEASONAL EDIT',
                              style: AppTypography.sans(
                                fontSize: 10,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                                letterSpacing: 0.8,
                              ),
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'Granny squares\nare back',
                            style: AppTypography.serif(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              height: 1.15,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'Warm cotton-wool cardigans, heirloom throws, and retro square tote bags crafted by Pakistani artisans.',
                            style: AppTypography.sans(
                              fontSize: 11,
                              color: Colors.white.withValues(alpha: 0.9),
                              height: 1.35,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 12),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(16),
                      child: const CrochetImage(
                        imagePath: 'assets/images/cardigan.jpg',
                        width: 105,
                        height: 135,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),

              // Filter Chips
              Row(
                children: _filters.map((filter) {
                  final isSel = _selectedFilter == filter;
                  return Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: ChoiceChip(
                      label: Text(filter),
                      selected: isSel,
                      onSelected: (val) {
                        if (val) setState(() => _selectedFilter = filter);
                      },
                      backgroundColor: AppColors.surface,
                      selectedColor: AppColors.primary,
                      labelStyle: AppTypography.sans(
                        fontSize: 12,
                        fontWeight: isSel ? FontWeight.bold : FontWeight.w500,
                        color: isSel ? Colors.white : AppColors.textPrimary,
                      ),
                      showCheckmark: false,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18),
                        side: BorderSide(
                          color: isSel ? AppColors.primary : AppColors.border,
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
              const SizedBox(height: 16),

              Text(
                '${filteredItems.length} featured pieces in this drop',
                style: AppTypography.sans(
                  fontSize: 12,
                  color: AppColors.textSecondary,
                ),
              ),
              const SizedBox(height: 12),

              // Curated Grid
              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 14,
                  mainAxisSpacing: 14,
                  childAspectRatio: 0.72,
                ),
                itemCount: filteredItems.length,
                itemBuilder: (context, index) {
                  final item = filteredItems[index];
                  return _buildCollectionCard(item);
                },
              ),
              const SizedBox(height: 22),

              // Bespoke Call-to-action at bottom
              GestureDetector(
                onTap: widget.onCustomOrderTap,
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: AppColors.surfaceWarm,
                    borderRadius: BorderRadius.circular(18),
                    border: Border.all(color: AppColors.borderLight),
                  ),
                  child: Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(10),
                        decoration: const BoxDecoration(
                          color: AppColors.blush,
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(Icons.auto_awesome, color: AppColors.primary, size: 20),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Want custom Autumn colors?',
                              style: AppTypography.serif(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: AppColors.textPrimary,
                              ),
                            ),
                            Text(
                              'Request a bespoke size or yarn shade from our makers',
                              style: AppTypography.sans(
                                fontSize: 11,
                                color: AppColors.textSecondary,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const Icon(Icons.chevron_right, size: 18, color: AppColors.primary),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCollectionCard(ProductItem product) {
    return GestureDetector(
      onTap: () => widget.onProductTap(product),
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(18),
          border: Border.all(color: AppColors.borderLight),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.03),
              blurRadius: 6,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Stack(
                children: [
                  Positioned.fill(
                    child: CrochetImage(
                      imagePath: product.imagePath,
                      borderRadius: const BorderRadius.vertical(top: Radius.circular(18)),
                    ),
                  ),
                  Positioned(
                    top: 8,
                    left: 8,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 3),
                      decoration: BoxDecoration(
                        color: product.isPattern ? AppColors.primary : AppColors.sage,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        product.isPattern ? 'Pattern' : 'Handmade',
                        style: AppTypography.sans(
                          fontSize: 9,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    top: 8,
                    right: 8,
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          product.isFavorite = !product.isFavorite;
                        });
                      },
                      child: Container(
                        padding: const EdgeInsets.all(6),
                        decoration: BoxDecoration(
                          color: Colors.white.withValues(alpha: 0.9),
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          product.isFavorite ? Icons.favorite : Icons.favorite_border,
                          size: 15,
                          color: product.isFavorite ? AppColors.primary : AppColors.textMuted,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(11),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product.title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: AppTypography.sans(
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  const SizedBox(height: 2),
                  GestureDetector(
                    onTap: widget.onMakerTap != null ? () => widget.onMakerTap!(product.maker) : null,
                    child: Text(
                      product.maker,
                      style: AppTypography.sans(
                        fontSize: 11,
                        color: widget.onMakerTap != null ? AppColors.primary : AppColors.textMuted,
                        fontWeight: widget.onMakerTap != null ? FontWeight.w600 : FontWeight.normal,
                      ),
                    ),
                  ),
                  const SizedBox(height: 6),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        product.price == 0
                            ? 'Free'
                            : 'Rs ${product.price.toString().replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (m) => '${m[1]},')}',
                        style: AppTypography.sans(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: AppColors.primary,
                        ),
                      ),
                      Row(
                        children: [
                          const Icon(Icons.star, size: 12, color: Color(0xFFECA332)),
                          const SizedBox(width: 2),
                          Text(
                            product.rating.toString(),
                            style: AppTypography.sans(
                              fontSize: 11,
                              fontWeight: FontWeight.w600,
                              color: AppColors.textPrimary,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
