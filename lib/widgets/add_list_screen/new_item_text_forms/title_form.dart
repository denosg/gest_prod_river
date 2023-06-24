
import 'package:flutter/material.dart';

import '../../../models/item.dart';

class TitleForm extends StatefulWidget {
  final Item tempItem;
  final Function(Item) onSave;

  const TitleForm({required this.tempItem, required this.onSave});

  @override
  State<TitleForm> createState() => _TitleFormState();
}

class _TitleFormState extends State<TitleForm> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Container(
      width: width * 0.8,
      height: height * 0.07,
      padding: EdgeInsets.all(width * 0.03),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(6), color: Colors.grey[300]),
      child: Center(
        child: Row(
          children: <Widget>[
            const Icon(
              Icons.title,
              color: Colors.black54,
            ),
            SizedBox(
              width: width * 0.04,
            ),
            Expanded(
              child: TextFormField(
                autocorrect: false,
                decoration: const InputDecoration.collapsed(
                  hintText: 'Item Title',
                  hintStyle: TextStyle(color: Colors.black54),
                ),
                textInputAction: TextInputAction.next,
                autofocus: true,
                // gets the introduced string
                onChanged: (enteredString) {
                  if (enteredString != '') {
                    Item updatedItem = Item(
                      title: enteredString,
                      photoUrl: widget.tempItem.photoUrl,
                      pricePaid: widget.tempItem.pricePaid,
                      priceMarket: widget.tempItem.priceMarket,
                      amountOfItem: widget.tempItem.amountOfItem,
                    );

                    widget.onSave(updatedItem);
                  }
                },
                validator: (value) {
                  if (value == '') {
                    return 'Please provide a value';
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
