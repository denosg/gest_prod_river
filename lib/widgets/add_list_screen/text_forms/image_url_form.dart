import 'package:flutter/material.dart';

import '../../../models/item.dart';

class ImageUrlForm extends StatefulWidget {
  final Item tempItem;
  final Function(Item) onSave;

  const ImageUrlForm({required this.tempItem, required this.onSave});

  @override
  State<ImageUrlForm> createState() => _ImageUrlFormState();
}

class _ImageUrlFormState extends State<ImageUrlForm> {
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
              Icons.image,
              color: Colors.black54,
            ),
            SizedBox(
              width: width * 0.04,
            ),
            Expanded(
              child: TextFormField(
                autocorrect: false,
                decoration: const InputDecoration.collapsed(
                  hintText: 'Image Url',
                  hintStyle: TextStyle(color: Colors.black54),
                ),
                keyboardType: TextInputType.url,
                textInputAction: TextInputAction.next,
                // gets the introduced string
                onChanged: (enteredString) {
                  if (enteredString != '') {
                    Item updatedItem = Item(
                      title: widget.tempItem.title,
                      photoUrl: enteredString,
                      pricePaid: widget.tempItem.pricePaid,
                      priceMarket: widget.tempItem.priceMarket,
                      amountOfItem: widget.tempItem.amountOfItem,
                    );

                    widget.onSave(updatedItem);
                  }
                },
                validator: (value) {
                  if (value != null) {
                    if (!value.startsWith('http') &&
                        !value.startsWith('https')) {
                      return 'Please enter a valid URL';
                    }
                  }
                  if (value != null) {
                    if (!value.endsWith('.png') &&
                        !value.endsWith('.jpg') &&
                        !value.endsWith('.jpeg')) {
                      return 'Please enter a valid image URL';
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
