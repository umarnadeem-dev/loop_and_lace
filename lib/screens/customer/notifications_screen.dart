import 'package:flutter/material.dart';

import '../../theme/app_theme.dart';
import '../../data/mock_data.dart';
import '../../models/app_models.dart';

class NotificationsScreen extends StatefulWidget {
  final VoidCallback onBack;

  const NotificationsScreen({
    super.key,
    required this.onBack,
  });

  @override
  State<NotificationsScreen> createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  late List<AppNotificationItem> _notifs;

  @override
  void initState() {
    super.initState();
    _notifs = MockData.notifications;
  }

  void _markAllAsRead() {
    setState(() {
      for (var n in _notifs) {
        n.isRead = true;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final todayList = _notifs.take(2).toList();
    final earlierList = _notifs.skip(2).toList();

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
                      IconButton(
                        padding: EdgeInsets.zero,
                        constraints: const BoxConstraints(),
                        icon: const Icon(Icons.arrow_back_ios_new, size: 18),
                        onPressed: widget.onBack,
                      ),
                      const SizedBox(width: 12),
                      Text(
                        'Notifications',
                        style: AppTypography.serif(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: AppColors.textPrimary,
                        ),
                      ),
                    ],
                  ),
                  TextButton(
                    onPressed: _markAllAsRead,
                    child: Text(
                      'Mark all read',
                      style: AppTypography.sans(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: AppColors.primary,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),

              Expanded(
                child: ListView(
                  children: [
                    // Today section
                    Text(
                      'Today',
                      style: AppTypography.sans(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: AppColors.textMuted,
                      ),
                    ),
                    const SizedBox(height: 8),
                    ...todayList.map((n) => _buildNotificationCard(n)),
                    const SizedBox(height: 20),

                    // Earlier section
                    Text(
                      'Earlier',
                      style: AppTypography.sans(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: AppColors.textMuted,
                      ),
                    ),
                    const SizedBox(height: 8),
                    ...earlierList.map((n) => _buildNotificationCard(n)),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNotificationCard(AppNotificationItem item) {
    IconData iconData = Icons.card_giftcard;
    Color iconColor = AppColors.primary;
    if (item.type == 'promo') {
      iconData = Icons.local_offer_outlined;
      iconColor = AppColors.sage;
    } else if (item.type == 'custom') {
      iconData = Icons.auto_awesome;
      iconColor = const Color(0xFFD47A22);
    }

    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.borderLight),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: iconColor.withValues(alpha: 0.12),
              shape: BoxShape.circle,
            ),
            child: Icon(iconData, size: 18, color: iconColor),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        item.title,
                        style: AppTypography.sans(
                          fontSize: 13,
                          fontWeight: FontWeight.bold,
                          color: AppColors.textPrimary,
                        ),
                      ),
                    ),
                    if (!item.isRead)
                      Container(
                        width: 7,
                        height: 7,
                        decoration: const BoxDecoration(
                          color: AppColors.primary,
                          shape: BoxShape.circle,
                        ),
                      ),
                  ],
                ),
                const SizedBox(height: 2),
                Text(
                  item.subtitle,
                  style: AppTypography.sans(
                    fontSize: 12,
                    color: AppColors.textSecondary,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  item.timeAgo,
                  style: AppTypography.sans(
                    fontSize: 11,
                    color: AppColors.textMuted,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
