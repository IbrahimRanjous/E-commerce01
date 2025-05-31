import 'package:rjs_store/core/product_model.dart';

class StoredDataParser {
  /// Extracts the complete list of ProductModel objects from stored data.
  static List<ProductModel> getProducts(Map<String, dynamic> storedData) {
    final List<dynamic>? storedProductsList =
        storedData['Products'] as List<dynamic>?;
    return storedProductsList != null
        ? storedProductsList
            .map((e) => ProductModel.fromJson(e as Map<String, dynamic>))
            .toList()
        : [];
  }

  /// Returns the favorite list (list of product objectIds) from stored data.
  static List<String> getFavoriteListOfObjectId(
      Map<String, dynamic> storedData) {
    final List<dynamic>? favListDynamic =
        storedData['FavoriteList'] as List<dynamic>?;
    return favListDynamic != null ? List<String>.from(favListDynamic) : [];
  }

  /// Returns the list of favorite ProductModel objects by filtering products.
  static List<ProductModel> getFavoriteProducts(
      Map<String, dynamic> storedData) {
    final products = getProducts(storedData);
    final favoriteList = getFavoriteListOfObjectId(storedData);
    return products
        .where((product) => favoriteList.contains(product.objectId))
        .toList();
  }
}
