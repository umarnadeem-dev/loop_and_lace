import 'package:flutter/material.dart';

import '../../theme/app_theme.dart';
import '../../data/mock_data.dart';
import '../../models/app_models.dart';
import '../../widgets/crochet_image.dart';

class OrdersTrackingScreen extends StatefulWidget {
  final VoidCallback onBack;
  final Function(OrderItem)? onOrderTap;
  final Function(OrderItem)? onRateOrder;
  final VoidCallback? onCustomRequestsTap;

  const OrdersTrackingScreen({
    super.key,
    required this.onBack,
    this.onOrderTap,
    this.onRateOrder,
    this.onCustomRequestsTap,
  });

  @override
  State<OrdersTrackingScreen> createState() => _OrdersTrackingScreenState();
}

class _OrdersTrackingScreenState extends State<OrdersTrackingScreen> {
  String _selectedTab = 'Active';
  final List<String> _tabs = ['Active', 'Delivered', 'Cancelled'];

  @override
  Widget build(BuildContext context) {
    // Filter orders based on tab
    final activeOrders = MockData.orders.where((o) => o.status == OrderStatus.making || o.status == OrderStatus.pending || o.status == OrderStatus.shipped).toList();
    final deliveredOrders = MockData.orders.where((o) => o.status == OrderStatus.delivered).toList();
    final cancelledOrders = MockData.orders.where((o) => o.status == OrderStatus.cancelled).toList();

    List<OrderItem> currentList = activeOrders;
    if (_selectedTab == 'Delivered') currentList = deliveredOrders;
    if (_selectedTab == 'Cancelled') currentList = cancelledOrders;

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
                            'My orders',
                            style: AppTypography.serif(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                              color: AppColors.textPrimary,
                            ),
                          ),
                          Text(
                            'Track your handmade goods',
                            style: AppTypography.sans(
                              fontSize: 12,
                              color: AppColors.textSecondary,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  if (widget.onCustomRequestsTap != null)
                    InkWell(
                      onTap: widget.onCustomRequestsTap,
                      borderRadius: BorderRadius.circular(16),
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                        decoration: BoxDecoration(
                          color: AppColors.blush,
                          borderRadius: BorderRadius.circular(14),
                          border: Border.all(color: AppColors.primaryLight.withValues(alpha: 0.3)),
                        ),
                        child: Row(
                          children: [
                            const Icon(Icons.auto_awesome, size: 14, color: AppColors.primary),
                            const SizedBox(width: 4),
                            Text(
                              'Custom Quotes',
                              style: AppTypography.sans(
                                fontSize: 11,
                                fontWeight: FontWeight.bold,
                                color: AppColors.primary,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                ],
              ),
              const SizedBox(height: 18),

              // Filter Tabs
              Row(
                children: _tabs.map((tab) {
                  final isSelected = _selectedTab == tab;
                  return Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: ChoiceChip(
                      label: Text(tab),
                      selected: isSelected,
                      onSelected: (selected) {
                        if (selected) {
                          setState(() {
                            _selectedTab = tab;
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
              const SizedBox(height: 20),

              // If Active Tab: Show primary active order card
              if (_selectedTab == 'Active') ...[
                GestureDetector(
                  onTap: () {
                    if (widget.onOrderTap != null) {
                      widget.onOrderTap!(MockData.orders.first);
                    }
                  },
                  child: Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: AppColors.surface,
                      borderRadius: BorderRadius.circular(20),
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
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Order #1043',
                                  style: AppTypography.sans(
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                    color: AppColors.textPrimary,
                                  ),
                                ),
                                Text(
                                  'Placed 8 Oct • 2 items',
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
                                color: AppColors.statusPending,
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Text(
                                'Making',
                                style: AppTypography.sans(
                                  fontSize: 11,
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.statusPendingText,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),

                        // Progress Stepper Line
                        _buildStepperTracker(),
                        const SizedBox(height: 20),

                        // Thumbnails & Total
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(8),
                                  child: const CrochetImage(
                                    imagePath: 'assets/images/bunny.jpg',
                                    width: 36,
                                    height: 36,
                                  ),
                                ),
                                const SizedBox(width: 8),
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(8),
                                  child: const CrochetImage(
                                    imagePath: 'assets/images/blanket.jpg',
                                    width: 36,
                                    height: 36,
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Text(
                                  'Rs 9,150',
                                  style: AppTypography.sans(
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                    color: AppColors.primary,
                                  ),
                                ),
                                const SizedBox(width: 6),
                                const Icon(Icons.chevron_right, size: 18, color: AppColors.textMuted),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 16),
              ],

              // Orders List for current tab
              if (currentList.isEmpty)
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 40),
                  child: Center(
                    child: Column(
                      children: [
                        const Icon(Icons.inbox_outlined, size: 40, color: AppColors.textMuted),
                        const SizedBox(height: 8),
                        Text(
                          'No ${_selectedTab.toLowerCase()} orders',
                          style: AppTypography.sans(fontSize: 13, color: AppColors.textSecondary),
                        ),
                      ],
                    ),
                  ),
                )
              else
                ...currentList.map((order) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 12.0),
                    child: GestureDetector(
                      onTap: () {
                        if (widget.onOrderTap != null) {
                          widget.onOrderTap!(order);
                        }
                      },
                      child: _buildPastOrderCard(
                        imagePath: order.primaryImage,
                        title: order.itemNames.first,
                        subtitle: '${order.orderId} • ${order.buyerName}',
                        statusText: order.statusLabel,
                        statusBg: order.status == OrderStatus.delivered
                            ? AppColors.statusShipped
                            : (order.status == OrderStatus.shipped ? const Color(0xFF2D2327) : AppColors.statusPending),
                        statusTextColor: order.status == OrderStatus.delivered
                            ? AppColors.statusShippedText
                            : (order.status == OrderStatus.shipped ? Colors.white : AppColors.statusPendingText),
                        actionWidget: order.status == OrderStatus.delivered
                            ? OutlinedButton(
                                onPressed: () {
                                  if (widget.onRateOrder != null) {
                                    widget.onRateOrder!(order);
                                  }
                                },
                                style: OutlinedButton.styleFrom(
                                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                                  minimumSize: Size.zero,
                                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                  side: const BorderSide(color: AppColors.border),
                                ),
                                child: Text(
                                  'Rate order',
                                  style: AppTypography.sans(
                                    fontSize: 11,
                                    fontWeight: FontWeight.w600,
                                    color: AppColors.textPrimary,
                                  ),
                                ),
                              )
                            : null,
                      ),
                    ),
                  );
                }),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStepperTracker() {
    final steps = ['Confirmed', 'Making', 'Shipped', 'Delivered'];
    const activeIndex = 1; // Making is current

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: List.generate(steps.length, (index) {
        final isCompleted = index < activeIndex;
        final isCurrent = index == activeIndex;

        return Column(
          children: [
            Container(
              width: 22,
              height: 22,
              decoration: BoxDecoration(
                color: isCompleted
                    ? AppColors.sage
                    : isCurrent
                        ? AppColors.primary
                        : AppColors.border,
                shape: BoxShape.circle,
              ),
              child: Center(
                child: isCompleted
                    ? const Icon(Icons.check, size: 12, color: Colors.white)
                    : isCurrent
                        ? Container(
                            width: 6,
                            height: 6,
                            decoration: const BoxDecoration(
                              color: Colors.white,
                              shape: BoxShape.circle,
                            ),
                          )
                        : null,
              ),
            ),
            const SizedBox(height: 6),
            Text(
              steps[index],
              style: AppTypography.sans(
                fontSize: 10,
                fontWeight: isCurrent ? FontWeight.bold : FontWeight.w500,
                color: isCurrent
                    ? AppColors.textPrimary
                    : isCompleted
                        ? AppColors.sage
                        : AppColors.textMuted,
              ),
            ),
          ],
        );
      }),
    );
  }

  Widget _buildPastOrderCard({
    required String imagePath,
    required String title,
    required String subtitle,
    required String statusText,
    required Color statusBg,
    required Color statusTextColor,
    Widget? actionWidget,
  }) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: AppColors.borderLight),
      ),
      child: Row(
        children: [
          CrochetImage(
            imagePath: imagePath,
            width: 48,
            height: 48,
            borderRadius: BorderRadius.circular(10),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: AppTypography.sans(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textPrimary,
                  ),
                ),
                Text(
                  subtitle,
                  style: AppTypography.sans(
                    fontSize: 11,
                    color: AppColors.textMuted,
                  ),
                ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                decoration: BoxDecoration(
                  color: statusBg,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(
                  statusText,
                  style: AppTypography.sans(
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                    color: statusTextColor,
                  ),
                ),
              ),
              if (actionWidget != null) ...[
                const SizedBox(height: 6),
                actionWidget,
              ],
            ],
          ),
        ],
      ),
    );
  }
}
