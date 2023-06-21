import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gest_prod_river/models/item.dart';

final itemListProvider = StateNotifierProvider<ItemListNotifier, List<Item>>(
    (ref) => ItemListNotifier());

class ItemListNotifier extends StateNotifier<List<Item>> {
  ItemListNotifier() : super([]);

  void addItemInList(Item currentItem) {
    state.insert(0, currentItem);
  }
}
