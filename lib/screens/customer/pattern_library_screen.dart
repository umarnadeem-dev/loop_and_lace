import 'package:flutter/material.dart';

import '../../theme/app_theme.dart';
import '../../data/mock_data.dart';
import '../../models/app_models.dart';
import '../../widgets/crochet_image.dart';

class PatternLibraryScreen extends StatefulWidget {
  final Function(ProductItem) onPatternSelect;
  final VoidCallback onNotificationTap;

  const PatternLibraryScreen({
    super.key,
    required this.onPatternSelect,
    required this.onNotificationTap,
  });

  @override
  State<PatternLibraryScreen> createState() => _PatternLibraryScreenState();
}

class _PatternLibraryScreenState extends State<PatternLibraryScreen> {
  String _selectedDifficulty = 'All';
  final List<String> _difficulties = ['All', 'Beginner', 'Intermediate', 'Advanced'];

  @override
  Widget build(BuildContext context) {
    final list = _selectedDifficulty == 'All'
        ? MockData.patterns
        : MockData.patterns
            .where((p) => p.difficulty.toLowerCase() == _selectedDifficulty.toLowerCase())
            .toList();

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      if (Navigator.canPop(context)) ...[
                        IconButton(
                          padding: EdgeInsets.zero,
                          constraints: const BoxConstraints(),
                          icon: const Icon(Icons.arrow_back_ios_new, size: 18),
                          onPressed: () => Navigator.pop(context),
                        ),
                        const SizedBox(width: 12),
                      ],
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '120+ step-by-step guides',
                            style: AppTypography.sans(
                              fontSize: 12,
                              color: AppColors.textSecondary,
                            ),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            'Pattern Library',
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
                  InkWell(
                    onTap: widget.onNotificationTap,
                    borderRadius: BorderRadius.circular(20),
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: AppColors.surface,
                        shape: BoxShape.circle,
                        border: Border.all(color: AppColors.borderLight),
                      ),
                      child: const Icon(
                        Icons.notifications_none_outlined,
                        size: 22,
                        color: AppColors.textPrimary,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),

              // Filter Chips
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: _difficulties.map((diff) {
                    final isSelected = _selectedDifficulty == diff;
                    return Padding(
                      padding: const EdgeInsets.only(right: 8.0),
                      child: FilterChip(
                        label: Text(diff),
                        selected: isSelected,
                        onSelected: (selected) {
                          setState(() {
                            _selectedDifficulty = diff;
                          });
                        },
                        labelStyle: AppTypography.sans(
                          fontSize: 12,
                          fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
                          color: isSelected ? AppColors.primary : AppColors.textSecondary,
                        ),
                        backgroundColor: AppColors.surface,
                        selectedColor: AppColors.blush.withValues(alpha: 0.6),
                        checkmarkColor: AppColors.primary,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
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
              const SizedBox(height: 18),

              // Patterns List
              Expanded(
                child: ListView.separated(
                  itemCount: list.length,
                  separatorBuilder: (context, index) => const SizedBox(height: 14),
                  itemBuilder: (context, index) {
                    final item = list[index];
                    return _buildPatternCard(item);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPatternCard(ProductItem item) {
    String hoursText = '4 hrs';
    if (item.difficulty == 'Intermediate') hoursText = '12 hrs';
    if (item.difficulty == 'Advanced') hoursText = '20 hrs';

    Color tagBg = AppColors.blush;
    Color tagText = AppColors.primary;
    if (item.difficulty == 'Intermediate') {
      tagBg = const Color(0xFFFFF0E0);
      tagText = const Color(0xFFD47A22);
    } else if (item.difficulty == 'Advanced') {
      tagBg = const Color(0xFFE5EFF9);
      tagText = const Color(0xFF2C6496);
    }

    return GestureDetector(
      onTap: () => widget.onPatternSelect(item),
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
        padding: const EdgeInsets.all(12),
        child: Row(
          children: [
            // Thumbnail
            CrochetImage(
              imagePath: item.imagePath,
              width: 75,
              height: 75,
              borderRadius: BorderRadius.circular(14),
            ),
            const SizedBox(width: 14),

            // Info
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                    decoration: BoxDecoration(
                      color: tagBg,
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Text(
                      item.difficulty.toUpperCase(),
                      style: AppTypography.sans(
                        fontSize: 9,
                        fontWeight: FontWeight.w700,
                        color: tagText,
                        letterSpacing: 0.5,
                      ),
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    item.title,
                    style: AppTypography.serif(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          const Icon(Icons.access_time, size: 13, color: AppColors.textMuted),
                          const SizedBox(width: 4),
                          Text(
                            hoursText,
                            style: AppTypography.sans(
                              fontSize: 12,
                              color: AppColors.textMuted,
                            ),
                          ),
                        ],
                      ),
                      Text(
                        item.price == 0 ? 'Free' : 'Rs ${item.price.toString().replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},')}',
                        style: AppTypography.sans(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: AppColors.primary,
                        ),
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
