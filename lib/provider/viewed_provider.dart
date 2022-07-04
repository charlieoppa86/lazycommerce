import 'package:flutter/material.dart';
import 'package:lazyclub/models/favor_model.dart';
import 'package:lazyclub/models/viewed_model.dart';

class ViewedProvider with ChangeNotifier {
  Map<String, ViewedModel> _viewedItems = {};

  Map<String, ViewedModel> get getViewedItems {
    return _viewedItems;
  }

  void addProductToHistory({required String productId}) {
    _viewedItems.putIfAbsent(
        productId,
        () => ViewedModel(
              id: DateTime.now().toString(),
              productId: productId,
            ));

    notifyListeners();
  }

  void clearViewedList() {
    _viewedItems.clear();
    notifyListeners();
  }
}
