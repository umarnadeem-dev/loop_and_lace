import 'package:flutter/material.dart';

import '../../theme/app_theme.dart';
import '../../data/mock_data.dart';
import '../../models/app_models.dart';

class AdminPanelScreen extends StatefulWidget {
  final VoidCallback onVendorsTap;
  final VoidCallback onNotificationTap;

  const AdminPanelScreen({
    super.key,
    required this.onVendorsTap,
    required this.onNotificationTap,
  });

  @override
  State<AdminPanelScreen> createState() => _AdminPanelScreenState();
}

class _AdminPanelScreenState extends State<AdminPanelScreen> {
  late List<VendorItem> _approvals;

  @override
  void initState() {
    super.initState();
    _approvals = MockData.vendors.where((v) => v.status == 'Pending').toList();
  }

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
                        'Only you • Owner',
                        style: AppTypography.sans(
                          fontSize: 12,
                          color: AppColors.textSecondary,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        'Admin Panel',
                        style: AppTypography.serif(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: AppColors.textPrimary,
                        ),
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
              const SizedBox(height: 18),

              // 4 Summary Metric Cards (2x2 Grid)
              Row(
                children: [
                  _buildMetricCard(
                    value: 'Rs 1.2M',
                    label: 'Total sales',
                    icon: Icons.show_chart,
                    iconColor: AppColors.primary,
                  ),
                  const SizedBox(width: 12),
                  _buildMetricCard(
                    value: '1,284',
                    label: 'Orders',
                    icon: Icons.inventory_2_outlined,
                    iconColor: const Color(0xFFD47A22),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  _buildMetricCard(
                    value: '38',
                    label: 'Active vendors',
                    icon: Icons.storefront_outlined,
                    iconColor: AppColors.sage,
                    onTap: widget.onVendorsTap,
                  ),
                  const SizedBox(width: 12),
                  _buildMetricCard(
                    value: '5.6k',
                    label: 'Customers',
                    icon: Icons.people_outline,
                    iconColor: const Color(0xFF2C6496),
                  ),
                ],
              ),
              const SizedBox(height: 22),

              // Weekly Sales Chart
              Text(
                'Weekly sales',
                style: AppTypography.serif(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textPrimary,
                ),
              ),
              const SizedBox(height: 10),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: AppColors.surface,
                  borderRadius: BorderRadius.circular(18),
                  border: Border.all(color: AppColors.borderLight),
                ),
                child: Column(
                  children: [
                    SizedBox(
                      height: 110,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          _buildBar(height: 45, day: 'M', isPeak: false),
                          _buildBar(height: 65, day: 'T', isPeak: false),
                          _buildBar(height: 55, day: 'W', isPeak: false),
                          _buildBar(height: 95, day: 'T', isPeak: true), // Peak day
                          _buildBar(height: 70, day: 'F', isPeak: false),
                          _buildBar(height: 80, day: 'S', isPeak: false),
                          _buildBar(height: 40, day: 'S', isPeak: false),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 22),

              // Vendor Approvals
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Vendor approvals (${_approvals.length})',
                    style: AppTypography.serif(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  GestureDetector(
                    onTap: widget.onVendorsTap,
                    child: Text(
                      'View all',
                      style: AppTypography.sans(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: AppColors.primary,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),

              ..._approvals.map((v) => _buildApprovalRow(v)),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMetricCard({
    required String value,
    required String label,
    required IconData icon,
    required Color iconColor,
    VoidCallback? onTap,
  }) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: AppColors.surface,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: AppColors.borderLight),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(icon, size: 20, color: iconColor),
              const SizedBox(height: 8),
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

  Widget _buildBar({
    required double height,
    required String day,
    required bool isPeak,
  }) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Container(
          width: 22,
          height: height,
          decoration: BoxDecoration(
            color: isPeak ? AppColors.primary : const Color(0xFFC3D8CE),
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        const SizedBox(height: 6),
        Text(
          day,
          style: AppTypography.sans(
            fontSize: 10,
            fontWeight: isPeak ? FontWeight.bold : FontWeight.w500,
            color: isPeak ? AppColors.primary : AppColors.textMuted,
          ),
        ),
      ],
    );
  }

  Widget _buildApprovalRow(VendorItem vendor) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.borderLight),
      ),
      child: Row(
        children: [
          Container(
            width: 38,
            height: 38,
            decoration: BoxDecoration(
              color: AppColors.blush,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Center(
              child: Text(
                vendor.avatarLetter,
                style: AppTypography.sans(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: AppColors.primary,
                ),
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              vendor.name,
              style: AppTypography.sans(
                fontSize: 13,
                fontWeight: FontWeight.bold,
                color: AppColors.textPrimary,
              ),
            ),
          ),
          // Reject button [✕]
          GestureDetector(
            onTap: () {
              setState(() {
                _approvals.remove(vendor);
              });
            },
            child: Container(
              padding: const EdgeInsets.all(7),
              decoration: BoxDecoration(
                color: AppColors.surfaceWarm,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: AppColors.borderLight),
              ),
              child: const Icon(Icons.close, size: 14, color: AppColors.textSecondary),
            ),
          ),
          const SizedBox(width: 8),
          // Accept button [✓]
          GestureDetector(
            onTap: () {
              setState(() {
                vendor.status = 'Active';
                _approvals.remove(vendor);
              });
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('${vendor.name} approved as vendor!'),
                  backgroundColor: AppColors.sage,
                ),
              );
            },
            child: Container(
              padding: const EdgeInsets.all(7),
              decoration: BoxDecoration(
                color: AppColors.sage,
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Icon(Icons.check, size: 14, color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}
