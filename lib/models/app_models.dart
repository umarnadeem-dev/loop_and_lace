class ProductItem {
  final String id;
  final String title;
  final String maker;
  final int price;
  final double rating;
  final int reviewsCount;
  final String imagePath;
  final String category;
  final String hookSize;
  final String yarnType;
  final String difficulty;
  final bool isPattern;
  bool isFavorite;

  ProductItem({
    required this.id,
    required this.title,
    required this.maker,
    required this.price,
    required this.rating,
    required this.reviewsCount,
    required this.imagePath,
    required this.category,
    this.hookSize = '3.5 mm',
    this.yarnType = 'Cotton DK',
    this.difficulty = 'Beginner',
    this.isPattern = false,
    this.isFavorite = false,
  });
}

class PatternStep {
  final int stepNumber;
  final int totalSteps;
  final String instruction;
  final String tipUrdu;

  PatternStep({
    required this.stepNumber,
    required this.totalSteps,
    required this.instruction,
    required this.tipUrdu,
  });

  int get progressPercent => ((stepNumber / totalSteps) * 100).round();
}

class CartItem {
  final ProductItem product;
  int quantity;
  String selectedColor;

  CartItem({
    required this.product,
    this.quantity = 1,
    this.selectedColor = 'Blush Pink',
  });

  int get totalPrice => product.price * quantity;
}

enum OrderStatus { pending, making, shipped, delivered, cancelled }

class OrderItem {
  final String orderId;
  final String dateText;
  final List<String> itemNames;
  final String primaryImage;
  final int totalAmount;
  OrderStatus status;
  final String buyerName;
  final String city;

  OrderItem({
    required this.orderId,
    required this.dateText,
    required this.itemNames,
    required this.primaryImage,
    required this.totalAmount,
    required this.status,
    required this.buyerName,
    required this.city,
  });

  String get statusLabel {
    switch (status) {
      case OrderStatus.pending:
        return 'Pending';
      case OrderStatus.making:
        return 'Making';
      case OrderStatus.shipped:
        return 'Shipped';
      case OrderStatus.delivered:
        return 'Delivered';
      case OrderStatus.cancelled:
        return 'Cancelled';
    }
  }
}

class AppNotificationItem {
  final String id;
  final String title;
  final String subtitle;
  final String timeAgo;
  final String type; // 'order', 'promo', 'custom'
  bool isRead;

  AppNotificationItem({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.timeAgo,
    required this.type,
    this.isRead = false,
  });
}

class VendorItem {
  final String id;
  final String name;
  final String avatarLetter;
  final double rating;
  final int totalOrders;
  String status; // 'Active', 'Pending', 'Suspended'
  final String? bio;
  final String? location;
  final int? reviewsCount;

  VendorItem({
    required this.id,
    required this.name,
    required this.avatarLetter,
    required this.rating,
    required this.totalOrders,
    required this.status,
    this.bio,
    this.location = 'Lahore, Pakistan',
    this.reviewsCount = 128,
  });
}

class AddressItem {
  final String id;
  final String label; // 'Home', 'Studio', 'Work'
  final String recipientName;
  final String phone;
  final String streetAddress;
  final String area;
  final String city;
  final String postalCode;
  bool isDefault;

  AddressItem({
    required this.id,
    required this.label,
    required this.recipientName,
    required this.phone,
    required this.streetAddress,
    required this.area,
    required this.city,
    this.postalCode = '54000',
    this.isDefault = false,
  });

  String get fullAddress => '$streetAddress, $area, $city';
}

class ReviewItem {
  final String id;
  final String userName;
  final double rating;
  final String dateText;
  final String comment;
  final List<String> tags;
  final String? productTitle;

  ReviewItem({
    required this.id,
    required this.userName,
    required this.rating,
    required this.dateText,
    required this.comment,
    required this.tags,
    this.productTitle,
  });
}

enum CustomRequestStatus { reviewing, quoteSent, inProgress, completed, declined }

class CustomRequestItem {
  final String id;
  final String title;
  final String description;
  final String category;
  final String colorHex;
  final String colorName;
  final String size;
  final String estimatedBudget;
  final String requestedDeadline;
  final String makerName;
  final String dateSubmitted;
  CustomRequestStatus status;
  final int? quotedPrice;

  CustomRequestItem({
    required this.id,
    required this.title,
    required this.description,
    required this.category,
    required this.colorHex,
    required this.colorName,
    required this.size,
    required this.estimatedBudget,
    required this.requestedDeadline,
    required this.makerName,
    required this.dateSubmitted,
    required this.status,
    this.quotedPrice,
  });

  String get statusLabel {
    switch (status) {
      case CustomRequestStatus.reviewing:
        return 'Reviewing';
      case CustomRequestStatus.quoteSent:
        return 'Quote Ready';
      case CustomRequestStatus.inProgress:
        return 'In Making';
      case CustomRequestStatus.completed:
        return 'Completed';
      case CustomRequestStatus.declined:
        return 'Declined';
    }
  }
}

