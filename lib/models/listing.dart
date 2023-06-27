import 'item.dart';

class Listing {
  final String id;
  final String title;
  final DateTime dateTime;
  final int amount;
  final List<Item> itemList;

  Listing({
    required this.id,
    required this.title,
    required this.dateTime,
    required this.amount,
    required this.itemList,
  });

  String printItemList() {
    String itemsInList = '';
    for (var item in itemList) {
      itemsInList = "$itemsInList $item";
    }
    return itemsInList;
  }

  @override
  String toString() {
    return "Listing: id: $id, title: $title, dateTime: $dateTime, amount: $amount"
        "list of items: $printItemList";
  }
}
