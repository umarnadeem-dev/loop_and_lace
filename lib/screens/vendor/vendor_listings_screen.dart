import 'package:flutter/material.dart';

import '../../theme/app_theme.dart';
import '../../data/mock_data.dart';
import '../../models/app_models.dart';
import '../../widgets/crochet_image.dart';

class VendorListingsScreen extends StatefulWidget {
  final VoidCallback onBack;
  final VoidCallback onNewListingTap;

  const VendorListingsScreen({
    super.key,
    required this.onBack,
    required this.onNewListingTap,
  });

  @override
  State<VendorListingsScreen> createState() => _VendorListingsScreenState();
}

class _VendorListingsScreenState extends State<VendorListingsScreen> {
  String _selectedTab = 'All';
  final List<String> _tabs = ['All', 'Physical Items', 'Digital Patterns'];
  late List<ProductItem> _items;

  @override
  void initState() {
    super.initState();
    // Combine vendor's products & patterns
    _items = [
      ...MockData.products,
      ...MockData.patterns,
    ];
  }

  void _showQuickEditModal(ProductItem item) {
    final titleController = TextEditingController(text: item.title);
    final priceController = TextEditingController(text: item.price.toString());

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: AppColors.surface,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (context) {
        return Padding(
          padding: EdgeInsets.only(
            left: 20,
            right: 20,
            top: 20,
            bottom: MediaQuery.of(context).viewInsets.bottom + 20,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Quick Edit Listing',
                    style: AppTypography.serif(fontSize: 18, fontWeight: FontWeight.bold, color: AppColors.textPrimary),
                  ),
                  IconButton(
                    icon: const Icon(Icons.close, size: 20),
                    onPressed: () => Navigator.pop(context),
                  ),
                ],
              ),
              const SizedBox(height: 14),

              Text(
                'Listing Title',
                style: AppTypography.sans(fontSize: 12, fontWeight: FontWeight.bold, color: AppColors.textSecondary),
              ),
              const SizedBox(height: 4),
              TextField(
                controller: titleController,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: AppColors.surfaceWarm,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(14),
                    borderSide: const BorderSide(color: AppColors.borderLight),
                  ),
                ),
              ),
              const SizedBox(height: 12),

              Text(
                'Price (PKR)',
                style: AppTypography.sans(fontSize: 12, fontWeight: FontWeight.bold, color: AppColors.textSecondary),
              ),
              const SizedBox(height: 4),
              TextField(
                controller: priceController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: AppColors.surfaceWarm,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(14),
                    borderSide: const BorderSide(color: AppColors.borderLight),
                  ),
                ),
              ),
              const SizedBox(height: 18),

              SizedBox(
                width: double.infinity,
                height: 48,
                child: ElevatedButton(
                  onPressed: () {
                    final newPrice = int.tryParse(priceController.text.trim()) ?? item.price;
                    setState(() {
                      final idx = _items.indexOf(item);
                      if (idx != -1) {
                        _items[idx] = ProductItem(
                          id: item.id,
                          title: titleController.text.trim(),
                          maker: item.maker,
                          price: newPrice,
                          rating: item.rating,
                          reviewsCount: item.reviewsCount,
                          imagePath: item.imagePath,
                          category: item.category,
                          hookSize: item.hookSize,
                          yarnType: item.yarnType,
                          difficulty: item.difficulty,
                          isPattern: item.isPattern,
                          isFavorite: item.isFavorite,
                        );
                      }
                    });
                    Navigator.pop(context);
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Listing details updated!'),
                        backgroundColor: AppColors.sage,
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                  ),
                  child: const Text('Save Changes'),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final filteredItems = _items.where((i) {
      if (_selectedTab == 'Physical Items') return !i.isPattern;
      if (_selectedTab == 'Digital Patterns') return i.isPattern;
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
          'My Listings & Catalog',
          style: AppTypography.serif(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: AppColors.textPrimary,
          ),
        ),
        centerTitle: false,
        actions: [
          IconButton(
            icon: const Icon(Icons.add, color: AppColors.primary),
            onPressed: widget.onNewListingTap,
          ),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Filter Chips
              Row(
                children: _tabs.map((tab) {
                  final isSel = _selectedTab == tab;
                  return Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: ChoiceChip(
                      label: Text(tab),
                      selected: isSel,
                      onSelected: (val) {
                        if (val) setState(() => _selectedTab = tab);
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
                        borderRadius: BorderRadius.circular(16),
                        side: BorderSide(
                          color: isSel ? AppColors.primary : AppColors.borderLight,
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
              const SizedBox(height: 16),

              // Listings Count & Quick Info
              Text(
                '${filteredItems.length} active items in Sage Studio catalog',
                style: AppTypography.sans(
                  fontSize: 12,
                  color: AppColors.textSecondary,
                ),
              ),
              const SizedBox(height: 12),

              // Listings ListView
              Expanded(
                child: ListView.builder(
                  itemCount: filteredItems.length,
                  itemBuilder: (context, index) {
                    final item = filteredItems[index];
                    return Container(
                      margin: const EdgeInsets.only(bottom: 12),
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: AppColors.surface,
                        borderRadius: BorderRadius.circular(18),
                        border: Border.all(color: AppColors.borderLight),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.02),
                            blurRadius: 4,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Row(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(12),
                            child: CrochetImage(
                              imagePath: item.imagePath,
                              width: 60,
                              height: 60,
                            ),
                          ),
                          const SizedBox(width: 14),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Expanded(
                                      child: Text(
                                        item.title,
                                        style: AppTypography.serif(
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold,
                                          color: AppColors.textPrimary,
                                        ),
                                      ),
                                    ),
                                    Container(
                                      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                                      decoration: BoxDecoration(
                                        color: item.isPattern ? AppColors.blush : AppColors.sageLight,
                                        borderRadius: BorderRadius.circular(6),
                                      ),
                                      child: Text(
                                        item.isPattern ? 'Pattern' : 'Physical',
                                        style: AppTypography.sans(
                                          fontSize: 9,
                                          fontWeight: FontWeight.bold,
                                          color: item.isPattern ? AppColors.primary : AppColors.sageDark,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 2),
                                Text(
                                  '${item.category} • Hook: ${item.hookSize}',
                                  style: AppTypography.sans(
                                    fontSize: 11,
                                    color: AppColors.textMuted,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      item.price == 0 ? 'Free' : 'Rs ${item.price.toString().replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (m) => '${m[1]},')}',
                                      style: AppTypography.sans(
                                        fontSize: 13,
                                        fontWeight: FontWeight.bold,
                                        color: AppColors.primary,
                                      ),
                                    ),
                                    Row(
                                      children: [
                                        const Icon(Icons.star, size: 12, color: Color(0xFFE6A122)),
                                        const SizedBox(width: 2),
                                        Text(
                                          '${item.rating} (${item.reviewsCount})',
                                          style: AppTypography.sans(fontSize: 11, color: AppColors.textSecondary),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(width: 10),
                          IconButton(
                            icon: const Icon(Icons.edit_outlined, size: 18, color: AppColors.textMuted),
                            onPressed: () => _showQuickEditModal(item),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),

              // Bottom Button: Add New Listing
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton.icon(
                  onPressed: widget.onNewListingTap,
                  icon: const Icon(Icons.add, size: 18),
                  label: const Text('+ Create New Listing'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }
}

