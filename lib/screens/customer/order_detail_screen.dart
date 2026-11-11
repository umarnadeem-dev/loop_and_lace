import 'package:flutter/material.dart';

import '../../theme/app_theme.dart';
import '../../models/app_models.dart';
import '../../widgets/crochet_image.dart';

class OrderDetailScreen extends StatelessWidget {
  final OrderItem order;
  final VoidCallback onBack;
  final VoidCallback? onRateOrder;
  final VoidCallback? onChatWithMaker;

  const OrderDetailScreen({
    super.key,
    required this.order,
    required this.onBack,
    this.onRateOrder,
    this.onChatWithMaker,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, size: 18, color: AppColors.textPrimary),
          onPressed: onBack,
        ),
        title: Text(
          'Order Details',
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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Top Status Hero Card
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(18),
                decoration: BoxDecoration(
                  color: AppColors.surface,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: AppColors.borderLight),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.03),
                      blurRadius: 8,
                      offset: const Offset(0, 3),
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
                              order.orderId,
                              style: AppTypography.sans(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: AppColors.textPrimary,
                              ),
                            ),
                            const SizedBox(height: 2),
                            Text(
                              order.dateText,
                              style: AppTypography.sans(
                                fontSize: 11,
                                color: AppColors.textMuted,
                              ),
                            ),
                          ],
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                          decoration: BoxDecoration(
                            color: _getStatusBg(order.status),
                            borderRadius: BorderRadius.circular(14),
                          ),
                          child: Text(
                            order.statusLabel,
                            style: AppTypography.sans(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: _getStatusTextColor(order.status),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),

                    // Tracking Stepper Timeline
                    _buildTrackingTimeline(order.status),
                  ],
                ),
              ),
              const SizedBox(height: 20),

              // Courier Dispatch Info (if shipped or making)
              Container(
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: AppColors.surfaceWarm,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: AppColors.borderLight),
                ),
                child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(10),
                      decoration: const BoxDecoration(
                        color: AppColors.surface,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(Icons.local_shipping_outlined, color: AppColors.primary, size: 20),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Trax Logistics • Express Tracking',
                            style: AppTypography.sans(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: AppColors.textPrimary,
                            ),
                          ),
                          Text(
                            'Tracking Number: TRX-82914-LHE',
                            style: AppTypography.sans(
                              fontSize: 11,
                              color: AppColors.textSecondary,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Icon(Icons.copy_outlined, size: 16, color: AppColors.textMuted),
                  ],
                ),
              ),
              const SizedBox(height: 20),

              // Items Ordered Section
              Text(
                'Items Ordered',
                style: AppTypography.serif(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textPrimary,
                ),
              ),
              const SizedBox(height: 10),
              Container(
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: AppColors.surface,
                  borderRadius: BorderRadius.circular(18),
                  border: Border.all(color: AppColors.borderLight),
                ),
                child: Column(
                  children: order.itemNames.map((name) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: Row(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(12),
                            child: CrochetImage(
                              imagePath: order.primaryImage,
                              width: 52,
                              height: 52,
                            ),
                          ),
                          const SizedBox(width: 14),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  name,
                                  style: AppTypography.serif(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    color: AppColors.textPrimary,
                                  ),
                                ),
                                Text(
                                  'Handmade with soft combed cotton',
                                  style: AppTypography.sans(
                                    fontSize: 11,
                                    color: AppColors.textMuted,
                                  ),
                                ),
                                const SizedBox(height: 2),
                                Text(
                                  'Qty: 1',
                                  style: AppTypography.sans(
                                    fontSize: 11,
                                    color: AppColors.textSecondary,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Text(
                            'Rs ${order.totalAmount.toString().replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (m) => '${m[1]},')}',
                            style: AppTypography.sans(
                              fontSize: 13,
                              fontWeight: FontWeight.bold,
                              color: AppColors.textPrimary,
                            ),
                          ),
                        ],
                      ),
                    );
                  }).toList(),
                ),
              ),
              const SizedBox(height: 20),

              // Maker Contact Section
              Container(
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: AppColors.surface,
                  borderRadius: BorderRadius.circular(18),
                  border: Border.all(color: AppColors.borderLight),
                ),
                child: Row(
                  children: [
                    Container(
                      width: 44,
                      height: 44,
                      decoration: const BoxDecoration(
                        color: AppColors.blush,
                        shape: BoxShape.circle,
                      ),
                      child: Center(
                        child: Text(
                          'S',
                          style: AppTypography.serif(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: AppColors.primary,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Crafted by Sage Studio',
                            style: AppTypography.sans(
                              fontSize: 13,
                              fontWeight: FontWeight.bold,
                              color: AppColors.textPrimary,
                            ),
                          ),
                          Text(
                            'Verified Artisan • 4.8 ★ (142 reviews)',
                            style: AppTypography.sans(
                              fontSize: 11,
                              color: AppColors.textSecondary,
                            ),
                          ),
                        ],
                      ),
                    ),
                    OutlinedButton.icon(
                      onPressed: onChatWithMaker ??
                          () {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Maker message thread opened!'),
                                backgroundColor: AppColors.primary,
                              ),
                            );
                          },
                      icon: const Icon(Icons.chat_bubble_outline, size: 14),
                      label: const Text('Message'),
                      style: OutlinedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                        minimumSize: Size.zero,
                        side: const BorderSide(color: AppColors.primary),
                        foregroundColor: AppColors.primary,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),

              // Shipping & Payment Summary
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: AppColors.surface,
                  borderRadius: BorderRadius.circular(18),
                  border: Border.all(color: AppColors.borderLight),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Delivery Address',
                      style: AppTypography.sans(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: AppColors.textPrimary,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      '${order.buyerName}\nHouse 42, Block J, Model Town, ${order.city}\nPhone: +92 300 4567890',
                      style: AppTypography.sans(
                        fontSize: 12,
                        color: AppColors.textSecondary,
                        height: 1.4,
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 12.0),
                      child: Divider(height: 1, color: AppColors.borderLight),
                    ),
                    _buildInvoiceRow('Payment method', 'Cash on Delivery'),
                    const SizedBox(height: 6),
                    _buildInvoiceRow('Subtotal', 'Rs ${(order.totalAmount - 250).toString().replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (m) => '${m[1]},')}'),
                    const SizedBox(height: 6),
                    _buildInvoiceRow('Courier fee', 'Rs 250'),
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 8.0),
                      child: Divider(height: 1, color: AppColors.borderLight),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Total Paid / Due',
                          style: AppTypography.sans(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: AppColors.textPrimary,
                          ),
                        ),
                        Text(
                          'Rs ${order.totalAmount.toString().replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (m) => '${m[1]},')}',
                          style: AppTypography.sans(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: AppColors.primary,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),

              // Bottom Actions
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton.icon(
                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Downloading invoice PDF...'),
                            backgroundColor: AppColors.sage,
                          ),
                        );
                      },
                      icon: const Icon(Icons.download_outlined, size: 16),
                      label: const Text('Invoice'),
                      style: OutlinedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        side: const BorderSide(color: AppColors.border),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  if (order.status == OrderStatus.delivered && onRateOrder != null)
                    Expanded(
                      child: ElevatedButton.icon(
                        onPressed: onRateOrder,
                        icon: const Icon(Icons.star_outline, size: 16),
                        label: const Text('Rate Order'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primary,
                          padding: const EdgeInsets.symmetric(vertical: 12),
                        ),
                      ),
                    ),
                ],
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTrackingTimeline(OrderStatus status) {
    int currentStep = 2; // Default making
    if (status == OrderStatus.pending) currentStep = 1;
    if (status == OrderStatus.making) currentStep = 2;
    if (status == OrderStatus.shipped) currentStep = 3;
    if (status == OrderStatus.delivered) currentStep = 4;

    final steps = [
      {'title': 'Ordered', 'desc': '8 Oct'},
      {'title': 'Making', 'desc': 'By Maker'},
      {'title': 'Shipped', 'desc': 'Trax Courier'},
      {'title': 'Delivered', 'desc': 'Doorstep'},
    ];

    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: List.generate(steps.length, (index) {
            final isReached = index + 1 <= currentStep;
            return Column(
              children: [
                Container(
                  width: 26,
                  height: 26,
                  decoration: BoxDecoration(
                    color: isReached ? AppColors.primary : AppColors.surfaceWarm,
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: isReached ? AppColors.primary : AppColors.border,
                      width: 1.5,
                    ),
                  ),
                  child: Center(
                    child: isReached
                        ? const Icon(Icons.check, size: 14, color: Colors.white)
                        : Text(
                            '${index + 1}',
                            style: AppTypography.sans(
                              fontSize: 11,
                              color: AppColors.textMuted,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  steps[index]['title']!,
                  style: AppTypography.sans(
                    fontSize: 11,
                    fontWeight: isReached ? FontWeight.bold : FontWeight.w500,
                    color: isReached ? AppColors.textPrimary : AppColors.textMuted,
                  ),
                ),
                Text(
                  steps[index]['desc']!,
                  style: AppTypography.sans(
                    fontSize: 9,
                    color: AppColors.textMuted,
                  ),
                ),
              ],
            );
          }),
        ),
      ],
    );
  }

  Widget _buildInvoiceRow(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: AppTypography.sans(fontSize: 12, color: AppColors.textSecondary),
        ),
        Text(
          value,
          style: AppTypography.sans(fontSize: 12, fontWeight: FontWeight.w500, color: AppColors.textPrimary),
        ),
      ],
    );
  }

  Color _getStatusBg(OrderStatus status) {
    switch (status) {
      case OrderStatus.pending:
        return AppColors.statusPending;
      case OrderStatus.making:
        return AppColors.statusMaking;
      case OrderStatus.shipped:
        return AppColors.statusShipped;
      case OrderStatus.delivered:
        return AppColors.statusActive;
      case OrderStatus.cancelled:
        return const Color(0xFFFFEBEE);
    }
  }

  Color _getStatusTextColor(OrderStatus status) {
    switch (status) {
      case OrderStatus.pending:
        return AppColors.statusPendingText;
      case OrderStatus.making:
        return AppColors.statusMakingText;
      case OrderStatus.shipped:
        return AppColors.statusShippedText;
      case OrderStatus.delivered:
        return AppColors.statusActiveText;
      case OrderStatus.cancelled:
        return const Color(0xFFC62828);
    }
  }
}

