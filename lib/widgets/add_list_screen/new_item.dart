import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gest_prod_river/providers/item_list_provider.dart';

import '../../models/item.dart';
import 'new_item_text_forms/amount_item_form.dart';
import 'new_item_text_forms/image_url_form.dart';
import 'new_item_text_forms/price_market_form.dart';
import 'new_item_text_forms/price_paid_form.dart';
import 'new_item_text_forms/title_form.dart';

class NewItem extends ConsumerStatefulWidget {
  const NewItem({super.key});

  @override
  NewItemState createState() => NewItemState();
}

class NewItemState extends ConsumerState<NewItem> {
  final _modalFormKey = GlobalKey<FormState>();

  var _tempItem = Item(
      title: '', photoUrl: '', pricePaid: 0, priceMarket: 0, amountOfItem: 0);

  void saveStateOfTextField(Item updatedItem) {
    setState(() {
      _tempItem =
          updatedItem; // Update _tempItem with the updatedItem from MyTextForm
    });
  }

  // show alert dialog if user didnt provide an image
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
          content: const Text('Please provide an image.'),
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

  Future<void> _saveForm() async {
    final isValid = _modalFormKey.currentState?.validate();
    if (isValid == false || isValid == null) {
      return;
    }
    // verifies if user uploaded image or not, if NOT the user will be prompted to please upload a picture
    if (_tempItem.photoUrl == '') {
      showAlertDialog();
      return;
    }
    _modalFormKey.currentState?.save();
    try {
      //add item in list method ->
      ref.read(itemListProvider.notifier).addItemInList(_tempItem);
    } catch (e) {
      rethrow;
    }
    print('ItemInfo: ${_tempItem.toString()}');
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
          top: 10,
          left: 10,
          right: 10,
          bottom: MediaQuery.of(context).viewInsets.bottom + 10),
      child: Form(
        key: _modalFormKey,
        child: ListView(
          children: [
            // title of particular item
            TitleForm(tempItem: _tempItem, onSave: saveStateOfTextField),
            // image picker + show after the image has been uploaded
            ImageUrlForm(tempItem: _tempItem, onSave: saveStateOfTextField),
            // price paid for the item / price that we will put the item for
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                // price paid for the item
                PricePaidForm(
                    tempItem: _tempItem, onSave: saveStateOfTextField),
                // price that we will put the item for on the market
                PriceMarketForm(
                    tempItem: _tempItem, onSave: saveStateOfTextField),
              ],
            ),
            // amount of the item
            const SizedBox(height: 20),
            AmountItemForm(tempItem: _tempItem, onSave: saveStateOfTextField),
            // Save button
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _saveForm,
              child: const Text('Save'),
            ),
          ],
        ),
      ),
    );
  }
}
