class TPricingCalculator {
  // Calculate price based on tax and shipping
  static double calculateTotalPrice(double productPrice, String location) {
    double taxRate = getTaxRateForLocation(location);
    double taxAmount = productPrice * taxRate;

    double shippingCost = getShippingCost(location);

    double totalPrice = productPrice + taxAmount + shippingCost;
    return totalPrice;
  }

  // Calculate shipping cost
  static String calculateShippingCost(double productPrice, String location) {
    double shippingCost = getShippingCost(location);
    return shippingCost.toStringAsFixed(2);
  }

  // Calculate tax
  static String calculateTax(double productPrice, String location) {
    double taxRate = getTaxRateForLocation(location);
    double taxAmount = productPrice * taxRate;
    return taxAmount.toStringAsFixed(2);
  }

  static double getTaxRateForLocation(String location) {
    // Retrieves tax rates based on location
    return 0.10; // Example: 10% tax rate
  }

  static double getShippingCost(String location) {
    // Computes shipping costs using factors like location or weight
    return 5.00; // Example shipping cost of 5$
  }

  /// -- Sum all cart values and return total amount
  // static double calculateCartTotal(CartModel cart) {
  //     return cart.items.map((e) => e.price).fold(0,
  //        (previousPrice, currentPrice) => previousPrice + (currentPrice ?? 0));
  // }
}
