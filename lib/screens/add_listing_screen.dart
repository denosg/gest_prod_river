import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gest_prod_river/providers/listing_list_provider.dart';
import 'package:gest_prod_river/widgets/add_list_screen/total_paid.dart';
import 'package:gest_prod_river/widgets/add_list_screen/total_win.dart';

import '../models/item.dart';
import '../models/listing.dart';
import '../widgets/add_list_screen/new_item.dart';
import '/providers/item_list_provider.dart';
import '/screens/listings_overview_screen.dart';
import '/widgets/add_list_screen/added_item.dart';
import '/widgets/add_list_screen/choose_date_form.dart';
import '/widgets/add_list_screen/listing_title_form.dart';

class AddListingScreen extends ConsumerStatefulWidget {
  static const routeName = '/add-listing-screen';

  const AddListingScreen({super.key});

  @override
  AddListingScreenState createState() => AddListingScreenState();
}

class AddListingScreenState extends ConsumerState<AddListingScreen> {
  final _form = GlobalKey<FormState>();

  // loading spinner logic
  var _isLoading = false;

  // temp listing
  // ignore: prefer_final_fields
  var _tempListing = Listing(
    id: '',
    title: '',
    dateTime: DateTime.now(),
    amount: 0,
    itemList: [],
  );

  void isLoading() {
    setState(() {
      _isLoading = !_isLoading;
    });
  }

  // show alert dialog if user didnt provide any items for the listing
  void showAlertDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          elevation: 20,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          title: const Text('There seems to be a problem.',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              )),
          content: const Text('Please provide items for the listing.'),
          // Options for the user regarding the alert dialog
          actions: [
            // YES -> closes the alert dialog
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Ok'),
            )
          ],
        );
      },
    );
  }

  // gets the amount of items in list ->
  int getAmountOfItmes() {
    int amount = 0;
    var itemList = ref.watch(itemListProvider);
    for (Item item in itemList) {
      amount += item.amountOfItem;
    }
    return amount;
  }

  // save form method
  Future<void> _saveForm() async {
    isLoading();
    // check if the form is valid ->
    final isValid = _form.currentState?.validate();
    if (isValid == false || isValid == null) {
      isLoading();
      return;
    }
    // check if the user added any items in the listing ->
    var itemList = ref.watch(itemListProvider);
    if (itemList.isEmpty) {
      // show alert dialog to prompt the user to add items ->
      isLoading();
      showAlertDialog();
      return;
    }
    _form.currentState?.save();
    try {
      // save the item list
      Listing updatedListing = Listing(
        id: _tempListing.id,
        title: _tempListing.title,
        dateTime: _tempListing.dateTime,
        amount: getAmountOfItmes(),
        itemList: itemList,
      );
      //adding listing to cloud db logic here ->
      saveStateOfTextField(updatedListing);
      // adds listing in local memory ->
      ref.read(listingListProvider.notifier).addListingInList(_tempListing);
      // deletes the list from memory to show for the next listing input
      ref.read(itemListProvider.notifier).deleteList();
      //After uploading liting to db, the user is prompted the ListingsScreen
      Navigator.of(context)
          .pushReplacementNamed(ListingsOverviewScreen.routeName);
    } catch (error) {
      await showDialog<void>(
          context: context,
          builder: (ctx) => AlertDialog(
                title: const Text('An error occured'),
                content: const Text('Something went wrong'),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.of(ctx).pop();
                    },
                    child: const Text('Okay'),
                  ),
                ],
              ));
    }
    isLoading();
  }

  // modal bottoom sheet when entering new item in the list
  void _startAddNewItem(BuildContext context) {
    showModalBottomSheet(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      context: context,
      builder: (context) => const NewItem(),
    );
  }

  void saveStateOfTextField(Listing updatedListing) {
    setState(() {
      _tempListing =
          updatedListing; // Update _tempListing with the updatedListing from MyTextForm
    });
  }

  @override
  Widget build(BuildContext context) {
    //get the device size
    final deviceSize = MediaQuery.of(context).size;
    // list of items
    var itemList = ref.watch(itemListProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Listing'),
        actions: [
          IconButton(onPressed: _saveForm, icon: const Icon(Icons.save))
        ],
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.all(10),
              child: Form(
                key: _form,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      // title of the listing that will show in the list
                      ListingTitleForm(
                          onSave: saveStateOfTextField, listing: _tempListing),
                      // calendar picker for app
                      ChooseDateForm(
                          listing: _tempListing, onSave: saveStateOfTextField),
                      // here will come the list of items
                      SizedBox(
                        height: (deviceSize.height - kToolbarHeight) / 2,
                        child: ListView.builder(
                          itemBuilder: (context, index) =>
                              AddedItem(itemInfo: itemList[index]),
                          itemCount: itemList.length,
                        ),
                      ),
                      // total amount paid money shown
                      const TotalPaid(),
                      // total amount potential win money shown
                      const TotalWin(),
                    ],
                  ),
                ),
              ),
            ),
      floatingActionButton: ElevatedButton(
        // pressing the button shows the modal bottom sheet for adding a new item
        onPressed: () => _startAddNewItem(context),
        child: const Text('Add new item'),
      ),
    );
  }
}
