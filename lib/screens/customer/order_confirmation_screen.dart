import 'package:flutter/material.dart';

import '../../theme/app_theme.dart';

class OrderConfirmationScreen extends StatelessWidget {
  final VoidCallback onTrackOrder;
  final VoidCallback onContinueShopping;

  const OrderConfirmationScreen({
    super.key,
    required this.onTrackOrder,
    required this.onContinueShopping,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Spacer(),
              // Big Green Checkmark
              Container(
                width: 72,
                height: 72,
                decoration: const BoxDecoration(
                  color: AppColors.sage,
                  shape: BoxShape.circle,
                ),
                child: const Center(
                  child: Icon(
                    Icons.check,
                    color: Colors.white,
                    size: 38,
                  ),
                ),
              ),
              const SizedBox(height: 20),

              // Title and Subtitle
              Text(
                'Order placed!',
                style: AppTypography.serif(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textPrimary,
                ),
              ),
              const SizedBox(height: 8),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Text(
                  'Thank you, Arbab. Your order #1043 is confirmed and sent to the makers.',
                  textAlign: TextAlign.center,
                  style: AppTypography.sans(
                    fontSize: 13,
                    color: AppColors.textSecondary,
                    height: 1.4,
                  ),
                ),
              ),
              const SizedBox(height: 28),

              // Order Summary Card
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: AppColors.surface,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: AppColors.borderLight),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.03),
                      blurRadius: 8,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    _buildSummaryRow('Items', '2'),
                    const SizedBox(height: 12),
                    _buildSummaryRow('Payment', 'Cash on Delivery'),
                    const SizedBox(height: 12),
                    _buildSummaryRow('Delivery', '3-5 working days'),
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 12.0),
                      child: Divider(height: 1, color: AppColors.borderLight),
                    ),
                    _buildSummaryRow('Total', 'Rs 9,150', isBold: true),
                  ],
                ),
              ),
              const Spacer(),

              // Buttons
              SizedBox(
                width: double.infinity,
                height: 52,
                child: ElevatedButton(
                  onPressed: onTrackOrder,
                  child: const Text('Track order'),
                ),
              ),
              const SizedBox(height: 12),
              SizedBox(
                width: double.infinity,
                height: 52,
                child: OutlinedButton(
                  onPressed: onContinueShopping,
                  style: OutlinedButton.styleFrom(
                    backgroundColor: AppColors.surface,
                    side: BorderSide.none,
                  ),
                  child: Text(
                    'Continue shopping',
                    style: AppTypography.sans(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: AppColors.textSecondary,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSummaryRow(String label, String value, {bool isBold = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: AppTypography.sans(
            fontSize: 13,
            color: isBold ? AppColors.textPrimary : AppColors.textSecondary,
            fontWeight: isBold ? FontWeight.bold : FontWeight.w500,
          ),
        ),
        Text(
          value,
          style: AppTypography.sans(
            fontSize: isBold ? 15 : 13,
            fontWeight: isBold ? FontWeight.bold : FontWeight.w600,
            color: isBold ? AppColors.primary : AppColors.textPrimary,
          ),
        ),
      ],
    );
  }
}
