import 'package:flutter/material.dart';

import '../../theme/app_theme.dart';
import '../../data/mock_data.dart';
import '../../models/app_models.dart';

class VendorManagementScreen extends StatefulWidget {
  final VoidCallback onNotificationTap;

  const VendorManagementScreen({
    super.key,
    required this.onNotificationTap,
  });

  @override
  State<VendorManagementScreen> createState() => _VendorManagementScreenState();
}

class _VendorManagementScreenState extends State<VendorManagementScreen> {
  String _selectedFilter = 'All';
  final List<String> _filters = ['All', 'Active', 'Pending', 'Suspended'];
  late List<VendorItem> _vendors;

  @override
  void initState() {
    super.initState();
    _vendors = List.from(MockData.vendors);
  }

  @override
  Widget build(BuildContext context) {
    final filtered = _selectedFilter == 'All'
        ? _vendors
        : _vendors
            .where((v) => v.status.toLowerCase() == _selectedFilter.toLowerCase())
            .toList();

    final activeCount = _vendors.where((v) => v.status == 'Active').length + 36;
    final pendingCount = _vendors.where((v) => v.status == 'Pending').length;

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
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '$activeCount active • $pendingCount pending',
                        style: AppTypography.sans(
                          fontSize: 12,
                          color: AppColors.textSecondary,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        'Vendors',
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
              const SizedBox(height: 16),

              // Search Bar
              Container(
                decoration: BoxDecoration(
                  color: AppColors.surface,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: AppColors.border),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                child: Row(
                  children: [
                    const Icon(Icons.search, size: 20, color: AppColors.textMuted),
                    const SizedBox(width: 10),
                    Text(
                      'Search vendors...',
                      style: AppTypography.sans(
                        fontSize: 13,
                        color: AppColors.textMuted,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 14),

              // Filter Chips
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: _filters.map((filter) {
                    final isSelected = _selectedFilter == filter;
                    return Padding(
                      padding: const EdgeInsets.only(right: 8.0),
                      child: ChoiceChip(
                        label: Text(filter),
                        selected: isSelected,
                        onSelected: (selected) {
                          if (selected) {
                            setState(() {
                              _selectedFilter = filter;
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
              const SizedBox(height: 16),

              // Vendor Rows
              Expanded(
                child: ListView.separated(
                  itemCount: filtered.length,
                  separatorBuilder: (context, index) => const SizedBox(height: 10),
                  itemBuilder: (context, index) {
                    final vendor = filtered[index];
                    return _buildVendorListItem(vendor);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildVendorListItem(VendorItem vendor) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.borderLight),
      ),
      child: Row(
        children: [
          // Initial Avatar
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: AppColors.blush,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Center(
              child: Text(
                vendor.avatarLetter,
                style: AppTypography.sans(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: AppColors.primary,
                ),
              ),
            ),
          ),
          const SizedBox(width: 12),

          // Info
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  vendor.name,
                  style: AppTypography.sans(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textPrimary,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  vendor.status == 'Pending'
                      ? 'New request'
                      : '${vendor.rating} ★ • ${vendor.totalOrders} orders',
                  style: AppTypography.sans(
                    fontSize: 11,
                    color: AppColors.textMuted,
                  ),
                ),
              ],
            ),
          ),

          // Status or Action Buttons
          if (vendor.status == 'Active')
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              decoration: BoxDecoration(
                color: AppColors.statusActive,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Text(
                'Active',
                style: AppTypography.sans(
                  fontSize: 11,
                  fontWeight: FontWeight.bold,
                  color: AppColors.statusActiveText,
                ),
              ),
            )
          else if (vendor.status == 'Pending')
            Row(
              children: [
                // Reject
                GestureDetector(
                  onTap: () {
                    setState(() {
                      vendor.status = 'Suspended';
                    });
                  },
                  child: Container(
                    padding: const EdgeInsets.all(6),
                    decoration: BoxDecoration(
                      color: AppColors.surfaceWarm,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: AppColors.borderLight),
                    ),
                    child: const Icon(Icons.close, size: 14, color: AppColors.textSecondary),
                  ),
                ),
                const SizedBox(width: 8),
                // Accept
                GestureDetector(
                  onTap: () {
                    setState(() {
                      vendor.status = 'Active';
                    });
                  },
                  child: Container(
                    padding: const EdgeInsets.all(6),
                    decoration: BoxDecoration(
                      color: AppColors.sage,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Icon(Icons.check, size: 14, color: Colors.white),
                  ),
                ),
              ],
            )
          else
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              decoration: BoxDecoration(
                color: Colors.grey.shade200,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Text(
                'Suspended',
                style: AppTypography.sans(
                  fontSize: 11,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey.shade700,
                ),
              ),
            ),
        ],
      ),
    );
  }
}
