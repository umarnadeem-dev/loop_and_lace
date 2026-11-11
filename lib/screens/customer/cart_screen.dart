import 'package:flutter/material.dart';

import '../../theme/app_theme.dart';
import '../../data/mock_data.dart';
import '../../models/app_models.dart';
import '../../widgets/crochet_image.dart';

class CartScreen extends StatefulWidget {
  final VoidCallback onPlaceOrder;
  final Function(List<CartItem>)? onProceedToCheckout;
  final VoidCallback onNotificationTap;

  const CartScreen({
    super.key,
    required this.onPlaceOrder,
    this.onProceedToCheckout,
    required this.onNotificationTap,
  });

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  late List<CartItem> _cartItems;
  String _selectedPaymentMethod = 'Cash on Delivery';
  final List<String> _paymentMethods = ['Cash on Delivery', 'JazzCash', 'Card'];
  final int _deliveryFee = 250;

  @override
  void initState() {
    super.initState();
    _cartItems = [
      CartItem(product: MockData.products[0], quantity: 1), // Berry Bunny
      CartItem(product: MockData.products[2], quantity: 1), // Cozy Throw
    ];
  }

  int get _subtotal =>
      _cartItems.fold(0, (sum, item) => sum + item.totalPrice);

  int get _total => _subtotal + (_cartItems.isEmpty ? 0 : _deliveryFee);

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
                  Row(
                    children: [
                      if (Navigator.canPop(context)) ...[
                        IconButton(
                          padding: EdgeInsets.zero,
                          constraints: const BoxConstraints(),
                          icon: const Icon(Icons.arrow_back_ios_new, size: 18),
                          onPressed: () => Navigator.pop(context),
                        ),
                        const SizedBox(width: 12),
                      ],
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '${_cartItems.length} items',
                            style: AppTypography.sans(
                              fontSize: 12,
                              color: AppColors.textSecondary,
                            ),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            'My Cart',
                            style: AppTypography.serif(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                              color: AppColors.textPrimary,
                            ),
                          ),
                        ],
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
              const SizedBox(height: 20),

              // Cart Items List
              ..._cartItems.map((cartItem) => _buildCartItemCard(cartItem)),
              const SizedBox(height: 16),

              // Bill Breakdown
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: AppColors.surface,
                  borderRadius: BorderRadius.circular(18),
                  border: Border.all(color: AppColors.borderLight),
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Subtotal',
                          style: AppTypography.sans(
                            fontSize: 13,
                            color: AppColors.textSecondary,
                          ),
                        ),
                        Text(
                          'Rs ${_subtotal.toString().replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},')}',
                          style: AppTypography.sans(
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                            color: AppColors.textPrimary,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Delivery',
                          style: AppTypography.sans(
                            fontSize: 13,
                            color: AppColors.textSecondary,
                          ),
                        ),
                        Text(
                          'Rs $_deliveryFee',
                          style: AppTypography.sans(
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                            color: AppColors.textPrimary,
                          ),
                        ),
                      ],
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 10.0),
                      child: Divider(height: 1, color: AppColors.borderLight),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Total',
                          style: AppTypography.sans(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: AppColors.textPrimary,
                          ),
                        ),
                        Text(
                          'Rs ${_total.toString().replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},')}',
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
              const SizedBox(height: 20),

              // Payment Methods
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: _paymentMethods.map((method) {
                    final isSelected = _selectedPaymentMethod == method;
                    return Padding(
                      padding: const EdgeInsets.only(right: 8.0),
                      child: ChoiceChip(
                        label: Text(method),
                        selected: isSelected,
                        onSelected: (selected) {
                          if (selected) {
                            setState(() {
                              _selectedPaymentMethod = method;
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
              const SizedBox(height: 24),

              // Checkout Button
              SizedBox(
                width: double.infinity,
                height: 52,
                child: ElevatedButton(
                  onPressed: _cartItems.isEmpty
                      ? null
                      : () {
                          if (widget.onProceedToCheckout != null) {
                            widget.onProceedToCheckout!(_cartItems);
                          } else {
                            widget.onPlaceOrder();
                          }
                        },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  child: Text(
                    _cartItems.isEmpty
                        ? 'Cart is empty'
                        : 'Proceed to Checkout • Rs ${_total.toString().replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},')}',
                    style: AppTypography.sans(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.white),
                  ),
                ),
              ),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCartItemCard(CartItem item) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: AppColors.borderLight),
      ),
      child: Row(
        children: [
          CrochetImage(
            imagePath: item.product.imagePath,
            width: 65,
            height: 65,
            borderRadius: BorderRadius.circular(12),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.product.title,
                  style: AppTypography.serif(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textPrimary,
                  ),
                ),
                Text(
                  item.product.maker,
                  style: AppTypography.sans(
                    fontSize: 11,
                    color: AppColors.textMuted,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'Rs ${item.product.price.toString().replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},')}',
                  style: AppTypography.sans(
                    fontSize: 13,
                    fontWeight: FontWeight.bold,
                    color: AppColors.primary,
                  ),
                ),
              ],
            ),
          ),
          // Quantity Controls
          Row(
            children: [
              GestureDetector(
                onTap: () {
                  if (item.quantity > 1) {
                    setState(() {
                      item.quantity--;
                    });
                  } else {
                    setState(() {
                      _cartItems.remove(item);
                    });
                  }
                },
                child: Container(
                  width: 28,
                  height: 28,
                  decoration: BoxDecoration(
                    color: AppColors.surfaceWarm,
                    shape: BoxShape.circle,
                    border: Border.all(color: AppColors.borderLight),
                  ),
                  child: Center(
                    child: Icon(
                      item.quantity > 1 ? Icons.remove : Icons.delete_outline,
                      size: 14,
                      color: item.quantity > 1 ? AppColors.textPrimary : Colors.red,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Text(
                  '${item.quantity}',
                  style: AppTypography.sans(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textPrimary,
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  setState(() {
                    item.quantity++;
                  });
                },
                child: Container(
                  width: 28,
                  height: 28,
                  decoration: const BoxDecoration(
                    color: AppColors.primary,
                    shape: BoxShape.circle,
                  ),
                  child: const Center(
                    child: Icon(Icons.add, size: 14, color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
