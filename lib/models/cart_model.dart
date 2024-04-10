class CartItem {
  final int cartItemId;
  final String productId;
  final String productTitle;
  final String productImageUrl;
  final double productPrice;
  final List<String> selectedExtras;
  final List<String> selectedExtrasTitles;

  CartItem({
    required this.cartItemId,
    required this.productId,
    required this.productTitle,
    required this.productImageUrl,
    required this.productPrice,
    required this.selectedExtras,
    required this.selectedExtrasTitles,
  });

  Map<String, dynamic> toJson() {
    return {
      'cartItemId': cartItemId,
      'productId': productId,
      'productTitle': productTitle,
      'productImageUrl': productImageUrl,
      'productPrice': productPrice,
      'selectedExtras': selectedExtras,
      'selectedExtrasTitles': selectedExtrasTitles,
    };
  }
}
