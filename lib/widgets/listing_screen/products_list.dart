import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gest_prod_river/providers/listing_list_provider.dart';
import 'package:gest_prod_river/widgets/listing_screen/shimmer_listing.dart';

import 'listing_item.dart';

class ProductsList extends ConsumerStatefulWidget {
  const ProductsList({super.key});

  @override
  ProductsListState createState() => ProductsListState();
}

class ProductsListState extends ConsumerState<ProductsList> {
  bool isLoading = true; // Add isLoading variable

  @override
  void initState() {
    super.initState();
    fetchListings();
  }

  Future<void> fetchListings() async {
    try {
      await ref.read(listingListProvider.notifier).fetchListingsFromDatabase();
    } catch (e) {
      // Handle any errors
      print('Error fetching listings: $e');
    } finally {
      // Set isLoading to false when loading is completed
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    // watch the list changes
    final listingsList = ref.watch(listingListProvider);

    return RefreshIndicator(
      onRefresh: () async => await fetchListings(),
      child: isLoading
          ? ListView.builder(
              itemBuilder: (context, index) => const ShimmerListing(),
              itemCount: 4,
            )
          : listingsList.isEmpty
              ? const Center(
                  child: Text("There are no listings available."),
                )
              : ListView.builder(
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
    );
  }
}
