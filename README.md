# Loop & Lace — Crochet Patterns & Handmade Shop

> **Mobile Application Development – Assignment 01**  
> **Institution:** COMSATS University Islamabad, Department of Software Engineering  
> **Submitted by:** Umar Nadeem (FA24-BSE-005), Arbab Jabeen (FA24-BSE-006)  
> **Batch:** Software Engineering, Batch 2024  
> **Date:** October 2026  

---

## 🧶 Overview

**Loop & Lace** is a mobile application frontend built in Flutter that combines crochet patterns, an artisan handmade shop, custom orders, and seller/admin management tools into a unified experience.

The app supports three distinct user roles:
1. **Customer Role** — Browse trending handmade items, follow step-by-step crochet guides, submit custom order requests, manage cart, track active orders, and save favorites.
2. **Vendor Role** — Access the Vendor Studio dashboard, track monthly earnings, publish new listings (products or patterns), and fulfill incoming orders.
3. **Admin Role** — Monitor platform metrics (total sales, orders, active vendors, customers), analyze weekly sales charts, and approve or reject vendor registrations.

---

## 📱 Complete 22 Screen Inventory

All 22 screens specified in the design document have been created:

| # | Screen Name | Role | Description |
|---|-------------|------|-------------|
| **1** | [Welcome Screen](file:///lib/screens/auth/welcome_screen.dart) | All Users | Handmade product collage, cosy tagline, *Get started*, and *I already have an account* buttons. |
| **2** | [Login](file:///lib/screens/auth/login_screen.dart) | All Users | Email & password inputs, password visibility toggle, Log in / Sign up switcher, Google sign-in. |
| **3** | [Sign Up](file:///lib/screens/auth/signup_screen.dart) | All Users | Full name, email, password, and interactive role picker (*Customer* vs *Vendor*). |
| **4** | [Home Screen](file:///lib/screens/customer/customer_home_screen.dart) | Customer | Greeting (*Hello, Arbab ✿*), search bar, Autumn Drop banner, category chips, and trending products. |
| **5** | [Pattern Library](file:///lib/screens/customer/pattern_library_screen.dart) | Customer | Step-by-step guides with difficulty filters (*Beginner*, *Intermediate*, *Advanced*), duration, and prices. |
| **6** | [Pattern Detail (Step 1)](file:///lib/screens/customer/pattern_detail_screen.dart) | Customer | Berry Bunny details, hook size, yarn type, color swatches, and Step 1/12 with Roman Urdu tips. |
| **7** | [Pattern Detail (Step 10)](file:///lib/screens/customer/pattern_detail_screen.dart) | Customer | Advanced step tracker at Step 10/12 (83%) with interactive *Next step* / *Back* navigation. |
| **8** | [Wishlist](file:///lib/screens/customer/wishlist_screen.dart) | Customer | Saved items with maker details, quick *Add to cart* actions, and sale notification reminder. |
| **9** | [Custom Order Request](file:///lib/screens/customer/custom_order_screen.dart) | Customer | Description box, category selector, yarn color swatches, size picker, budget, and needed-by date. |
| **10** | [My Cart](file:///lib/screens/customer/cart_screen.dart) | Customer | Cart item list with quantity controls, subtotal, delivery charges, total, payment options, and *Place order*. |
| **11** | [Order Confirmation](file:///lib/screens/customer/order_confirmation_screen.dart) | Customer | Success checkmark, order summary card for #1043, and links to tracking or continuous shopping. |
| **12** | [My Orders & Tracking](file:///lib/screens/customer/orders_tracking_screen.dart) | Customer | Orders grouped into Active, Delivered, Cancelled with a 4-step progress tracker (*Confirmed → Making → Shipped → Delivered*). |
| **13** | [Notifications](file:///lib/screens/customer/notifications_screen.dart) | Customer | Grouped by *Today* and *Earlier* with unread indicator dots and *Mark all read* functionality. |
| **14** | [Profile (Me)](file:///lib/screens/customer/customer_profile_screen.dart) | Customer | User avatar, name, location, orders, wishlist, saved patterns, and *Become a vendor* shortcut. |
| **15** | [Vendor Studio Dashboard](file:///lib/screens/vendor/vendor_dashboard_screen.dart) | Vendor | Monthly earnings card (Rs 84,500, +18%), stats (42 orders, 12 patterns, 4.8 rating), and recent orders. |
| **16** | [New Listing](file:///lib/screens/vendor/new_listing_screen.dart) | Vendor | Product/Pattern switch, photo uploader, title, category, price, making time, and *Publish listing*. |
| **17** | [Vendor Orders](file:///lib/screens/vendor/vendor_orders_screen.dart) | Vendor | Summary counts (Pending, Making, Shipped) with *Accept*, *Decline*, and *Mark as shipped* buttons. |
| **18** | [Pattern Library (Vendor View)](file:///lib/screens/customer/pattern_library_screen.dart) | Vendor | Pattern library preview for sellers with Vendor bottom navigation bar. |
| **19** | [Vendor Profile (Me)](file:///lib/screens/customer/customer_profile_screen.dart) | Vendor | Vendor account management view with role-specific bottom navigation. |
| **20** | [Admin Panel](file:///lib/screens/admin/admin_panel_screen.dart) | Admin | Owner control panel with 4 metric cards (Rs 1.2M sales, 1,284 orders), weekly sales bar chart, and vendor approvals. |
| **21** | [Vendor Management](file:///lib/screens/admin/vendor_management_screen.dart) | Admin | Searchable and filterable vendor list (*Active*, *Pending*, *Suspended*) with instant approval actions. |
| **22** | [Admin Profile (Me)](file:///lib/screens/customer/customer_profile_screen.dart) | Admin | Admin account view with Admin navigation (*Admin*, *App*, *Me*). |

---

## 🚀 How to Run

### 1. Run on Chrome (Web)
```bash
flutter run -d chrome
```

### 2. Run on Windows Desktop
```bash
flutter run -d windows
```

### 3. Run on Mobile Device or Emulator (Android / iOS)
```bash
flutter run
```

### 4. Run Automated Tests
```bash
flutter test
```

### 5. Check Code Analysis
```bash
flutter analyze
```

---

## 🎨 Design System & Highlights

- **Palette:** Rich burgundy/plum (`#8C254C`), soft sage green (`#5E8D75`), warm cream (`#FAF7F2`), and soft blush (`#F5E4E8`).
- **Typography:** Display serif headings with clean sans-serif body text.
- **Top Role & Screen Switcher:** Allows toggling between *Customer*, *Vendor*, and *Admin* roles, plus a quick **22 Screens** button to jump directly to any screen.
- **Responsive Frame:** On wide screens (web/desktop), the app displays inside a realistic mobile device mockup frame matching the assignment presentation style.
