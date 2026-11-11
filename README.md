# Loop & Lace — Crochet Patterns & Handmade Artisan Shop

> **Mobile Application Development – Assignment 01**  
> **Institution:** COMSATS University Islamabad, Department of Software Engineering  
> **Group Members:**  
> - **Umar Nadeem** (FA24-BSE-005) — [@umarnadeem-dev](https://github.com/umarnadeem-dev)  
> - **Arbab Jabeen** (FA24-BSE-006) — [@arbabjabeen](https://github.com/arbabjabeen)  
> **Batch:** Software Engineering, Batch 2024  
> **Tech Stack:** Flutter 3.x, Dart 3.x, Material Design 3  

---

## 🧶 Overview

**Loop & Lace** is an artisan mobile marketplace and crochet crafting platform tailored for the Pakistani handicraft and maker community (*"Apna color & size bataiye, maker bana dega"*). It brings together crochet enthusiasts, independent handmade artisans, and platform administrators into a cohesive mobile ecosystem.

The application supports three distinct user roles:
1. **Customer Experience** — Discover trending handmade crochet goods, follow step-by-step crochet patterns with localized Roman Urdu tips, request bespoke custom crochet pieces, manage cart with delivery options, track live courier shipments, write verified reviews, and manage multiple delivery addresses.
2. **Vendor Studio** — An artisan dashboard tracking monthly earnings, order statuses (*Pending*, *Making*, *Shipped*), full catalog inventory management (physical goods vs. digital patterns), fast price/stock editing, and publishing new handmade listings.
3. **Admin Control Panel** — Platform-wide overview tracking total revenue, order volume, active vendors, weekly sales volume visualizations, and vendor verification/approval workflows.

---

## 📱 Application Screen Architecture

The application frontend is structured into modular roles and interconnected screens:

### 1. Authentication & Onboarding
- **Welcome Screen** ([`welcome_screen.dart`](lib/screens/auth/welcome_screen.dart)) — Artisanal showcase banner, branding tagline, and authentication entry points.
- **Login Screen** ([`login_screen.dart`](lib/screens/auth/login_screen.dart)) — Email & password sign-in, password visibility toggle, role switching, and social sign-in simulation.
- **Sign Up Screen** ([`signup_screen.dart`](lib/screens/auth/signup_screen.dart)) — Account registration with role selection (*Customer* vs. *Vendor Studio*).

### 2. Customer Shop & Patterns
- **Home Screen** ([`customer_home_screen.dart`](lib/screens/customer/customer_home_screen.dart)) — Personalized greeting (*Hello, Arbab ✿*), real-time search, seasonal promotional drop banner, category filtering (*Amigurumi, Wearables, Blankets, Bags*), trending creations, and direct custom order prompt.
- **Autumn Drop Collection** ([`collection_explore_screen.dart`](lib/screens/customer/collection_explore_screen.dart)) — Curated seasonal edit (*Granny squares are back*) showcasing handmade wearables, bags, and matching patterns.
- **Pattern Library** ([`pattern_library_screen.dart`](lib/screens/customer/pattern_library_screen.dart)) — Curated digital patterns with difficulty badges (*Beginner*, *Intermediate*, *Advanced*), hook sizes, estimated crafting times, and pricing.
- **Interactive Pattern & Product Detail** ([`pattern_detail_screen.dart`](lib/screens/customer/pattern_detail_screen.dart)) — Product specs, palette swatches, direct cart addition, and an interactive 12-step crochet guide with progress tracking and localized Roman Urdu tips.
- **Artisan Public Storefront** ([`vendor_profile_view_screen.dart`](lib/screens/customer/vendor_profile_view_screen.dart)) — Public maker profile featuring artisan bio, verified badge, ratings, physical creations, digital patterns, customer reviews, and direct custom order requests.
- **Wishlist** ([`wishlist_screen.dart`](lib/screens/customer/wishlist_screen.dart)) — Saved handmade pieces with quick add-to-cart actions.

### 3. Cart, Checkout & Orders
- **Shopping Cart** ([`cart_screen.dart`](lib/screens/customer/cart_screen.dart)) — Dynamic cart items with quantity adjustment, item removal, subtotal calculation, delivery fees, and checkout progression.
- **Checkout Screen** ([`checkout_screen.dart`](lib/screens/customer/checkout_screen.dart)) — Delivery address picker modal, shipping speed choices (*Standard Courier* vs. *Express Maker Dispatch*), payment method selection (*COD*, *JazzCash/EasyPaisa*, *Debit/Credit Card*), maker gift notes, and promo code support (`LOOP10`).
- **Order Confirmation** ([`order_confirmation_screen.dart`](lib/screens/customer/order_confirmation_screen.dart)) — Order summary, order ID tracking badge, and direct pathways to live tracking or continuous browsing.
- **Orders List & Filter** ([`orders_tracking_screen.dart`](lib/screens/customer/orders_tracking_screen.dart)) — Tabbed order history (*Active*, *Delivered*, *Cancelled*) with stepper indicators and review triggers.
- **Live Order Details & Logistics Timeline** ([`order_detail_screen.dart`](lib/screens/customer/order_detail_screen.dart)) — 4-stage tracking timeline (*Ordered → Making → Shipped → Delivered*), Trax tracking number, itemized pricing, maker direct message button, and PDF invoice receipt generation.
- **Write Review & Rating** ([`write_review_screen.dart`](lib/screens/customer/write_review_screen.dart)) — Interactive 5-star rating, craft praise chips (*Neat Stitches*, *Soft Combed Yarn*, *Heirloom Quality*), feedback notes, customer photo upload simulation, and public/anonymous posting toggle.
- **Bespoke Custom Orders Tracker** ([`custom_orders_list_screen.dart`](lib/screens/customer/custom_orders_list_screen.dart)) — Dashboard tracking custom requests, maker quotes (*Reviewing*, *Quote Ready*, *In Making*), budget estimates, and *Accept & Pay* triggers.
- **Custom Order Request Form** ([`custom_order_screen.dart`](lib/screens/customer/custom_order_screen.dart)) — Bespoke item request form with color swatches, yarn type, sizing, reference photo attachments, and deadline date selection.

### 4. Account Management & Support
- **Customer Profile (Me)** ([`customer_profile_screen.dart`](lib/screens/customer/customer_profile_screen.dart)) — Account avatar, location, quick navigation to orders, saved patterns, wishlist, addresses, vendor onboarding, and customer support.
- **Saved Addresses Book** ([`address_list_screen.dart`](lib/screens/customer/address_list_screen.dart)) — Management interface for delivery addresses (*Home*, *Studio*, *Work*) across major Pakistani cities with add, edit, delete, and default toggles.
- **Edit Profile** ([`edit_profile_screen.dart`](lib/screens/customer/edit_profile_screen.dart)) — Edit name, bio, craft skill level (*Beginner*, *Intermediate*, *Advanced Crafter*), city selector, and favorite craft projects.
- **Help & Support Center** ([`help_support_screen.dart`](lib/screens/customer/help_support_screen.dart)) — Searchable accordion FAQs (custom orders, shipping across Pakistan, Roman Urdu abbreviations, delicate yarn hand-washing care), one-tap WhatsApp support, and direct ticket submission.
- **Notifications Screen** ([`notifications_screen.dart`](lib/screens/customer/notifications_screen.dart)) — Activity feed for maker updates, custom order quotes, and seasonal promotions.

### 5. Vendor Studio (Artisan Role)
- **Vendor Dashboard** ([`vendor_dashboard_screen.dart`](lib/screens/vendor/vendor_dashboard_screen.dart)) — Monthly revenue hero card (*Rs 84,500, +18%*), quick stat badges (*Orders*, *Catalog*, *Rating*), new listing shortcuts, and recent order stream.
- **Vendor Catalog & Inventory** ([`vendor_listings_screen.dart`](lib/screens/vendor/vendor_listings_screen.dart)) — Inventory management for physical creations and digital patterns with quick modal edits for titles and pricing.
- **Vendor Orders** ([`vendor_orders_screen.dart`](lib/screens/vendor/vendor_orders_screen.dart)) — Order lifecycle actions (*Accept*, *Decline*, *Mark as shipped*) and drilldown into full order invoices.
- **New Listing Publisher** ([`new_listing_screen.dart`](lib/screens/vendor/new_listing_screen.dart)) — Creation wizard for physical goods or patterns with photo uploaders, categories, prices, yarn types, and hook sizes.

### 6. Admin Panel (Platform Owner Role)
- **Admin Analytics Panel** ([`admin_panel_screen.dart`](lib/screens/admin/admin_panel_screen.dart)) — Metrics grid (*Total Sales Rs 1.2M*, *1,284 Orders*, *Active Vendors*, *Customers*), weekly sales performance bar chart, and vendor approval workflow cards.
- **Vendor Verification & Management** ([`vendor_management_screen.dart`](lib/screens/admin/vendor_management_screen.dart)) — Searchable vendor directory filterable by status (*Active*, *Pending*, *Suspended*) with approval/rejection controls.

---

## 🎨 Design System & Palette

- **Primary Brand (Plum / Berry):** `#8C254C` — Represents warmth and craft tradition.
- **Accent (Sage Green):** `#5E8D75` — Represents organic cotton yarn and natural fibers.
- **Background & Surfaces:** Warm off-white `#FAF7F2` and `#FFFFFF` with soft borders `#EAE2DC`.
- **Soft Highlights:** Blush `#F5E4E8` and Peach `#F9D8CE`.
- **Typography:** Serif display headings (`Georgia`) paired with clean sans-serif body typography (`Segoe UI` / `Outfit`).

---

## 👥 Group Contributions Breakdown

Both team members contributed equally to the architecture, design, and code implementation of the project:

| Member | GitHub Username | Key Contributions & Modules Owned |
|---|---|---|
| **Umar Nadeem** | [`@umarnadeem-dev`](https://github.com/umarnadeem-dev) | - Core App Architecture & Theme System ([`main.dart`](lib/main.dart), [`app_theme.dart`](lib/theme/app_theme.dart))<br>- Customer Discovery & Home Screen ([`customer_home_screen.dart`](lib/screens/customer/customer_home_screen.dart))<br>- Pattern Library & Interactive Step Guide ([`pattern_detail_screen.dart`](lib/screens/customer/pattern_detail_screen.dart))<br>- Shopping Cart & Checkout System ([`checkout_screen.dart`](lib/screens/customer/checkout_screen.dart))<br>- Real-time Order Tracking & Invoice Breakdown ([`order_detail_screen.dart`](lib/screens/customer/order_detail_screen.dart))<br>- Custom Order Quotes Tracker ([`custom_orders_list_screen.dart`](lib/screens/customer/custom_orders_list_screen.dart)) |
| **Arbab Jabeen** | [`@arbabjabeen`](https://github.com/arbabjabeen) | - Authentication & Onboarding Flow ([`welcome_screen.dart`](lib/screens/auth/welcome_screen.dart), [`login_screen.dart`](lib/screens/auth/login_screen.dart), [`signup_screen.dart`](lib/screens/auth/signup_screen.dart))<br>- Vendor Studio Dashboard & Fulfillments ([`vendor_dashboard_screen.dart`](lib/screens/vendor/vendor_dashboard_screen.dart), [`vendor_orders_screen.dart`](lib/screens/vendor/vendor_orders_screen.dart))<br>- Vendor Catalog & Inventory Manager ([`vendor_listings_screen.dart`](lib/screens/vendor/vendor_listings_screen.dart))<br>- Admin Analytics & Vendor Verification ([`admin_panel_screen.dart`](lib/screens/admin/admin_panel_screen.dart), [`vendor_management_screen.dart`](lib/screens/admin/vendor_management_screen.dart))<br>- Delivery Address Book & Profile Management ([`address_list_screen.dart`](lib/screens/customer/address_list_screen.dart), [`edit_profile_screen.dart`](lib/screens/customer/edit_profile_screen.dart))<br>- Help & Support Center with FAQs ([`help_support_screen.dart`](lib/screens/customer/help_support_screen.dart)) |

---

## 🚀 How to Run the Project

### 1. Clone the Shared Repository
```bash
git clone https://github.com/umarnadeem-dev/loop_and_lace.git
cd loop_and_lace
```

### 2. Install Dependencies
```bash
flutter pub get
```

### 3. Verify Code Analysis
```bash
flutter analyze
```
*(Expected output: `No issues found!`)*

### 4. Run the Application
- **On Chrome (Web):**
  ```bash
  flutter run -d chrome
  ```
- **On Windows Desktop:**
  ```bash
  flutter run -d windows
  ```
- **On Mobile Emulator / Device:**
  ```bash
  flutter run
  ```

### 5. Run Automated Tests
```bash
flutter test
```
