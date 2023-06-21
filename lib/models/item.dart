class Item {
  final String title;
  final String photoUrl;
  final double pricePaid;
  final double priceMarket;
  final int amountOfItem;

  Item({
    required this.title,
    required this.photoUrl,
    required this.pricePaid,
    required this.priceMarket,
    required this.amountOfItem,
  });

  @override
  String toString() {
    return 'Item: title: $title, photoUrl: $photoUrl, pricePaid: $pricePaid, priceMarket: $priceMarket, amountOfItem: $amountOfItem';
  }
}
