
import 'package:flutter/material.dart';

import '../../../models/item.dart';

class PriceMarketForm extends StatefulWidget {
  final Item tempItem;
  final Function(Item) onSave;

  const PriceMarketForm({required this.tempItem, required this.onSave});

  @override
  State<PriceMarketForm> createState() => _PriceMarketFormState();
}

class _PriceMarketFormState extends State<PriceMarketForm> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Container(
      width: width * 0.4,
      height: height * 0.07,
      padding: EdgeInsets.all(width * 0.03),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(6), color: Colors.orange[300]),
      child: Center(
        child: Row(
          children: <Widget>[
            const Icon(
              Icons.attach_money,
              color: Colors.black54,
            ),
            SizedBox(
              width: width * 0.04,
            ),
            Expanded(
              child: TextFormField(
                autocorrect: false,
                decoration: const InputDecoration.collapsed(
                  hintText: 'Price Sell',
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
                      pricePaid: widget.tempItem.pricePaid,
                      priceMarket: double.parse(enteredString),
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
