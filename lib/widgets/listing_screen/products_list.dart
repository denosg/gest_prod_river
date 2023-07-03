import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gest_prod_river/providers/listing_list_provider.dart';

import 'listing_item.dart';

class ProductsList extends ConsumerStatefulWidget {
  const ProductsList({super.key});

  @override
  ProductsListState createState() => ProductsListState();
}

class ProductsListState extends ConsumerState<ProductsList> {
  @override
  void initState() {
    // initialise the state of the listings
    ref.read(listingListProvider.notifier).fetchListingsFromDatabase();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // device sized
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    // watch the list changes
    final listingsList = ref.watch(listingListProvider);

    return RefreshIndicator(
      onRefresh: () async => await ref
          .read(listingListProvider.notifier)
          .fetchListingsFromDatabase(),
      child: Container(
        color: Colors.red,
        height: height,
        width: width,
        child: ListView.builder(
          itemBuilder: (context, index) {
            return ListingItem(
              id: listingsList[index].id,
              title: listingsList[index].title,
              dateTime: listingsList[index].dateTime,
              amount: listingsList[index].amount,
              itemList: listingsList[index].itemList,
            );
          },
          itemCount: listingsList.length,
        ),
      ),
    );
  }
}
