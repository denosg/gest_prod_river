import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'listing_item.dart';

class ProductsList extends ConsumerStatefulWidget {
  const ProductsList({super.key});

  @override
  ProductsListState createState() => ProductsListState();
}

class ProductsListState extends ConsumerState<ProductsList> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: (context, index) {
        // TODO: gonna build each product item based on the List<Listings> with each id from firebase
        return ListingItem(
          id: 'asjkldas',
          title: 'test',
          dateTime: DateTime.now(),
          amount: 100,
        );
      },
      itemCount: 1,
    );
  }
}
