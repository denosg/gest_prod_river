import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gest_prod_river/models/item.dart';

final itemListProvider = StateNotifierProvider<ItemListNotifier, List<Item>>(
    (ref) => ItemListNotifier());

class ItemListNotifier extends StateNotifier<List<Item>> {
  ItemListNotifier() : super([]);

  void addItemInList(Item currentItem) {
    state.insert(0, currentItem);
  }

  double getPaidSum() {
    double sum = 0.0;
    for (var item in state) {
      sum = sum + item.pricePaid * item.amountOfItem;
    }
    return sum;
  }

  double getMarketSum() {
    double sum = 0.0;
    for (var item in state) {
      sum = sum + item.priceMarket * item.amountOfItem;
    }
    return sum;
  }
}
