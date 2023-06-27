import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gest_prod_river/models/listing.dart';

final listingListProvider =
    StateNotifierProvider<ListingListNotifier, List<Listing>>(
        (ref) => ListingListNotifier());

class ListingListNotifier extends StateNotifier<List<Listing>> {
  ListingListNotifier() : super([]);

  void addListingInList(Listing currentListing) {
    print('Listing added in list.');
    final updatedList = [...state];
    updatedList.insert(0, currentListing);
    state = updatedList;
  }
}
