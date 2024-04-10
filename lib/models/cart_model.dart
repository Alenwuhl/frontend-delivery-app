class CartItem {
  final int cartItemId;
  final String productId;
  final String productTitle;
  final String productImageUrl;
  final double productPrice;
  final List<String> selectedExtras;
  final List<String> selectedExtrasTitles;
  final List<double> selectedExtrasPrices;
  double cartItemPrice;
  int quantity;
  

  CartItem({
    required this.cartItemId,
    required this.productId,
    required this.productTitle,
    required this.productImageUrl,
    required this.productPrice,
    required this.selectedExtras,
    required this.selectedExtrasTitles,
    required this.selectedExtrasPrices,
    this.quantity = 1,
  }) : cartItemPrice = (productPrice +
                selectedExtrasPrices.fold(
                    0.0, (sum, extraPrice) => sum + extraPrice)) *
            quantity;

  void updatePrice() {
    cartItemPrice = (productPrice +
            selectedExtrasPrices.fold(
                0.0, (sum, extraPrice) => sum + extraPrice)) *
        quantity;
        
  }

  Map<String, dynamic> toJson() {
    return {
      'cartItemId': cartItemId,
      'productId': productId,
      'productTitle': productTitle,
      'productImageUrl': productImageUrl,
      'productPrice': productPrice,
      'selectedExtras': selectedExtras,
      'selectedExtrasTitles': selectedExtrasTitles,
      'selectedExtrasPrices': selectedExtrasPrices,
      'cartItemPrice': cartItemPrice,
      'quantity': quantity,
    };
  }
}
