import 'package:flutter/material.dart';

import '../../theme/app_theme.dart';

class CustomerProfileScreen extends StatelessWidget {
  final String userName;
  final String userBio;
  final VoidCallback onMyOrdersTap;
  final VoidCallback onSavedPatternsTap;
  final VoidCallback onWishlistTap;
  final VoidCallback onBecomeVendorTap;
  final VoidCallback? onAddressesTap;
  final VoidCallback? onHelpSupportTap;
  final VoidCallback? onEditProfileTap;
  final VoidCallback? onCustomOrdersTap;
  final VoidCallback? onAdminTap;
  final VoidCallback onLogoutTap;

  const CustomerProfileScreen({
    super.key,
    this.userName = 'Arbab Jabeen',
    this.userBio = 'Crochet lover • Lahore',
    required this.onMyOrdersTap,
    required this.onSavedPatternsTap,
    required this.onWishlistTap,
    required this.onBecomeVendorTap,
    this.onAddressesTap,
    this.onHelpSupportTap,
    this.onEditProfileTap,
    this.onCustomOrdersTap,
    this.onAdminTap,
    required this.onLogoutTap,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 16.0),
          child: Column(
            children: [
              const SizedBox(height: 10),
              // Avatar with Edit Button
              GestureDetector(
                onTap: onEditProfileTap,
                child: Stack(
                  children: [
                    Container(
                      width: 82,
                      height: 82,
                      decoration: const BoxDecoration(
                        color: AppColors.blush,
                        shape: BoxShape.circle,
                      ),
                      child: Center(
                        child: Text(
                          userName.isNotEmpty ? userName[0].toUpperCase() : 'A',
                          style: AppTypography.serif(
                            fontSize: 34,
                            fontWeight: FontWeight.bold,
                            color: AppColors.primary,
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: Container(
                        padding: const EdgeInsets.all(5),
                        decoration: const BoxDecoration(
                          color: AppColors.primary,
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(Icons.edit, size: 12, color: Colors.white),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 12),

              // Name and location
              GestureDetector(
                onTap: onEditProfileTap,
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          userName,
                          style: AppTypography.serif(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: AppColors.textPrimary,
                          ),
                        ),
                        const SizedBox(width: 4),
                        const Icon(Icons.edit_outlined, size: 14, color: AppColors.textMuted),
                      ],
                    ),
                    const SizedBox(height: 2),
                    Text(
                      userBio,
                      style: AppTypography.sans(
                        fontSize: 12,
                        color: AppColors.textSecondary,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),

              // Menu Card
              Container(
                decoration: BoxDecoration(
                  color: AppColors.surface,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: AppColors.borderLight),
                ),
                child: Column(
                  children: [
                    _buildMenuItem(
                      title: 'My orders',
                      onTap: onMyOrdersTap,
                    ),
                    if (onCustomOrdersTap != null) ...[
                      _buildDivider(),
                      _buildMenuItem(
                        title: 'Custom Orders & Quotes',
                        onTap: onCustomOrdersTap!,
                      ),
                    ],
                    _buildDivider(),
                    _buildMenuItem(
                      title: 'Saved patterns',
                      onTap: onSavedPatternsTap,
                    ),
                    _buildDivider(),
                    _buildMenuItem(
                      title: 'Wishlist',
                      onTap: onWishlistTap,
                    ),
                    _buildDivider(),
                    _buildMenuItem(
                      title: 'Delivery Addresses',
                      onTap: onAddressesTap ?? () {},
                    ),
                    _buildDivider(),
                    _buildMenuItem(
                      title: 'Become a vendor',
                      isHighlight: true,
                      onTap: onBecomeVendorTap,
                    ),
                    if (onAdminTap != null) ...[
                      _buildDivider(),
                      _buildMenuItem(
                        title: 'Admin Control Panel',
                        onTap: onAdminTap!,
                      ),
                    ],
                    _buildDivider(),
                    _buildMenuItem(
                      title: 'Help & support',
                      onTap: onHelpSupportTap ?? () {},
                    ),
                    _buildDivider(),
                    _buildMenuItem(
                      title: 'Logout',
                      isDestructive: true,
                      onTap: onLogoutTap,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMenuItem({
    required String title,
    required VoidCallback onTap,
    bool isHighlight = false,
    bool isDestructive = false,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: AppTypography.sans(
                fontSize: 14,
                fontWeight: isHighlight ? FontWeight.bold : FontWeight.w500,
                color: isDestructive
                    ? const Color(0xFFD32F2F)
                    : isHighlight
                        ? AppColors.primary
                        : AppColors.textPrimary,
              ),
            ),
            Icon(
              Icons.chevron_right,
              size: 18,
              color: isHighlight ? AppColors.primary : AppColors.textMuted,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDivider() {
    return const Divider(
      height: 1,
      thickness: 1,
      indent: 16,
      endIndent: 16,
      color: AppColors.borderLight,
    );
  }
}
