import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gest_prod_river/providers/item_list_provider.dart';
import 'package:gest_prod_river/screens/listings_overview_screen.dart';
import 'package:gest_prod_river/widgets/add_list_screen/added_item.dart';
import 'package:intl/intl.dart';

import '../models/listing.dart';
import '../widgets/add_list_screen/new_item.dart';

class AddListingScreen extends ConsumerStatefulWidget {
  static const routeName = '/add-listing-screen';

  @override
  AddListingScreenState createState() => AddListingScreenState();
}

class AddListingScreenState extends ConsumerState<AddListingScreen> {
  final _imageUrlController = TextEditingController();
  final _form = GlobalKey<FormState>();

  // current date for calendar
  DateTime _selectedDate = DateTime.now();

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

  // clear the memory regarding the controller
  @override
  void dispose() {
    _imageUrlController.dispose();
    super.dispose();
  }

  // save form method
  Future<void> _saveForm() async {
    setState(() {
      _isLoading = true;
    });
    final isValid = _form.currentState?.validate();
    if (isValid == false || isValid == null) {
      return;
    }
    _form.currentState?.save();
    try {
      //TODO: adding listing to db logic here ->

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
    setState(() {
      _isLoading = false;
    });
  }

  // calendar picker for user
  void _presentDatePicker() {
    showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(2023),
            lastDate: DateTime.now())
        .then((chosenDate) {
      if (chosenDate == null) {
        return;
      } else {
        _selectedDate = chosenDate;
      }
    });
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
              // TODO: move form widget in separate file
              child: Form(
                key: _form,
                // title of the listing that will show in the list
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      TextFormField(
                        autocorrect: false,
                        decoration: InputDecoration(
                            labelText: 'Title',
                            labelStyle: TextStyle(
                                color:
                                    Theme.of(context).colorScheme.secondary)),
                        textInputAction: TextInputAction.next,
                        // gets the introduced string
                        onSaved: (title) {
                          if (title != null) {
                            _tempListing = Listing(
                              id: _tempListing.id,
                              title: title,
                              dateTime: _tempListing.dateTime,
                              amount: _tempListing.amount,
                              itemList: _tempListing.itemList,
                            );
                          }
                        },
                        validator: (value) {
                          if (value == '') {
                            return 'Please provide a value';
                          }
                          return null;
                        },
                      ),
                      // calendar picker for app
                      Container(
                        // color: Colors.red,
                        height: 70,
                        child: Row(
                          children: [
                            Text(_selectedDate == null
                                ? 'No date chosen !'
                                : DateFormat.yMMMd().format(_selectedDate)),
                            MaterialButton(
                              onPressed: _presentDatePicker,
                              child: const Text(
                                'Choose date',
                                style: TextStyle(
                                  color: Colors.amber,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      // here will come the list of items
                      Container(
                        height: (deviceSize.height - kToolbarHeight) / 2,
                        child: ListView.builder(
                          itemBuilder: (context, index) =>
                              AddedItem(itemInfo: itemList[index]),
                          itemCount: itemList.length,
                        ),
                      ),
                      // total amount paid money shown
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                            'Total amount paid money: ${ref.watch(itemListProvider.notifier).getPaidSum()}'),
                      ),
                      // total amount potential win money shown
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                            'Potential money win: ${ref.watch(itemListProvider.notifier).getMarketSum()}'),
                      ),
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
