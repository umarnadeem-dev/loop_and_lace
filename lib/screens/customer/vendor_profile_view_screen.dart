import 'package:flutter/material.dart';

import '../../theme/app_theme.dart';
import '../../data/mock_data.dart';
import '../../models/app_models.dart';
import '../../widgets/crochet_image.dart';

class VendorProfileViewScreen extends StatefulWidget {
  final String vendorName;
  final VoidCallback onBack;
  final Function(ProductItem) onProductTap;
  final VoidCallback onRequestCustomTap;

  const VendorProfileViewScreen({
    super.key,
    required this.vendorName,
    required this.onBack,
    required this.onProductTap,
    required this.onRequestCustomTap,
  });

  @override
  State<VendorProfileViewScreen> createState() => _VendorProfileViewScreenState();
}

class _VendorProfileViewScreenState extends State<VendorProfileViewScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  late VendorItem _vendor;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _vendor = MockData.vendors.firstWhere(
      (v) => v.name.toLowerCase() == widget.vendorName.toLowerCase(),
      orElse: () => VendorItem(
        id: 'v_default',
        name: widget.vendorName,
        avatarLetter: widget.vendorName.isNotEmpty ? widget.vendorName[0] : 'S',
        rating: 4.9,
        totalOrders: 54,
        status: 'Active',
        bio: 'Passionate Pakistani crochet maker hand-spinning joy one loop at a time.',
        location: 'Lahore, Pakistan',
        reviewsCount: 120,
      ),
    );
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Maker's products & patterns
    final makerProducts = MockData.products
        .where((p) => p.maker.toLowerCase().contains(widget.vendorName.toLowerCase()) || widget.vendorName.toLowerCase().contains(p.maker.toLowerCase()))
        .toList();
    final makerPatterns = MockData.patterns
        .where((p) => p.maker.toLowerCase().contains(widget.vendorName.toLowerCase()) || widget.vendorName.toLowerCase().contains(p.maker.toLowerCase()))
        .toList();

    // Fallbacks if list is empty so the screen looks complete
    final displayProducts = makerProducts.isNotEmpty ? makerProducts : MockData.products.take(2).toList();
    final displayPatterns = makerPatterns.isNotEmpty ? makerPatterns : MockData.patterns.take(2).toList();

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: NestedScrollView(
          headerSliverBuilder: (context, innerBoxIsScrolled) {
            return [
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Back and Share Row
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          IconButton(
                            padding: EdgeInsets.zero,
                            constraints: const BoxConstraints(),
                            icon: const Icon(Icons.arrow_back_ios_new, size: 18),
                            onPressed: widget.onBack,
                          ),
                          IconButton(
                            icon: const Icon(Icons.share_outlined, size: 20),
                            onPressed: () {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text('Shop link copied: loopandlace.pk/makers/${_vendor.name.toLowerCase().replaceAll(' ', '')}'),
                                  backgroundColor: AppColors.sage,
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),

                      // Maker Avatar & Info Header
                      Row(
                        children: [
                          Container(
                            width: 72,
                            height: 72,
                            decoration: BoxDecoration(
                              color: AppColors.blush,
                              shape: BoxShape.circle,
                              border: Border.all(color: AppColors.primaryLight, width: 2),
                            ),
                            child: Center(
                              child: Text(
                                _vendor.avatarLetter,
                                style: AppTypography.serif(
                                  fontSize: 32,
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.primary,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      _vendor.name,
                                      style: AppTypography.serif(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                        color: AppColors.textPrimary,
                                      ),
                                    ),
                                    const SizedBox(width: 4),
                                    const Icon(Icons.verified, size: 16, color: AppColors.primary),
                                  ],
                                ),
                                const SizedBox(height: 3),
                                Text(
                                  _vendor.location ?? 'Lahore, Pakistan',
                                  style: AppTypography.sans(
                                    fontSize: 12,
                                    color: AppColors.textSecondary,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Row(
                                  children: [
                                    const Icon(Icons.star, size: 14, color: Color(0xFFE6A122)),
                                    const SizedBox(width: 4),
                                    Text(
                                      '${_vendor.rating} (${_vendor.reviewsCount ?? 142} reviews) • ${_vendor.totalOrders} crafted',
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
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),

                      // Bio Box
                      Container(
                        padding: const EdgeInsets.all(14),
                        decoration: BoxDecoration(
                          color: AppColors.surface,
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(color: AppColors.borderLight),
                        ),
                        child: Text(
                          _vendor.bio ?? 'Creating bespoke heirloom crochet pieces with local artisanal yarn.',
                          style: AppTypography.sans(
                            fontSize: 12,
                            color: AppColors.textSecondary,
                            height: 1.4,
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),

                      // Request Custom Button
                      SizedBox(
                        width: double.infinity,
                        height: 46,
                        child: ElevatedButton.icon(
                          onPressed: widget.onRequestCustomTap,
                          icon: const Icon(Icons.auto_awesome, size: 16),
                          label: Text('Request Custom Order from ${_vendor.name}'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.primary,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(14),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),

                      // Tab Bar
                      TabBar(
                        controller: _tabController,
                        labelColor: AppColors.primary,
                        unselectedLabelColor: AppColors.textSecondary,
                        indicatorColor: AppColors.primary,
                        indicatorWeight: 2.5,
                        labelStyle: AppTypography.sans(fontSize: 13, fontWeight: FontWeight.bold),
                        unselectedLabelStyle: AppTypography.sans(fontSize: 13),
                        tabs: const [
                          Tab(text: 'Creations'),
                          Tab(text: 'Patterns'),
                          Tab(text: 'Reviews'),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ];
          },
          body: TabBarView(
            controller: _tabController,
            children: [
              // Creations Tab
              _buildProductGrid(displayProducts),

              // Patterns Tab
              _buildProductGrid(displayPatterns),

              // Reviews Tab
              _buildReviewsList(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildProductGrid(List<ProductItem> items) {
    return GridView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 14,
        mainAxisSpacing: 14,
        childAspectRatio: 0.74,
      ),
      itemCount: items.length,
      itemBuilder: (context, index) {
        final p = items[index];
        return GestureDetector(
          onTap: () => widget.onProductTap(p),
          child: Container(
            decoration: BoxDecoration(
              color: AppColors.surface,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: AppColors.borderLight),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: ClipRRect(
                    borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
                    child: CrochetImage(
                      imagePath: p.imagePath,
                      fit: BoxFit.cover,
                      width: double.infinity,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        p.title,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: AppTypography.serif(
                          fontSize: 13,
                          fontWeight: FontWeight.bold,
                          color: AppColors.textPrimary,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            p.price == 0 ? 'Free' : 'Rs ${p.price}',
                            style: AppTypography.sans(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: AppColors.primary,
                            ),
                          ),
                          Row(
                            children: [
                              const Icon(Icons.star, size: 12, color: Color(0xFFE6A122)),
                              const SizedBox(width: 2),
                              Text(
                                '${p.rating}',
                                style: AppTypography.sans(fontSize: 11, color: AppColors.textSecondary),
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
      },
    );
  }

  Widget _buildReviewsList() {
    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
      itemCount: MockData.sampleReviews.length,
      itemBuilder: (context, index) {
        final rev = MockData.sampleReviews[index];
        return Container(
          margin: const EdgeInsets.only(bottom: 12),
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: AppColors.surface,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: AppColors.borderLight),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    rev.userName,
                    style: AppTypography.sans(fontSize: 13, fontWeight: FontWeight.bold, color: AppColors.textPrimary),
                  ),
                  Row(
                    children: List.generate(
                      5,
                      (i) => const Icon(Icons.star, size: 14, color: Color(0xFFE6A122)),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 2),
              Text(
                'Purchased ${rev.productTitle ?? "Handmade Item"} • ${rev.dateText}',
                style: AppTypography.sans(fontSize: 10, color: AppColors.textMuted),
              ),
              const SizedBox(height: 8),
              Text(
                rev.comment,
                style: AppTypography.sans(fontSize: 12, color: AppColors.textSecondary, height: 1.3),
              ),
              const SizedBox(height: 8),
              Wrap(
                spacing: 6,
                children: rev.tags.map((tag) {
                  return Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                    decoration: BoxDecoration(
                      color: AppColors.surfaceWarm,
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Text(
                      tag,
                      style: AppTypography.sans(fontSize: 10, color: AppColors.textSecondary),
                    ),
                  );
                }).toList(),
              ),
            ],
          ),
        );
      },
    );
  }
}

