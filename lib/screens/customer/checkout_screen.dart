import 'package:flutter/material.dart';

import '../../theme/app_theme.dart';
import '../../data/mock_data.dart';
import '../../models/app_models.dart';
import '../../widgets/crochet_image.dart';

class CheckoutScreen extends StatefulWidget {
  final List<CartItem> cartItems;
  final VoidCallback onOrderPlaced;
  final VoidCallback onBack;

  const CheckoutScreen({
    super.key,
    required this.cartItems,
    required this.onOrderPlaced,
    required this.onBack,
  });

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  late AddressItem _selectedAddress;
  String _selectedPaymentMethod = 'Cash on Delivery';
  int _deliveryOptionIndex = 0; // 0: Standard (Rs 250), 1: Express (Rs 450)
  
  final TextEditingController _noteController = TextEditingController();
  final TextEditingController _promoController = TextEditingController();
  
  bool _promoApplied = false;
  int _discount = 0;

  final List<Map<String, dynamic>> _deliveryOptions = [
    {
      'title': 'Standard Courier Delivery',
      'days': '3-5 business days',
      'cost': 250,
      'badge': 'Safe & Tracked',
    },
    {
      'title': 'Express Maker Dispatch',
      'days': '1-2 business days',
      'cost': 450,
      'badge': 'Priority',
    },
  ];

  final List<Map<String, dynamic>> _paymentOptions = [
    {
      'title': 'Cash on Delivery',
      'subtitle': 'Pay in cash when parcel arrives at your doorstep',
      'icon': Icons.local_atm_outlined,
    },
    {
      'title': 'JazzCash / EasyPaisa',
      'subtitle': 'Instant mobile wallet payment to maker escrow',
      'icon': Icons.account_balance_wallet_outlined,
    },
    {
      'title': 'Credit / Debit Card',
      'subtitle': 'Visa, Mastercard & UnionPay accepted',
      'icon': Icons.credit_card_outlined,
    },
  ];

  @override
  void initState() {
    super.initState();
    _selectedAddress = MockData.savedAddresses.firstWhere(
      (a) => a.isDefault,
      orElse: () => MockData.savedAddresses.first,
    );
  }

  @override
  void dispose() {
    _noteController.dispose();
    _promoController.dispose();
    super.dispose();
  }

  int get _subtotal =>
      widget.cartItems.fold(0, (sum, item) => sum + item.totalPrice);

  int get _deliveryFee =>
      widget.cartItems.isEmpty ? 0 : _deliveryOptions[_deliveryOptionIndex]['cost'] as int;

  int get _grandTotal => (_subtotal + _deliveryFee - _discount).clamp(0, 9999999);

  void _applyPromo() {
    final code = _promoController.text.trim().toUpperCase();
    if (code == 'LOOP10' || code == 'CROCHET') {
      setState(() {
        _promoApplied = true;
        _discount = (_subtotal * 0.10).round();
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Promo code applied! You saved Rs $_discount'),
          backgroundColor: AppColors.sage,
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Invalid code. Try "LOOP10" for 10% off!'),
          backgroundColor: AppColors.primary,
        ),
      );
    }
  }

  void _showAddressPickerModal() {
    showModalBottomSheet(
      context: context,
      backgroundColor: AppColors.surface,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (context) {
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Select Delivery Address',
                      style: AppTypography.serif(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: AppColors.textPrimary,
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.close, size: 20),
                      onPressed: () => Navigator.pop(context),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                ...MockData.savedAddresses.map((addr) {
                  final isCurrent = addr.id == _selectedAddress.id;
                  return InkWell(
                    onTap: () {
                      setState(() {
                        _selectedAddress = addr;
                      });
                      Navigator.pop(context);
                    },
                    borderRadius: BorderRadius.circular(16),
                    child: Container(
                      margin: const EdgeInsets.only(bottom: 10),
                      padding: const EdgeInsets.all(14),
                      decoration: BoxDecoration(
                        color: isCurrent ? AppColors.blush.withValues(alpha: 0.3) : AppColors.surfaceWarm,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(
                          color: isCurrent ? AppColors.primary : AppColors.borderLight,
                          width: isCurrent ? 1.5 : 1,
                        ),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            isCurrent ? Icons.radio_button_checked : Icons.radio_button_off,
                            color: isCurrent ? AppColors.primary : AppColors.textMuted,
                            size: 20,
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      addr.label,
                                      style: AppTypography.sans(
                                        fontSize: 13,
                                        fontWeight: FontWeight.bold,
                                        color: AppColors.textPrimary,
                                      ),
                                    ),
                                    if (addr.isDefault) ...[
                                      const SizedBox(width: 8),
                                      Container(
                                        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                                        decoration: BoxDecoration(
                                          color: AppColors.sageLight,
                                          borderRadius: BorderRadius.circular(6),
                                        ),
                                        child: Text(
                                          'Default',
                                          style: AppTypography.sans(
                                            fontSize: 9,
                                            fontWeight: FontWeight.bold,
                                            color: AppColors.sageDark,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ],
                                ),
                                const SizedBox(height: 2),
                                Text(
                                  '${addr.recipientName} • ${addr.phone}',
                                  style: AppTypography.sans(
                                    fontSize: 11,
                                    color: AppColors.textSecondary,
                                  ),
                                ),
                                Text(
                                  addr.fullAddress,
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
                    ),
                  );
                }),
                const SizedBox(height: 8),
              ],
            ),
          ),
        );
      },
    );
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
          'Checkout',
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
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Delivery Address Card
              _buildSectionHeader('Delivery Address', Icons.location_on_outlined),
              const SizedBox(height: 10),
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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                              decoration: BoxDecoration(
                                color: AppColors.blush,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Text(
                                _selectedAddress.label,
                                style: AppTypography.sans(
                                  fontSize: 11,
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.primary,
                                ),
                              ),
                            ),
                            const SizedBox(width: 8),
                            Text(
                              _selectedAddress.recipientName,
                              style: AppTypography.sans(
                                fontSize: 13,
                                fontWeight: FontWeight.bold,
                                color: AppColors.textPrimary,
                              ),
                            ),
                          ],
                        ),
                        GestureDetector(
                          onTap: _showAddressPickerModal,
                          child: Text(
                            'Change',
                            style: AppTypography.sans(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: AppColors.primary,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Text(
                      _selectedAddress.fullAddress,
                      style: AppTypography.sans(
                        fontSize: 12,
                        color: AppColors.textSecondary,
                        height: 1.3,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Contact: ${_selectedAddress.phone}',
                      style: AppTypography.sans(
                        fontSize: 11,
                        color: AppColors.textMuted,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 22),

              // Delivery Speed / Shipping Options
              _buildSectionHeader('Shipping Speed', Icons.local_shipping_outlined),
              const SizedBox(height: 10),
              ...List.generate(_deliveryOptions.length, (index) {
                final opt = _deliveryOptions[index];
                final isSelected = _deliveryOptionIndex == index;
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      _deliveryOptionIndex = index;
                    });
                  },
                  child: Container(
                    margin: const EdgeInsets.only(bottom: 10),
                    padding: const EdgeInsets.all(14),
                    decoration: BoxDecoration(
                      color: isSelected ? AppColors.surface : AppColors.surfaceWarm.withValues(alpha: 0.5),
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(
                        color: isSelected ? AppColors.primary : AppColors.borderLight,
                        width: isSelected ? 1.5 : 1,
                      ),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          isSelected ? Icons.radio_button_checked : Icons.radio_button_off,
                          color: isSelected ? AppColors.primary : AppColors.textMuted,
                          size: 18,
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                opt['title'] as String,
                                style: AppTypography.sans(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w600,
                                  color: AppColors.textPrimary,
                                ),
                              ),
                              Text(
                                opt['days'] as String,
                                style: AppTypography.sans(
                                  fontSize: 11,
                                  color: AppColors.textSecondary,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Text(
                          'Rs ${opt['cost']}',
                          style: AppTypography.sans(
                            fontSize: 13,
                            fontWeight: FontWeight.bold,
                            color: AppColors.primary,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }),
              const SizedBox(height: 16),

              // Items in Order
              _buildSectionHeader('Items (${widget.cartItems.length})', Icons.shopping_bag_outlined),
              const SizedBox(height: 10),
              Container(
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: AppColors.surface,
                  borderRadius: BorderRadius.circular(18),
                  border: Border.all(color: AppColors.borderLight),
                ),
                child: Column(
                  children: widget.cartItems.map((item) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: Row(
                        children: [
                          CrochetImage(
                            imagePath: item.product.imagePath,
                            width: 50,
                            height: 50,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  item.product.title,
                                  style: AppTypography.serif(
                                    fontSize: 13,
                                    fontWeight: FontWeight.bold,
                                    color: AppColors.textPrimary,
                                  ),
                                ),
                                Text(
                                  'By ${item.product.maker} • Color: ${item.selectedColor}',
                                  style: AppTypography.sans(
                                    fontSize: 10,
                                    color: AppColors.textMuted,
                                  ),
                                ),
                                const SizedBox(height: 2),
                                Text(
                                  'Qty: ${item.quantity}',
                                  style: AppTypography.sans(
                                    fontSize: 11,
                                    color: AppColors.textSecondary,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Text(
                            'Rs ${item.totalPrice.toString().replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (m) => '${m[1]},')}',
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
              const SizedBox(height: 22),

              // Payment Method
              _buildSectionHeader('Payment Method', Icons.payment_outlined),
              const SizedBox(height: 10),
              Container(
                decoration: BoxDecoration(
                  color: AppColors.surface,
                  borderRadius: BorderRadius.circular(18),
                  border: Border.all(color: AppColors.borderLight),
                ),
                child: Column(
                  children: _paymentOptions.map((opt) {
                    final title = opt['title'] as String;
                    final isSelected = _selectedPaymentMethod == title;
                    return InkWell(
                      onTap: () {
                        setState(() {
                          _selectedPaymentMethod = title;
                        });
                      },
                      borderRadius: BorderRadius.circular(18),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                        child: Row(
                          children: [
                            Icon(
                              opt['icon'] as IconData,
                              size: 20,
                              color: isSelected ? AppColors.primary : AppColors.textSecondary,
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    title,
                                    style: AppTypography.sans(
                                      fontSize: 13,
                                      fontWeight: FontWeight.bold,
                                      color: AppColors.textPrimary,
                                    ),
                                  ),
                                  Text(
                                    opt['subtitle'] as String,
                                    style: AppTypography.sans(
                                      fontSize: 10,
                                      color: AppColors.textMuted,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Icon(
                              isSelected ? Icons.check_circle : Icons.radio_button_off,
                              size: 18,
                              color: isSelected ? AppColors.primary : AppColors.border,
                            ),
                          ],
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ),
              const SizedBox(height: 22),

              // Note for Maker / Gift Request
              _buildSectionHeader('Maker Note / Gift Message (Optional)', Icons.edit_note_outlined),
              const SizedBox(height: 10),
              TextField(
                controller: _noteController,
                maxLines: 2,
                decoration: InputDecoration(
                  hintText: 'e.g. Please wrap with lavender yarn ribbon, it is a gift!',
                  hintStyle: AppTypography.sans(fontSize: 12, color: AppColors.textMuted),
                  filled: true,
                  fillColor: AppColors.surface,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: const BorderSide(color: AppColors.borderLight),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: const BorderSide(color: AppColors.borderLight),
                  ),
                ),
              ),
              const SizedBox(height: 22),

              // Voucher Promo Input
              _buildSectionHeader('Promo Voucher', Icons.discount_outlined),
              const SizedBox(height: 10),
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _promoController,
                      textCapitalization: TextCapitalization.characters,
                      decoration: InputDecoration(
                        hintText: 'Enter code (e.g. LOOP10)',
                        hintStyle: AppTypography.sans(fontSize: 12, color: AppColors.textMuted),
                        filled: true,
                        fillColor: AppColors.surface,
                        contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
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
                  ),
                  const SizedBox(width: 10),
                  ElevatedButton(
                    onPressed: _applyPromo,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.sage,
                      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14),
                      ),
                    ),
                    child: Text(
                      _promoApplied ? 'Applied' : 'Apply',
                      style: AppTypography.sans(fontSize: 12, fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),

              // Order Summary Breakdown Card
              Container(
                padding: const EdgeInsets.all(18),
                decoration: BoxDecoration(
                  color: AppColors.surface,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: AppColors.borderLight),
                ),
                child: Column(
                  children: [
                    _buildSummaryRow(
                      'Subtotal',
                      'Rs ${_subtotal.toString().replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (m) => '${m[1]},')}',
                    ),
                    const SizedBox(height: 8),
                    _buildSummaryRow('Delivery fee', 'Rs $_deliveryFee'),
                    if (_promoApplied) ...[
                      const SizedBox(height: 8),
                      _buildSummaryRow(
                        'Promo Discount',
                        '-Rs $_discount',
                        isNegative: true,
                      ),
                    ],
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 12),
                      child: Divider(height: 1, color: AppColors.borderLight),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Total Payable',
                          style: AppTypography.sans(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: AppColors.textPrimary,
                          ),
                        ),
                        Text(
                          'Rs ${_grandTotal.toString().replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (m) => '${m[1]},')}',
                          style: AppTypography.sans(
                            fontSize: 18,
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

              // Complete Order Button
              SizedBox(
                width: double.infinity,
                height: 52,
                child: ElevatedButton(
                  onPressed: widget.onOrderPlaced,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  child: Text(
                    'Place Order • Rs ${_grandTotal.toString().replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (m) => '${m[1]},')}',
                    style: AppTypography.sans(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSectionHeader(String title, IconData icon) {
    return Row(
      children: [
        Icon(icon, size: 16, color: AppColors.primary),
        const SizedBox(width: 6),
        Text(
          title,
          style: AppTypography.serif(
            fontSize: 15,
            fontWeight: FontWeight.bold,
            color: AppColors.textPrimary,
          ),
        ),
      ],
    );
  }

  Widget _buildSummaryRow(String label, String value, {bool isNegative = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: AppTypography.sans(
            fontSize: 13,
            color: AppColors.textSecondary,
          ),
        ),
        Text(
          value,
          style: AppTypography.sans(
            fontSize: 13,
            fontWeight: FontWeight.w600,
            color: isNegative ? AppColors.sageDark : AppColors.textPrimary,
          ),
        ),
      ],
    );
  }
}

