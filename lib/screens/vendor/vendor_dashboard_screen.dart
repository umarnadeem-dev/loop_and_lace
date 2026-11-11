import 'package:flutter/material.dart';

import '../../theme/app_theme.dart';

class VendorDashboardScreen extends StatelessWidget {
  final VoidCallback onNewListingTap;
  final VoidCallback onOrdersTap;
  final VoidCallback? onListingsTap;
  final VoidCallback onNotificationTap;

  const VendorDashboardScreen({
    super.key,
    required this.onNewListingTap,
    required this.onOrdersTap,
    this.onListingsTap,
    required this.onNotificationTap,
  });

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
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
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
                      const SizedBox(height: 2),
                      Text(
                        'Vendor Studio',
                        style: AppTypography.serif(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: AppColors.textPrimary,
                        ),
                      ),
                    ],
                  ),
                  InkWell(
                    onTap: onNotificationTap,
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
              const SizedBox(height: 18),

              // Hero Earnings Card
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [
                      Color(0xFF8B254D),
                      Color(0xFFA1355E),
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(22),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.primary.withValues(alpha: 0.25),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'This month earnings',
                      style: AppTypography.sans(
                        fontSize: 12,
                        color: Colors.white.withValues(alpha: 0.85),
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      'Rs 84,500',
                      style: AppTypography.serif(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Row(
                      children: [
                        const Icon(Icons.arrow_upward, size: 13, color: Colors.white),
                        const SizedBox(width: 4),
                        Text(
                          '+18% vs last month',
                          style: AppTypography.sans(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),

              // 3 Quick Stat Badges
              Row(
                children: [
                  _buildStatTile(
                    value: '42',
                    label: 'Orders',
                    icon: Icons.shopping_bag_outlined,
                    onTap: onOrdersTap,
                  ),
                  const SizedBox(width: 10),
                  _buildStatTile(
                    value: '12',
                    label: 'Catalog',
                    icon: Icons.menu_book_outlined,
                    onTap: onListingsTap,
                  ),
                  const SizedBox(width: 10),
                  _buildStatTile(
                    value: '4.8',
                    label: 'Rating',
                    icon: Icons.star_outline,
                  ),
                ],
              ),
              const SizedBox(height: 16),

              // "+ New product / pattern" button
              GestureDetector(
                onTap: onNewListingTap,
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  decoration: BoxDecoration(
                    color: AppColors.blush.withValues(alpha: 0.4),
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(
                      color: AppColors.primaryLight.withValues(alpha: 0.6),
                      style: BorderStyle.solid,
                    ),
                  ),
                  child: Center(
                    child: Text(
                      '+ New product / pattern',
                      style: AppTypography.sans(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: AppColors.primary,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 24),

              // Section: Recent orders
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Recent orders',
                    style: AppTypography.serif(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  GestureDetector(
                    onTap: onOrdersTap,
                    child: Text(
                      'See all',
                      style: AppTypography.sans(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: AppColors.primary,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),

              // Recent order cards
              _buildRecentOrderRow(
                title: 'Berry Bunny • Pink',
                orderId: '#1042',
                status: 'Pending',
                statusBg: AppColors.statusPending,
                statusColor: AppColors.statusPendingText,
              ),
              const SizedBox(height: 10),
              _buildRecentOrderRow(
                title: 'Cozy Throw',
                orderId: '#1041',
                status: 'Shipped',
                statusBg: AppColors.statusShipped,
                statusColor: AppColors.statusShippedText,
              ),
              const SizedBox(height: 10),
              _buildRecentOrderRow(
                title: 'Custom Bag',
                orderId: '#1040',
                status: 'Making',
                statusBg: AppColors.statusMaking,
                statusColor: AppColors.statusMakingText,
              ),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStatTile({
    required String value,
    required String label,
    required IconData icon,
    VoidCallback? onTap,
  }) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 14),
          decoration: BoxDecoration(
            color: AppColors.surface,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: AppColors.borderLight),
          ),
          child: Column(
            children: [
              Icon(icon, size: 20, color: AppColors.textMuted),
              const SizedBox(height: 6),
              Text(
                value,
                style: AppTypography.sans(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textPrimary,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                label,
                style: AppTypography.sans(
                  fontSize: 11,
                  color: AppColors.textSecondary,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildRecentOrderRow({
    required String title,
    required String orderId,
    required String status,
    required Color statusBg,
    required Color statusColor,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: AppColors.borderLight),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: AppTypography.sans(
                  fontSize: 13,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textPrimary,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                orderId,
                style: AppTypography.sans(
                  fontSize: 11,
                  color: AppColors.textMuted,
                ),
              ),
            ],
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            decoration: BoxDecoration(
              color: statusBg,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Text(
              status,
              style: AppTypography.sans(
                fontSize: 11,
                fontWeight: FontWeight.bold,
                color: statusColor,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
