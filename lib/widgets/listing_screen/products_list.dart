import 'package:flutter/material.dart';

import 'product_item.dart';

class ProductsList extends StatelessWidget {
  const ProductsList({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: (context, index) {
        // TODO: gonna build each product item based on the List<Listings> with each id from firebase
        return ProductItem(
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
