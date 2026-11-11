import 'package:flutter/material.dart';

import '../../theme/app_theme.dart';

class HelpSupportScreen extends StatefulWidget {
  final VoidCallback onBack;

  const HelpSupportScreen({
    super.key,
    required this.onBack,
  });

  @override
  State<HelpSupportScreen> createState() => _HelpSupportScreenState();
}

class _HelpSupportScreenState extends State<HelpSupportScreen> {
  final TextEditingController _searchController = TextEditingController();
  final TextEditingController _ticketController = TextEditingController();

  final List<Map<String, dynamic>> _faqs = [
    {
      'question': 'How do custom crochet orders work?',
      'answer':
          'You specify your desired colors, measurements, and reference photos in the Custom Order screen. Our verified Pakistani artisans review your request and send a tailored quote with expected completion time.',
      'category': 'Custom Orders',
    },
    {
      'question': 'What are the delivery times and charges across Pakistan?',
      'answer':
          'Standard delivery takes 3-5 working days via Trax/TCS for Rs 250 flat nationwide. Express delivery takes 1-2 days for Rs 450. Since each handmade piece is crocheted with care, maker crafting times vary (usually 3 to 7 days).',
      'category': 'Shipping',
    },
    {
      'question': 'Are the crochet patterns beginner-friendly?',
      'answer':
          'Yes! Loop & Lace is designed for crafters of all skill levels. Every pattern step includes helpful crafting tips alongside universal crochet abbreviations (sc, inc, dec, ch).',
      'category': 'Patterns',
    },
    {
      'question': 'How should I wash and care for my handmade crochet pieces?',
      'answer':
          'Always hand wash in lukewarm or cold water using mild baby detergent or wool wash. Do not wring or tumble dry. Gently press excess water with a towel and lay flat to dry in shade to maintain shape.',
      'category': 'Care & Returns',
    },
    {
      'question': 'Can I pay via Cash on Delivery (COD) or JazzCash?',
      'answer':
          'Yes, we support Cash on Delivery nationwide as well as JazzCash, EasyPaisa, and debit/credit cards through our secure artisan escrow system.',
      'category': 'Payments',
    },
  ];

  @override
  void dispose() {
    _searchController.dispose();
    _ticketController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final query = _searchController.text.trim().toLowerCase();
    final filteredFaqs = _faqs.where((faq) {
      final matchesQuery = query.isEmpty ||
          faq['question'].toString().toLowerCase().contains(query) ||
          faq['answer'].toString().toLowerCase().contains(query);
      return matchesQuery;
    }).toList();

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
          'Help & Support',
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
              // Search Bar
              Container(
                decoration: BoxDecoration(
                  color: AppColors.surface,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: AppColors.borderLight),
                ),
                child: TextField(
                  controller: _searchController,
                  onChanged: (val) => setState(() {}),
                  decoration: InputDecoration(
                    prefixIcon: const Icon(Icons.search, size: 20, color: AppColors.textMuted),
                    hintText: 'Search questions, shipping, care tips...',
                    hintStyle: AppTypography.sans(fontSize: 13, color: AppColors.textMuted),
                    border: InputBorder.none,
                    contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
                  ),
                ),
              ),
              const SizedBox(height: 20),

              // Direct Contact Channels
              Text(
                'Connect with us',
                style: AppTypography.serif(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textPrimary,
                ),
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  _buildContactCard(
                    icon: Icons.chat_bubble_outline,
                    iconColor: AppColors.sage,
                    title: 'WhatsApp',
                    subtitle: '+92 300 8472910',
                    onTap: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Opening WhatsApp Support chat...'),
                          backgroundColor: AppColors.sage,
                        ),
                      );
                    },
                  ),
                  const SizedBox(width: 12),
                  _buildContactCard(
                    icon: Icons.email_outlined,
                    iconColor: AppColors.primary,
                    title: 'Email Us',
                    subtitle: 'care@loopandlace.pk',
                    onTap: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Opening mail client to care@loopandlace.pk...'),
                          backgroundColor: AppColors.primary,
                        ),
                      );
                    },
                  ),
                ],
              ),
              const SizedBox(height: 24),

              // Frequently Asked Questions
              Text(
                'Frequently Asked Questions',
                style: AppTypography.serif(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textPrimary,
                ),
              ),
              const SizedBox(height: 10),
              ...filteredFaqs.map((faq) {
                return Container(
                  margin: const EdgeInsets.only(bottom: 10),
                  decoration: BoxDecoration(
                    color: AppColors.surface,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: AppColors.borderLight),
                  ),
                  child: Theme(
                    data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
                    child: ExpansionTile(
                      tilePadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                      title: Text(
                        faq['question'] as String,
                        style: AppTypography.sans(
                          fontSize: 13,
                          fontWeight: FontWeight.bold,
                          color: AppColors.textPrimary,
                        ),
                      ),
                      childrenPadding: const EdgeInsets.only(left: 16, right: 16, bottom: 16),
                      children: [
                        Text(
                          faq['answer'] as String,
                          style: AppTypography.sans(
                            fontSize: 12,
                            color: AppColors.textSecondary,
                            height: 1.4,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }),
              const SizedBox(height: 24),

              // Send a Message / Ticket
              Container(
                padding: const EdgeInsets.all(18),
                decoration: BoxDecoration(
                  color: AppColors.surface,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: AppColors.borderLight),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Have a specific question?',
                      style: AppTypography.serif(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: AppColors.textPrimary,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Our Lahore community support team replies within 2 hours.',
                      style: AppTypography.sans(fontSize: 11, color: AppColors.textSecondary),
                    ),
                    const SizedBox(height: 12),
                    TextField(
                      controller: _ticketController,
                      maxLines: 3,
                      decoration: InputDecoration(
                        hintText: 'Describe your question or issue...',
                        hintStyle: AppTypography.sans(fontSize: 12, color: AppColors.textMuted),
                        filled: true,
                        fillColor: AppColors.surfaceWarm,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(14),
                          borderSide: const BorderSide(color: AppColors.borderLight),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(14),
                          borderSide: const BorderSide(color: AppColors.borderLight),
                        ),
                      ),
                    ),
                    const SizedBox(height: 12),
                    SizedBox(
                      width: double.infinity,
                      height: 44,
                      child: ElevatedButton(
                        onPressed: () {
                          if (_ticketController.text.trim().isEmpty) return;
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Support ticket received! We will reach out shortly. ✿'),
                              backgroundColor: AppColors.sage,
                            ),
                          );
                          _ticketController.clear();
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primary,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                        ),
                        child: Text(
                          'Send Message',
                          style: AppTypography.sans(fontSize: 13, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildContactCard({
    required IconData icon,
    required Color iconColor,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return Expanded(
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
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
              Icon(icon, size: 24, color: iconColor),
              const SizedBox(height: 8),
              Text(
                title,
                style: AppTypography.sans(fontSize: 13, fontWeight: FontWeight.bold, color: AppColors.textPrimary),
              ),
              const SizedBox(height: 2),
              Text(
                subtitle,
                style: AppTypography.sans(fontSize: 10, color: AppColors.textMuted),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

