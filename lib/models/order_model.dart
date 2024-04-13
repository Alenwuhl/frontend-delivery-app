// Order for the backend
class Order {
  final String userId;
  final String email;
  final List<OrderItem> orderItems;
  final double totalAmount;

  Order({
    required this.userId,
    required this.email,
    required this.orderItems,
    required this.totalAmount,
  });

  Order copyWith({
    String? userId,
    String? email,
    List<OrderItem>? orderItems,
    double? totalAmount,
  }) {
    return Order(
      userId: userId ?? this.userId,
      email: email ?? this.email,
      orderItems: orderItems ?? this.orderItems,
      totalAmount: totalAmount ?? this.totalAmount,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'email': email,
      'totalAmount': totalAmount,
      'orderItems': orderItems.map((item) => item.toJson()).toList(),
    };
  }
}

// OrderItem
class OrderItem {
  final String productId;
  final int quantity;
  final List<OrderExtra> extras; 

  OrderItem({
    required this.productId,
    required this.quantity,
    required this.extras,
  });

  Map<String, dynamic> toJson() {
    return {
      'productId': productId,
      'quantity': quantity,
      'extras': extras.map((extra) => extra.toJson()).toList(),
    };
  }
}

// OrderExtra for each item
class OrderExtra {
  final String extraId;
  final String extraTitle;
  final double extraPrice;

  OrderExtra({
    required this.extraId,
    required this.extraTitle,
    required this.extraPrice,
  });

  Map<String, dynamic> toJson() {
    return {
      'extraId': extraId,
      'extraTitle': extraTitle,
      'extraPrice': extraPrice,
    };
  }
}
