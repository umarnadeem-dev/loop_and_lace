import 'package:flutter/material.dart';

import '../../theme/app_theme.dart';
import '../../data/mock_data.dart';
import '../../models/app_models.dart';

class VendorOrdersScreen extends StatefulWidget {
  final VoidCallback onNotificationTap;
  final Function(OrderItem)? onOrderTap;

  const VendorOrdersScreen({
    super.key,
    required this.onNotificationTap,
    this.onOrderTap,
  });

  @override
  State<VendorOrdersScreen> createState() => _VendorOrdersScreenState();
}

class _VendorOrdersScreenState extends State<VendorOrdersScreen> {
  late List<OrderItem> _orders;

  @override
  void initState() {
    super.initState();
    _orders = List.from(MockData.vendorOrders);
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
                        'Sage Studio',
                        style: AppTypography.sans(
                          fontSize: 12,
                          color: AppColors.textSecondary,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        'Orders',
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

              // Summary Tiles: 5 Pending, 8 Making, 29 Shipped
              Row(
                children: [
                  _buildSummaryTile('5', 'Pending', AppColors.statusPending, AppColors.statusPendingText),
                  const SizedBox(width: 10),
                  _buildSummaryTile('8', 'Making', AppColors.statusMaking, AppColors.statusMakingText),
                  const SizedBox(width: 10),
                  _buildSummaryTile('29', 'Shipped', AppColors.statusShipped, AppColors.statusShippedText),
                ],
              ),
              const SizedBox(height: 20),

              // Orders List
              ..._orders.map((order) {
                Color statusBg = AppColors.statusPending;
                Color statusColor = AppColors.statusPendingText;
                if (order.status == OrderStatus.shipped) {
                  statusBg = AppColors.statusShipped;
                  statusColor = AppColors.statusShippedText;
                } else if (order.status == OrderStatus.making) {
                  statusBg = AppColors.statusMaking;
                  statusColor = AppColors.statusMakingText;
                }

                List<Widget> actions = [];
                if (order.status == OrderStatus.pending) {
                  actions = [
                    OutlinedButton(
                      onPressed: () {
                        setState(() {
                          _orders.remove(order);
                        });
                      },
                      style: OutlinedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                        minimumSize: Size.zero,
                        side: const BorderSide(color: AppColors.border),
                      ),
                      child: Text('Decline', style: AppTypography.sans(fontSize: 12)),
                    ),
                    const SizedBox(width: 8),
                    ElevatedButton(
                      onPressed: () {
                        setState(() {
                          order.status = OrderStatus.making;
                        });
                      },
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                        minimumSize: Size.zero,
                      ),
                      child: Text('Accept', style: AppTypography.sans(fontSize: 12, fontWeight: FontWeight.bold)),
                    ),
                  ];
                } else if (order.status == OrderStatus.shipped) {
                  actions = [
                    OutlinedButton(
                      onPressed: () {
                        if (widget.onOrderTap != null) {
                          widget.onOrderTap!(order);
                        }
                      },
                      style: OutlinedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 8),
                        minimumSize: Size.zero,
                        side: const BorderSide(color: AppColors.border),
                      ),
                      child: Text('View', style: AppTypography.sans(fontSize: 12)),
                    ),
                  ];
                } else {
                  actions = [
                    ElevatedButton(
                      onPressed: () {
                        setState(() {
                          order.status = OrderStatus.shipped;
                        });
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.sage,
                        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                        minimumSize: Size.zero,
                      ),
                      child: Text('Mark as shipped', style: AppTypography.sans(fontSize: 12, fontWeight: FontWeight.bold)),
                    ),
                  ];
                }

                return Padding(
                  padding: const EdgeInsets.only(bottom: 12.0),
                  child: _buildOrderCard(
                    itemTitle: order.itemNames.first,
                    details: '${order.orderId} • ${order.buyerName}, ${order.city}',
                    price: order.totalAmount,
                    status: order.statusLabel,
                    statusBg: statusBg,
                    statusColor: statusColor,
                    actions: actions,
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

  Widget _buildSummaryTile(String count, String label, Color bg, Color textColor) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 14),
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: AppColors.borderLight),
        ),
        child: Column(
          children: [
            Text(
              count,
              style: AppTypography.sans(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: AppColors.textPrimary,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              label,
              style: AppTypography.sans(
                fontSize: 11,
                fontWeight: FontWeight.w500,
                color: AppColors.textSecondary,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildOrderCard({
    required String itemTitle,
    required String details,
    required int price,
    required String status,
    required Color statusBg,
    required Color statusColor,
    required List<Widget> actions,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: AppColors.borderLight),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                itemTitle,
                style: AppTypography.sans(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textPrimary,
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                decoration: BoxDecoration(
                  color: statusBg,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(
                  status,
                  style: AppTypography.sans(
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                    color: statusColor,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 2),
          Text(
            details,
            style: AppTypography.sans(
              fontSize: 11,
              color: AppColors.textMuted,
            ),
          ),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Rs ${price.toString().replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},')}',
                style: AppTypography.sans(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: AppColors.primary,
                ),
              ),
              Row(children: actions),
            ],
          ),
        ],
      ),
    );
  }
}
