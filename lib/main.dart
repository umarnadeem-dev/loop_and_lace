import 'package:flutter/material.dart';

import 'theme/app_theme.dart';
import 'widgets/bottom_nav_bars.dart';
import 'utils/screen_catalog.dart';
import 'models/app_models.dart';
import 'data/mock_data.dart';

// Screen imports
import 'screens/auth/welcome_screen.dart';
import 'screens/auth/login_screen.dart';
import 'screens/auth/signup_screen.dart';
import 'screens/customer/customer_home_screen.dart';
import 'screens/customer/pattern_library_screen.dart';
import 'screens/customer/pattern_detail_screen.dart';
import 'screens/customer/wishlist_screen.dart';
import 'screens/customer/custom_order_screen.dart';
import 'screens/customer/cart_screen.dart';
import 'screens/customer/checkout_screen.dart';
import 'screens/customer/order_confirmation_screen.dart';
import 'screens/customer/orders_tracking_screen.dart';
import 'screens/customer/order_detail_screen.dart';
import 'screens/customer/write_review_screen.dart';
import 'screens/customer/address_list_screen.dart';
import 'screens/customer/vendor_profile_view_screen.dart';
import 'screens/customer/help_support_screen.dart';
import 'screens/customer/edit_profile_screen.dart';
import 'screens/customer/custom_orders_list_screen.dart';
import 'screens/customer/notifications_screen.dart';
import 'screens/customer/customer_profile_screen.dart';
import 'screens/vendor/vendor_dashboard_screen.dart';
import 'screens/vendor/new_listing_screen.dart';
import 'screens/vendor/vendor_orders_screen.dart';
import 'screens/vendor/vendor_listings_screen.dart';
import 'screens/admin/admin_panel_screen.dart';
import 'screens/admin/vendor_management_screen.dart';

void main() {
  runApp(const LoopAndLaceApp());
}

class LoopAndLaceApp extends StatelessWidget {
  const LoopAndLaceApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Loop & Lace - Crochet Patterns & Handmade Shop',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      home: const CustomerMainShell(),
      routes: {
        '/home': (context) => const CustomerMainShell(),
        '/welcome': (context) => const WelcomeScreenWrapper(),
        '/vendor': (context) => const VendorMainShell(),
        '/admin': (context) => const AdminMainShell(),
      },
    );
  }
}

/// Main Customer Experience Shell
/// Contains the primary bottom navigation: Home, Patterns, Cart, Me
class CustomerMainShell extends StatefulWidget {
  final int initialTabIndex;

  const CustomerMainShell({
    super.key,
    this.initialTabIndex = 0,
  });

  @override
  State<CustomerMainShell> createState() => _CustomerMainShellState();
}

class _CustomerMainShellState extends State<CustomerMainShell> {
  late int _currentTabIndex;

  // Customer profile state
  String _customerName = 'Arbab Jabeen';
  String _customerBio = 'Crochet lover • Lahore';
  String _customerCity = 'Lahore';
  String _customerPhone = '+92 300 4567890';

  @override
  void initState() {
    super.initState();
    _currentTabIndex = widget.initialTabIndex;
  }

  void _navigateToTab(int index) {
    setState(() {
      _currentTabIndex = index;
    });
  }

  void _openVendorProfile(String makerName) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => VendorProfileViewScreen(
          vendorName: makerName,
          onBack: () => Navigator.pop(context),
          onProductTap: (product) => _openProductDetail(product),
          onRequestCustomTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => CustomOrderScreen(
                  onBack: () => Navigator.pop(context),
                  onRequestSent: () => Navigator.pop(context),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  void _openProductDetail(ProductItem product) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PatternDetailScreen(
          product: product,
          initialStep: 1,
          onBack: () => Navigator.pop(context),
          onMakerTap: (maker) => _openVendorProfile(maker),
          onAddToCart: () {
            Navigator.pop(context);
            _navigateToTab(2); // Go to Cart
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('${product.title} added to your cart!'),
                backgroundColor: AppColors.primary,
                duration: const Duration(seconds: 2),
              ),
            );
          },
        ),
      ),
    );
  }

  void _openOrderDetail(OrderItem order) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => OrderDetailScreen(
          order: order,
          onBack: () => Navigator.pop(context),
          onRateOrder: () => _openWriteReview(order),
        ),
      ),
    );
  }

  void _openWriteReview(OrderItem order) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => WriteReviewScreen(
          productTitle: order.itemNames.first,
          makerName: 'Sage Studio',
          imagePath: order.primaryImage,
          onBack: () => Navigator.pop(context),
          onReviewSubmitted: (rev) {
            MockData.sampleReviews.insert(0, rev);
          },
        ),
      ),
    );
  }

  void _openOrdersTracking() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => OrdersTrackingScreen(
          onBack: () => Navigator.pop(context),
          onOrderTap: (order) => _openOrderDetail(order),
          onRateOrder: (order) => _openWriteReview(order),
          onCustomRequestsTap: _openCustomOrdersList,
        ),
      ),
    );
  }

  void _openCustomOrdersList() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CustomOrdersListScreen(
          onBack: () => Navigator.pop(context),
          onNewCustomOrderTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => CustomOrderScreen(
                  onBack: () => Navigator.pop(context),
                  onRequestSent: () => Navigator.pop(context),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  void _openAddresses() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AddressListScreen(
          onBack: () => Navigator.pop(context),
        ),
      ),
    );
  }

  void _openHelpSupport() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => HelpSupportScreen(
          onBack: () => Navigator.pop(context),
        ),
      ),
    );
  }

  void _openEditProfile() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => EditProfileScreen(
          initialName: _customerName,
          initialBio: _customerBio,
          initialCity: _customerCity,
          initialPhone: _customerPhone,
          onBack: () => Navigator.pop(context),
          onSave: (name, bio, city, phone) {
            setState(() {
              _customerName = name;
              _customerBio = bio;
              _customerCity = city;
              _customerPhone = phone;
            });
          },
        ),
      ),
    );
  }

  void _openCheckout(List<CartItem> cartItems) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CheckoutScreen(
          cartItems: cartItems,
          onBack: () => Navigator.pop(context),
          onOrderPlaced: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => OrderConfirmationScreen(
                  onTrackOrder: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => OrdersTrackingScreen(
                          onBack: () => Navigator.pop(context),
                          onOrderTap: (order) => _openOrderDetail(order),
                          onRateOrder: (order) => _openWriteReview(order),
                          onCustomRequestsTap: _openCustomOrdersList,
                        ),
                      ),
                    );
                  },
                  onContinueShopping: () {
                    Navigator.pop(context);
                    _navigateToTab(0);
                  },
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> pages = [
      // Tab 0: Home Screen
      CustomerHomeScreen(
        onProductTap: (product) => _openProductDetail(product),
        onMakerTap: (maker) => _openVendorProfile(maker),
        onNotificationsTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => NotificationsScreen(
                onBack: () => Navigator.pop(context),
              ),
            ),
          );
        },
        onExploreBannerTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => CustomOrderScreen(
                onBack: () => Navigator.pop(context),
                onRequestSent: () => Navigator.pop(context),
              ),
            ),
          );
        },
        onSeeAllTrendingTap: () => _navigateToTab(1), // Switch to Patterns tab
      ),

      // Tab 1: Pattern Library
      PatternLibraryScreen(
        onPatternSelect: (pattern) => _openProductDetail(pattern),
        onNotificationTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => NotificationsScreen(
                onBack: () => Navigator.pop(context),
              ),
            ),
          );
        },
      ),

      // Tab 2: My Cart
      CartScreen(
        onNotificationTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => NotificationsScreen(
                onBack: () => Navigator.pop(context),
              ),
            ),
          );
        },
        onProceedToCheckout: (cartItems) => _openCheckout(cartItems),
        onPlaceOrder: () => _openCheckout([
          CartItem(product: MockData.products[0], quantity: 1),
          CartItem(product: MockData.products[2], quantity: 1),
        ]),
      ),

      // Tab 3: Profile (Me)
      CustomerProfileScreen(
        userName: _customerName,
        userBio: _customerBio,
        onMyOrdersTap: _openOrdersTracking,
        onCustomOrdersTap: _openCustomOrdersList,
        onAddressesTap: _openAddresses,
        onHelpSupportTap: _openHelpSupport,
        onEditProfileTap: _openEditProfile,
        onSavedPatternsTap: () => _navigateToTab(1),
        onWishlistTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => WishlistScreen(
                onBack: () => Navigator.pop(context),
                onAddToCart: (p) => _navigateToTab(2),
              ),
            ),
          );
        },
        onBecomeVendorTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const VendorMainShell(),
            ),
          );
        },
        onAdminTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const AdminMainShell(),
            ),
          );
        },
        onLogoutTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const WelcomeScreenWrapper(),
            ),
          );
        },
      ),
    ];

    return Scaffold(
      backgroundColor: AppColors.background,
      body: IndexedStack(
        index: _currentTabIndex,
        children: pages,
      ),
      bottomNavigationBar: CustomBottomNav(
        currentIndex: _currentTabIndex,
        onTap: _navigateToTab,
        items: [
          BottomNavItemData(
            icon: Icons.home_outlined,
            selectedIcon: Icons.home,
            label: 'Home',
          ),
          BottomNavItemData(
            icon: Icons.menu_book_outlined,
            selectedIcon: Icons.menu_book,
            label: 'Patterns',
          ),
          BottomNavItemData(
            icon: Icons.shopping_bag_outlined,
            selectedIcon: Icons.shopping_bag,
            label: 'Cart',
            badgeCount: 2,
          ),
          BottomNavItemData(
            icon: Icons.person_outline,
            selectedIcon: Icons.person,
            label: 'Me',
          ),
        ],
      ),
    );
  }
}

/// Vendor Experience Shell
/// Contains Vendor bottom navigation: Studio, Patterns, Me
class VendorMainShell extends StatefulWidget {
  const VendorMainShell({super.key});

  @override
  State<VendorMainShell> createState() => _VendorMainShellState();
}

class _VendorMainShellState extends State<VendorMainShell> {
  int _currentTabIndex = 0;

  void _openNewListing() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => NewListingScreen(
          onBack: () => Navigator.pop(context),
          onPublish: () => Navigator.pop(context),
        ),
      ),
    );
  }

  void _openListingsCatalog() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => VendorListingsScreen(
          onBack: () => Navigator.pop(context),
          onNewListingTap: _openNewListing,
        ),
      ),
    );
  }

  void _openVendorOrders() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => VendorOrdersScreen(
          onNotificationTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => NotificationsScreen(
                  onBack: () => Navigator.pop(context),
                ),
              ),
            );
          },
          onOrderTap: (order) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => OrderDetailScreen(
                  order: order,
                  onBack: () => Navigator.pop(context),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> pages = [
      // Tab 0: Vendor Studio Dashboard
      VendorDashboardScreen(
        onNewListingTap: _openNewListing,
        onListingsTap: _openListingsCatalog,
        onOrdersTap: _openVendorOrders,
        onNotificationTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => NotificationsScreen(
                onBack: () => Navigator.pop(context),
              ),
            ),
          );
        },
      ),

      // Tab 1: Pattern Library (Vendor view)
      PatternLibraryScreen(
        onPatternSelect: (pattern) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => PatternDetailScreen(
                product: pattern,
                initialStep: 1,
                onBack: () => Navigator.pop(context),
              ),
            ),
          );
        },
        onNotificationTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => NotificationsScreen(
                onBack: () => Navigator.pop(context),
              ),
            ),
          );
        },
      ),

      // Tab 2: Vendor Profile
      CustomerProfileScreen(
        userName: 'Sage Studio',
        userBio: 'Verified Artisan • Gulberg III, Lahore',
        onMyOrdersTap: _openVendorOrders,
        onCustomOrdersTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => CustomOrdersListScreen(
                onBack: () => Navigator.pop(context),
                onNewCustomOrderTap: () {},
              ),
            ),
          );
        },
        onAddressesTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AddressListScreen(
                onBack: () => Navigator.pop(context),
              ),
            ),
          );
        },
        onHelpSupportTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => HelpSupportScreen(
                onBack: () => Navigator.pop(context),
              ),
            ),
          );
        },
        onSavedPatternsTap: () {
          setState(() {
            _currentTabIndex = 1;
          });
        },
        onWishlistTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => WishlistScreen(
                onBack: () => Navigator.pop(context),
                onAddToCart: (p) {},
              ),
            ),
          );
        },
        onBecomeVendorTap: () {
          // Switch back to customer app
          Navigator.pop(context);
        },
        onLogoutTap: () {
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
              builder: (context) => const WelcomeScreenWrapper(),
            ),
            (route) => false,
          );
        },
      ),
    ];

    return Scaffold(
      backgroundColor: AppColors.background,
      body: IndexedStack(
        index: _currentTabIndex,
        children: pages,
      ),
      bottomNavigationBar: CustomBottomNav(
        currentIndex: _currentTabIndex,
        onTap: (index) {
          setState(() {
            _currentTabIndex = index;
          });
        },
        items: [
          BottomNavItemData(
            icon: Icons.storefront_outlined,
            selectedIcon: Icons.storefront,
            label: 'Studio',
          ),
          BottomNavItemData(
            icon: Icons.menu_book_outlined,
            selectedIcon: Icons.menu_book,
            label: 'Patterns',
          ),
          BottomNavItemData(
            icon: Icons.person_outline,
            selectedIcon: Icons.person,
            label: 'Me',
          ),
        ],
      ),
    );
  }
}

/// Admin Experience Shell
/// Contains Admin bottom navigation: Admin, App, Me
class AdminMainShell extends StatefulWidget {
  const AdminMainShell({super.key});

  @override
  State<AdminMainShell> createState() => _AdminMainShellState();
}

class _AdminMainShellState extends State<AdminMainShell> {
  int _currentTabIndex = 0;

  @override
  Widget build(BuildContext context) {
    final List<Widget> pages = [
      // Tab 0: Admin Panel
      AdminPanelScreen(
        onVendorsTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => VendorManagementScreen(
                onNotificationTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => NotificationsScreen(
                        onBack: () => Navigator.pop(context),
                      ),
                    ),
                  );
                },
              ),
            ),
          );
        },
        onNotificationTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => NotificationsScreen(
                onBack: () => Navigator.pop(context),
              ),
            ),
          );
        },
      ),

      // Tab 1: App (Switch back to Customer mode)
      const SizedBox(),

      // Tab 2: Admin Profile
      CustomerProfileScreen(
        userName: 'Admin (Superuser)',
        userBio: 'Loop & Lace System Administrator',
        onMyOrdersTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => VendorManagementScreen(
                onNotificationTap: () {},
              ),
            ),
          );
        },
        onSavedPatternsTap: () {},
        onWishlistTap: () {},
        onAddressesTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AddressListScreen(
                onBack: () => Navigator.pop(context),
              ),
            ),
          );
        },
        onHelpSupportTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => HelpSupportScreen(
                onBack: () => Navigator.pop(context),
              ),
            ),
          );
        },
        onBecomeVendorTap: () {
          Navigator.pop(context);
        },
        onLogoutTap: () {
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
              builder: (context) => const WelcomeScreenWrapper(),
            ),
            (route) => false,
          );
        },
      ),
    ];

    return Scaffold(
      backgroundColor: AppColors.background,
      body: IndexedStack(
        index: _currentTabIndex,
        children: pages,
      ),
      bottomNavigationBar: CustomBottomNav(
        currentIndex: _currentTabIndex,
        onTap: (index) {
          if (index == 1) {
            // "App" tab returns back to Customer Shop
            Navigator.pop(context);
            return;
          }
          setState(() {
            _currentTabIndex = index;
          });
        },
        items: [
          BottomNavItemData(
            icon: Icons.shield_outlined,
            selectedIcon: Icons.shield,
            label: 'Admin',
          ),
          BottomNavItemData(
            icon: Icons.phone_android_outlined,
            selectedIcon: Icons.phone_android,
            label: 'App',
          ),
          BottomNavItemData(
            icon: Icons.person_outline,
            selectedIcon: Icons.person,
            label: 'Me',
          ),
        ],
      ),
    );
  }
}

/// Authentication Navigation Wrapper (Welcome, Login, Sign Up)
class WelcomeScreenWrapper extends StatelessWidget {
  const WelcomeScreenWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return WelcomeScreen(
      onGetStarted: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => SignUpScreen(
              onSignUpSuccess: (role) {
                if (role == AppRole.vendor) {
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const VendorMainShell(),
                    ),
                    (route) => false,
                  );
                } else {
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const CustomerMainShell(),
                    ),
                    (route) => false,
                  );
                }
              },
              onSwitchToLogin: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => LoginScreen(
                      onLoginSuccess: () {
                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const CustomerMainShell(),
                          ),
                          (route) => false,
                        );
                      },
                      onSwitchToSignUp: () => Navigator.pop(context),
                      onBack: () => Navigator.pop(context),
                    ),
                  ),
                );
              },
              onBack: () => Navigator.pop(context),
            ),
          ),
        );
      },
      onAlreadyHaveAccount: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => LoginScreen(
              onLoginSuccess: () {
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const CustomerMainShell(),
                  ),
                  (route) => false,
                );
              },
              onSwitchToSignUp: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => SignUpScreen(
                      onSignUpSuccess: (role) {
                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const CustomerMainShell(),
                          ),
                          (route) => false,
                        );
                      },
                      onSwitchToLogin: () => Navigator.pop(context),
                      onBack: () => Navigator.pop(context),
                    ),
                  ),
                );
              },
              onBack: () => Navigator.pop(context),
            ),
          ),
        );
      },
    );
  }
}
