import 'package:flutter/material.dart';

import '../../theme/app_theme.dart';
import '../../data/mock_data.dart';
import '../../models/app_models.dart';

class CustomOrdersListScreen extends StatefulWidget {
  final VoidCallback onBack;
  final VoidCallback onNewCustomOrderTap;

  const CustomOrdersListScreen({
    super.key,
    required this.onBack,
    required this.onNewCustomOrderTap,
  });

  @override
  State<CustomOrdersListScreen> createState() => _CustomOrdersListScreenState();
}

class _CustomOrdersListScreenState extends State<CustomOrdersListScreen> {
  late List<CustomRequestItem> _requests;

  @override
  void initState() {
    super.initState();
    _requests = List.from(MockData.customRequests);
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
          'Custom Orders & Quotes',
          style: AppTypography.serif(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: AppColors.textPrimary,
          ),
        ),
        centerTitle: false,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Info banner
              Container(
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: AppColors.blush.withValues(alpha: 0.5),
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: AppColors.primaryLight.withValues(alpha: 0.4)),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.auto_awesome, color: AppColors.primary, size: 20),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        'Artisans will review your photos, size & yarn requests and send a customized quote within 24 hours.',
                        style: AppTypography.sans(
                          fontSize: 12,
                          color: AppColors.primaryDark,
                          height: 1.3,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 18),

              // Custom Requests List
              Expanded(
                child: _requests.isEmpty
                    ? Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(Icons.design_services_outlined, size: 48, color: AppColors.textMuted),
                            const SizedBox(height: 12),
                            Text(
                              'No custom requests yet',
                              style: AppTypography.serif(fontSize: 16, color: AppColors.textPrimary),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              'Describe your dream crochet piece to our makers!',
                              style: AppTypography.sans(fontSize: 12, color: AppColors.textSecondary),
                            ),
                          ],
                        ),
                      )
                    : ListView.builder(
                        itemCount: _requests.length,
                        itemBuilder: (context, index) {
                          final req = _requests[index];
                          return _buildCustomRequestCard(req);
                        },
                      ),
              ),

              // Button to Request New Piece
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton.icon(
                  onPressed: widget.onNewCustomOrderTap,
                  icon: const Icon(Icons.add, size: 18),
                  label: const Text('Start New Custom Order'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
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

  Widget _buildCustomRequestCard(CustomRequestItem req) {
    Color statusBg = AppColors.statusPending;
    Color statusTextColor = AppColors.statusPendingText;
    if (req.status == CustomRequestStatus.quoteSent) {
      statusBg = const Color(0xFFFFF4DE);
      statusTextColor = const Color(0xFFB5701B);
    } else if (req.status == CustomRequestStatus.inProgress) {
      statusBg = AppColors.statusMaking;
      statusTextColor = AppColors.statusMakingText;
    } else if (req.status == CustomRequestStatus.completed) {
      statusBg = AppColors.statusActive;
      statusTextColor = AppColors.statusActiveText;
    }

    return Container(
      margin: const EdgeInsets.only(bottom: 14),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: AppColors.borderLight),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.02),
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
              Text(
                'Request #${req.id}',
                style: AppTypography.sans(fontSize: 11, color: AppColors.textMuted),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: statusBg,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  req.statusLabel,
                  style: AppTypography.sans(
                    fontSize: 11,
                    fontWeight: FontWeight.bold,
                    color: statusTextColor,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            req.title,
            style: AppTypography.serif(
              fontSize: 15,
              fontWeight: FontWeight.bold,
              color: AppColors.textPrimary,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            req.description,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: AppTypography.sans(
              fontSize: 12,
              color: AppColors.textSecondary,
              height: 1.3,
            ),
          ),
          const SizedBox(height: 10),

          // Specs row
          Wrap(
            spacing: 8,
            runSpacing: 6,
            children: [
              _buildSpecTag('Category', req.category),
              _buildSpecTag('Color', req.colorName),
              _buildSpecTag('Size', req.size),
              _buildSpecTag('Maker', req.makerName),
            ],
          ),
          const SizedBox(height: 12),
          const Divider(height: 1, color: AppColors.borderLight),
          const SizedBox(height: 10),

          // Quote & Actions
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    req.quotedPrice != null ? 'Maker Quote' : 'Budget Estimate',
                    style: AppTypography.sans(fontSize: 10, color: AppColors.textMuted),
                  ),
                  Text(
                    req.quotedPrice != null ? 'Rs ${req.quotedPrice}' : req.estimatedBudget,
                    style: AppTypography.sans(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: AppColors.primary,
                    ),
                  ),
                ],
              ),
              if (req.status == CustomRequestStatus.quoteSent) ...[
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      req.status = CustomRequestStatus.inProgress;
                    });
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Quote accepted! ${req.makerName} has commenced crafting your piece.'),
                        backgroundColor: AppColors.sage,
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.sage,
                    padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                    minimumSize: Size.zero,
                  ),
                  child: Text(
                    'Accept & Pay',
                    style: AppTypography.sans(fontSize: 12, fontWeight: FontWeight.bold),
                  ),
                ),
              ] else if (req.status == CustomRequestStatus.inProgress) ...[
                OutlinedButton(
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Connecting to ${req.makerName}...'),
                        backgroundColor: AppColors.primary,
                      ),
                    );
                  },
                  style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    minimumSize: Size.zero,
                    side: const BorderSide(color: AppColors.border),
                  ),
                  child: Text('Chat with Maker', style: AppTypography.sans(fontSize: 12)),
                ),
              ],
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSpecTag(String label, String value) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(
        color: AppColors.surfaceWarm,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        '$label: $value',
        style: AppTypography.sans(fontSize: 10, color: AppColors.textSecondary),
      ),
    );
  }
}

