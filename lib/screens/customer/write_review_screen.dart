import 'package:flutter/material.dart';

import '../../theme/app_theme.dart';
import '../../models/app_models.dart';
import '../../widgets/crochet_image.dart';

class WriteReviewScreen extends StatefulWidget {
  final String productTitle;
  final String makerName;
  final String imagePath;
  final VoidCallback onBack;
  final Function(ReviewItem) onReviewSubmitted;

  const WriteReviewScreen({
    super.key,
    required this.productTitle,
    required this.makerName,
    required this.imagePath,
    required this.onBack,
    required this.onReviewSubmitted,
  });

  @override
  State<WriteReviewScreen> createState() => _WriteReviewScreenState();
}

class _WriteReviewScreenState extends State<WriteReviewScreen> {
  int _rating = 5;
  final TextEditingController _commentController = TextEditingController();
  final Set<String> _selectedTags = {'Neat Stitches', 'Soft & Combed Yarn'};
  bool _isPublic = true;
  bool _hasPhotoAttached = false;

  final List<String> _ratingLabels = [
    'Poor quality',
    'Fair, needs improvement',
    'Good crochet piece',
    'Wonderful craftsmanship!',
    'Exquisite handmade masterpiece! ✿',
  ];

  final List<String> _availableTags = [
    'Neat Stitches',
    'Soft & Combed Yarn',
    'Perfect Fit',
    'Responsive Maker',
    'Eco Packaging',
    'Accurate Colors',
    'Heirloom Quality',
  ];

  @override
  void dispose() {
    _commentController.dispose();
    super.dispose();
  }

  void _submitReview() {
    final comment = _commentController.text.trim();
    if (comment.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please write a short comment about your piece.'),
          backgroundColor: AppColors.primary,
        ),
      );
      return;
    }

    final newReview = ReviewItem(
      id: 'rev_${DateTime.now().millisecondsSinceEpoch}',
      userName: _isPublic ? 'Arbab Jabeen' : 'Anonymous Buyer',
      rating: _rating.toDouble(),
      dateText: 'Just now',
      comment: comment,
      tags: _selectedTags.toList(),
      productTitle: widget.productTitle,
    );

    widget.onReviewSubmitted(newReview);
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Thank you! Your handmade review has been published. ✿'),
        backgroundColor: AppColors.sage,
      ),
    );
    widget.onBack();
  }

  @override
  Widget build(BuildContext context) {
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
          'Rate & Review',
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
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Product Preview Banner
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: AppColors.surface,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: AppColors.borderLight),
                ),
                child: Row(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: CrochetImage(
                        imagePath: widget.imagePath,
                        width: 54,
                        height: 54,
                      ),
                    ),
                    const SizedBox(width: 14),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.productTitle,
                            style: AppTypography.serif(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: AppColors.textPrimary,
                            ),
                          ),
                          Text(
                            'Crafted by ${widget.makerName}',
                            style: AppTypography.sans(
                              fontSize: 12,
                              color: AppColors.textMuted,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),

              // Star Rating
              Text(
                'How was your piece?',
                style: AppTypography.serif(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textPrimary,
                ),
              ),
              const SizedBox(height: 12),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(5, (index) {
                  final starIndex = index + 1;
                  final isFilled = starIndex <= _rating;
                  return IconButton(
                    iconSize: 36,
                    padding: const EdgeInsets.symmetric(horizontal: 4),
                    icon: Icon(
                      isFilled ? Icons.star_rounded : Icons.star_outline_rounded,
                      color: isFilled ? const Color(0xFFE6A122) : AppColors.border,
                    ),
                    onPressed: () {
                      setState(() {
                        _rating = starIndex;
                      });
                    },
                  );
                }),
              ),
              const SizedBox(height: 6),
              Text(
                _ratingLabels[_rating - 1],
                style: AppTypography.sans(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: AppColors.primary,
                ),
              ),
              const SizedBox(height: 24),

              // Highlight Tags
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'What did you like most?',
                  style: AppTypography.sans(
                    fontSize: 13,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textPrimary,
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: _availableTags.map((tag) {
                  final isSelected = _selectedTags.contains(tag);
                  return FilterChip(
                    label: Text(tag),
                    selected: isSelected,
                    onSelected: (selected) {
                      setState(() {
                        if (selected) {
                          _selectedTags.add(tag);
                        } else {
                          _selectedTags.remove(tag);
                        }
                      });
                    },
                    labelStyle: AppTypography.sans(
                      fontSize: 12,
                      fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                      color: isSelected ? AppColors.primaryDark : AppColors.textSecondary,
                    ),
                    backgroundColor: AppColors.surface,
                    selectedColor: AppColors.blush,
                    checkmarkColor: AppColors.primary,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                      side: BorderSide(
                        color: isSelected ? AppColors.primary : AppColors.borderLight,
                      ),
                    ),
                  );
                }).toList(),
              ),
              const SizedBox(height: 24),

              // Comment Input
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Your detailed review',
                  style: AppTypography.sans(
                    fontSize: 13,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textPrimary,
                  ),
                ),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: _commentController,
                maxLines: 4,
                decoration: InputDecoration(
                  hintText: 'Share your thoughts on the softness, stitches, colors, or message to the artisan...',
                  hintStyle: AppTypography.sans(fontSize: 12, color: AppColors.textMuted),
                  filled: true,
                  fillColor: AppColors.surface,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: const BorderSide(color: AppColors.borderLight),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: const BorderSide(color: AppColors.borderLight),
                  ),
                ),
              ),
              const SizedBox(height: 18),

              // Upload photo tile
              GestureDetector(
                onTap: () {
                  setState(() {
                    _hasPhotoAttached = !_hasPhotoAttached;
                  });
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(_hasPhotoAttached ? 'Photo attached!' : 'Photo removed'),
                      duration: const Duration(seconds: 1),
                    ),
                  );
                },
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
                  decoration: BoxDecoration(
                    color: _hasPhotoAttached ? AppColors.sageLight : AppColors.surface,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(
                      color: _hasPhotoAttached ? AppColors.sage : AppColors.border,
                      style: BorderStyle.solid,
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        _hasPhotoAttached ? Icons.check_circle_outline : Icons.camera_alt_outlined,
                        size: 20,
                        color: _hasPhotoAttached ? AppColors.sageDark : AppColors.textSecondary,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        _hasPhotoAttached ? 'Customer photo attached (1 photo)' : 'Add photo of your finished item',
                        style: AppTypography.sans(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: _hasPhotoAttached ? AppColors.sageDark : AppColors.textSecondary,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),

              // Public / Anonymous Switch
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Post publicly',
                        style: AppTypography.sans(
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                          color: AppColors.textPrimary,
                        ),
                      ),
                      Text(
                        'Display name as "Arbab Jabeen"',
                        style: AppTypography.sans(
                          fontSize: 11,
                          color: AppColors.textMuted,
                        ),
                      ),
                    ],
                  ),
                  Switch(
                    value: _isPublic,
                    activeThumbColor: AppColors.primary,
                    onChanged: (val) {
                      setState(() {
                        _isPublic = val;
                      });
                    },
                  ),
                ],
              ),
              const SizedBox(height: 24),

              // Submit Button
              SizedBox(
                width: double.infinity,
                height: 52,
                child: ElevatedButton(
                  onPressed: _submitReview,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  child: Text(
                    'Submit Review',
                    style: AppTypography.sans(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
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
}

