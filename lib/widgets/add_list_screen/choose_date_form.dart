import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../models/listing.dart';

class ChooseDateForm extends StatefulWidget {
  final Listing listing;
  final Function(Listing) onSave;
  const ChooseDateForm(
      {super.key, required this.listing, required this.onSave});

  @override
  State<ChooseDateForm> createState() => _ChooseDateFormState();
}

class _ChooseDateFormState extends State<ChooseDateForm> {
  // current date for calendar
  DateTime _selectedDate = DateTime.now();

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
        setState(() {
          _selectedDate = chosenDate;
          // update the listing with the appropriate information
          Listing updatedListing = Listing(
            id: widget.listing.id,
            title: widget.listing.title,
            dateTime: _selectedDate,
            amount: widget.listing.amount,
            itemList: widget.listing.itemList,
          );
          widget.onSave(updatedListing);
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return SizedBox(
      width: width * 0.85,
      child: Row(
        children: [
          // show the date chosen
          Text(DateFormat.yMMMd().format(_selectedDate)),
          // button for choosing the date
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
    );
  }
}
