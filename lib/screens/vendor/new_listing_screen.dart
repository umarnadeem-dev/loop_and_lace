import 'package:flutter/material.dart';

import '../../theme/app_theme.dart';
import '../../widgets/crochet_image.dart';

class NewListingScreen extends StatefulWidget {
  final VoidCallback onBack;
  final VoidCallback onPublish;

  const NewListingScreen({
    super.key,
    required this.onBack,
    required this.onPublish,
  });

  @override
  State<NewListingScreen> createState() => _NewListingScreenState();
}

class _NewListingScreenState extends State<NewListingScreen> {
  String _listingType = 'Product'; // 'Product' or 'Pattern'
  final TextEditingController _titleController =
      TextEditingController(text: 'Granny Square Bag');
  final TextEditingController _priceController =
      TextEditingController(text: 'Rs 3,200');
  final TextEditingController _timeController =
      TextEditingController(text: '3 days');

  String _selectedCategory = 'Bag';
  final List<String> _categories = ['Amigurumi', 'Wearable', 'Blanket', 'Bag'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header
              Row(
                children: [
                  IconButton(
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(),
                    icon: const Icon(Icons.arrow_back_ios_new, size: 18),
                    onPressed: widget.onBack,
                  ),
                  const SizedBox(width: 12),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Sage Studio',
                        style: AppTypography.sans(
                          fontSize: 12,
                          color: AppColors.textSecondary,
                        ),
                      ),
                      Text(
                        'New listing',
                        style: AppTypography.serif(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: AppColors.textPrimary,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 18),

              // Product / Pattern Switch
              Container(
                padding: const EdgeInsets.all(4),
                decoration: BoxDecoration(
                  color: AppColors.surfaceWarm,
                  borderRadius: BorderRadius.circular(25),
                  border: Border.all(color: AppColors.borderLight),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            _listingType = 'Product';
                          });
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          decoration: BoxDecoration(
                            color: _listingType == 'Product'
                                ? AppColors.surface
                                : Colors.transparent,
                            borderRadius: BorderRadius.circular(20),
                            boxShadow: _listingType == 'Product'
                                ? [
                                    BoxShadow(
                                      color: Colors.black.withValues(alpha: 0.05),
                                      blurRadius: 4,
                                    ),
                                  ]
                                : null,
                          ),
                          child: Text(
                            'Product',
                            textAlign: TextAlign.center,
                            style: AppTypography.sans(
                              fontSize: 13,
                              fontWeight: _listingType == 'Product'
                                  ? FontWeight.bold
                                  : FontWeight.w500,
                              color: _listingType == 'Product'
                                  ? AppColors.primary
                                  : AppColors.textSecondary,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            _listingType = 'Pattern';
                          });
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          decoration: BoxDecoration(
                            color: _listingType == 'Pattern'
                                ? AppColors.surface
                                : Colors.transparent,
                            borderRadius: BorderRadius.circular(20),
                            boxShadow: _listingType == 'Pattern'
                                ? [
                                    BoxShadow(
                                      color: Colors.black.withValues(alpha: 0.05),
                                      blurRadius: 4,
                                    ),
                                  ]
                                : null,
                          ),
                          child: Text(
                            'Pattern',
                            textAlign: TextAlign.center,
                            style: AppTypography.sans(
                              fontSize: 13,
                              fontWeight: _listingType == 'Pattern'
                                  ? FontWeight.bold
                                  : FontWeight.w500,
                              color: _listingType == 'Pattern'
                                  ? AppColors.primary
                                  : AppColors.textSecondary,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),

              // Photos Section
              Text(
                'Photos',
                style: AppTypography.sans(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: AppColors.textPrimary,
                ),
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  // Add photo button
                  Container(
                    width: 70,
                    height: 70,
                    decoration: BoxDecoration(
                      color: AppColors.surface,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(
                        color: AppColors.border,
                        style: BorderStyle.solid,
                      ),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.add, size: 22, color: AppColors.textSecondary),
                        Text(
                          'Add',
                          style: AppTypography.sans(
                            fontSize: 11,
                            color: AppColors.textSecondary,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 12),
                  // Photo 1
                  const CrochetImage(
                    imagePath: 'assets/images/cardigan.jpg',
                    width: 70,
                    height: 70,
                  ),
                  const SizedBox(width: 12),
                  // Photo 2
                  const CrochetImage(
                    imagePath: 'assets/images/blanket.jpg',
                    width: 70,
                    height: 70,
                  ),
                ],
              ),
              const SizedBox(height: 20),

              // Title Field
              Text(
                'Title',
                style: AppTypography.sans(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: AppColors.textPrimary,
                ),
              ),
              const SizedBox(height: 6),
              TextField(
                controller: _titleController,
                decoration: const InputDecoration(
                  contentPadding: EdgeInsets.symmetric(horizontal: 14, vertical: 12),
                ),
              ),
              const SizedBox(height: 18),

              // Category
              Text(
                'Category',
                style: AppTypography.sans(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: AppColors.textPrimary,
                ),
              ),
              const SizedBox(height: 8),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: _categories.map((cat) {
                    final isSelected = _selectedCategory == cat;
                    return Padding(
                      padding: const EdgeInsets.only(right: 8.0),
                      child: ChoiceChip(
                        label: Text(cat),
                        selected: isSelected,
                        onSelected: (selected) {
                          if (selected) {
                            setState(() {
                              _selectedCategory = cat;
                            });
                          }
                        },
                        labelStyle: AppTypography.sans(
                          fontSize: 12,
                          fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
                          color: isSelected ? Colors.white : AppColors.textPrimary,
                        ),
                        backgroundColor: AppColors.surface,
                        selectedColor: AppColors.primary,
                        showCheckmark: false,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                          side: BorderSide(
                            color: isSelected ? AppColors.primary : AppColors.border,
                          ),
                        ),
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                      ),
                    );
                  }).toList(),
                ),
              ),
              const SizedBox(height: 20),

              // Price & Making Time
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Price',
                          style: AppTypography.sans(
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                            color: AppColors.textPrimary,
                          ),
                        ),
                        const SizedBox(height: 6),
                        TextField(
                          controller: _priceController,
                          decoration: const InputDecoration(
                            contentPadding: EdgeInsets.symmetric(horizontal: 14, vertical: 12),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Making time',
                          style: AppTypography.sans(
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                            color: AppColors.textPrimary,
                          ),
                        ),
                        const SizedBox(height: 6),
                        TextField(
                          controller: _timeController,
                          decoration: const InputDecoration(
                            contentPadding: EdgeInsets.symmetric(horizontal: 14, vertical: 12),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 28),

              // Publish listing Button
              SizedBox(
                width: double.infinity,
                height: 52,
                child: ElevatedButton(
                  onPressed: () {
                    widget.onPublish();
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Listing published successfully!'),
                        backgroundColor: AppColors.primary,
                      ),
                    );
                  },
                  child: const Text('Publish listing'),
                ),
              ),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }
}
