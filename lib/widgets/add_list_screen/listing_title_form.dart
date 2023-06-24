import 'package:flutter/material.dart';

import '../../models/listing.dart';

class ListingTitleForm extends StatefulWidget {
  final Listing listing;
  final Function(Listing) onSave;
  const ListingTitleForm(
      {super.key, required this.onSave, required this.listing});

  @override
  State<ListingTitleForm> createState() => _ListingTitleFormState();
}

class _ListingTitleFormState extends State<ListingTitleForm> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Container(
      width: width * 0.9,
      height: height * 0.07,
      padding: EdgeInsets.all(width * 0.03),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(6), color: Colors.grey[300]),
      child: Center(
        child: Row(
          children: [
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
                  hintText: 'Listing Title',
                  hintStyle: TextStyle(color: Colors.black54),
                ),
                textInputAction: TextInputAction.next,
                // gets the introduced string
                onChanged: (enteredString) {
                  if (enteredString != '') {
                    Listing updatedListing = Listing(
                      id: widget.listing.id,
                      title: enteredString,
                      dateTime: widget.listing.dateTime,
                      amount: widget.listing.amount,
                      itemList: widget.listing.itemList,
                    );
                    //save the new state of the object
                    widget.onSave(updatedListing);
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
