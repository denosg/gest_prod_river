import 'item.dart';

class Listing {
  final String id;
  final String title;
  final DateTime dateTime;
  final double amount;
  final List<Item> itemList;

  Listing({
    required this.id,
    required this.title,
    required this.dateTime,
    required this.amount,
    required this.itemList,
  });
}
