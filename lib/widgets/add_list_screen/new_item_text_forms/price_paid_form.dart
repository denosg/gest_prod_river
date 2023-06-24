
import 'package:flutter/material.dart';

import '../../../models/item.dart';

class PricePaidForm extends StatefulWidget {
  final Item tempItem;
  final Function(Item) onSave;

  const PricePaidForm({required this.tempItem, required this.onSave});

  @override
  State<PricePaidForm> createState() => _PricePaidFormState();
}

class _PricePaidFormState extends State<PricePaidForm> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Container(
      width: width * 0.4,
      height: height * 0.07,
      padding: EdgeInsets.all(width * 0.03),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(6), color: Colors.green[300]),
      child: Center(
        child: Row(
          children: <Widget>[
            const Icon(
              Icons.handshake,
              color: Colors.black54,
            ),
            SizedBox(
              width: width * 0.04,
            ),
            Expanded(
              child: TextFormField(
                autocorrect: false,
                decoration: const InputDecoration.collapsed(
                  hintText: 'Price Paid',
                  hintStyle: TextStyle(color: Colors.black54),
                ),
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.number,
                // gets the introduced string
                onChanged: (enteredString) {
                  if (enteredString != '') {
                    Item updatedItem = Item(
                      title: widget.tempItem.title,
                      photoUrl: widget.tempItem.photoUrl,
                      pricePaid: double.parse(enteredString),
                      priceMarket: widget.tempItem.priceMarket,
                      amountOfItem: widget.tempItem.amountOfItem,
                    );

                    widget.onSave(updatedItem);
                  }
                },
                validator: (value) {
                  if (value == '') {
                    return 'Please enter the money';
                  }
                  if (value != null) {
                    if (int.tryParse(value) == null) {
                      return 'Please enter a valid number';
                    }
                  }
                  if (value != null) {
                    if (int.parse(value) <= 0) {
                      return 'Please enter a number > 0';
                    }
                  }
                  return null;
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
