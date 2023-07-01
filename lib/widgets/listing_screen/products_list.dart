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
  Widget build(BuildContext context) {
    // watch the list changes
    final listingsList = ref.watch(listingListProvider);

    return FutureBuilder(
      future:
          ref.read(listingListProvider.notifier).fetchListingsFromDatabase(),
      builder: (context, snapshot) =>
          snapshot.connectionState == ConnectionState.active
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : RefreshIndicator(
                  onRefresh: () async => ref
                      .read(listingListProvider.notifier)
                      .fetchListingsFromDatabase(),
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
