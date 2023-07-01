import 'package:firebase_database/firebase_database.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gest_prod_river/models/listing.dart';

final listingListProvider =
    StateNotifierProvider<ListingListNotifier, List<Listing>>(
        (ref) => ListingListNotifier());

class ListingListNotifier extends StateNotifier<List<Listing>> {
  ListingListNotifier() : super([]);

  // find listing by id method ->
  Listing findById(String id) {
    return state.firstWhere((listing) => listing.id == id);
  }

  // method for fetching the listings from the Firebase Cloud Database

  // method for adding the listing in firebase cloud db + in local memory ->
  void addListingInList(Listing currentListing) async {
    DatabaseReference databaseRef =
        FirebaseDatabase.instance.ref().child('listings');

    DatabaseReference newListingRef = databaseRef.push();
    String itemId = newListingRef.key!;

    //json data to send to cloud db ->
    Map<String, dynamic> newListingData = {
      'id': itemId,
      'title': currentListing.title,
      'dateTime': currentListing.dateTime.toIso8601String(),
      'amount': currentListing.amount,
      'items': currentListing.itemList
          .map((item) => {
                'title': item.title,
                'photoUrl': item.photoUrl,
                'pricePaid': item.pricePaid,
                'priceMarket': item.priceMarket,
                'amount': item.amountOfItem,
              })
          .toList(),
    };

    try {
      await newListingRef.set(newListingData);
      print('Listing added to Firebase successfully!');

      // Update the state object of currentListing
      Listing updatedListing = Listing(
        id: itemId, // Update the ID with the newly generated key
        title: currentListing.title,
        dateTime: currentListing.dateTime,
        amount: currentListing.amount,
        itemList: currentListing.itemList,
      );
      //adding the listing locally in the memory
      final updatedList = [...state];
      updatedList.insert(0, updatedListing);
      state = updatedList;

      print('Listing added in list with updated state object.');
    } catch (error) {
      print('Failed to add listing to Firebase: $error');
    }
  }

  // deleteListing method for deleting a specific listing from cloud db + local memory ->
  void deleteListing(String id) async {
    DatabaseReference databaseRef =
        FirebaseDatabase.instance.ref().child('listings');

    // Find the index of the listing with the given ID in the state
    int listingIndex = state.indexWhere((listing) => listing.id == id);

    if (listingIndex != -1) {
      try {
        // Delete the listing from the Firebase Cloud Database
        await databaseRef.child(id).remove();
        print('Listing deleted from Firebase successfully!');

        // Remove the listing from the local memory state
        final updatedList = [...state];
        updatedList.removeAt(listingIndex);
        state = updatedList;

        print('Listing deleted from local memory state.');
      } catch (error) {
        print('Failed to delete listing from Firebase: $error');
      }
    }
  }
}
