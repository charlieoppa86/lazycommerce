import 'package:flutter/material.dart';
import 'package:lazyclub/models/favor_model.dart';

class FavorProvider with ChangeNotifier {
  Map<String, FavorModel> _favorItems = {};

  Map<String, FavorModel> get getFavorItems {
    return _favorItems;
  }

  void addRemoveProductToFavor({required String productId}) {
    if (_favorItems.containsKey(productId)) {
      _favorItems.remove(productId);
    } else {
      _favorItems.putIfAbsent(
          productId,
          () => FavorModel(
                id: DateTime.now().toString(),
                productId: productId,
              ));
    }
    notifyListeners();
  }

  void removeOneItem(String productId) {
    _favorItems.remove(productId);
    notifyListeners();
  }

  void clearFavorList() {
    _favorItems.clear();
    notifyListeners();
  }
}
