import 'package:flutter/material.dart';
import 'package:gest_prod_river/models/item.dart';
import 'package:gest_prod_river/widgets/listing_screen/slideable_images_card.dart';
import 'package:intl/intl.dart';

import '../../screens/listing_detail_screen.dart';

class ListingItem extends StatelessWidget {
  final String id;
  final String title;
  final DateTime dateTime;
  final int amount;
  final List<Item> itemList;

  const ListingItem({
    super.key,
    required this.id,
    required this.title,
    required this.dateTime,
    required this.amount,
    required this.itemList,
  });

  void _showListingDetails(String id, BuildContext ctx) {
    Navigator.of(ctx).pushNamed(ListingDetailsScreen.routeName, arguments: id);
  }

  @override
  Widget build(BuildContext context) {
    final scaffoldMessenger = ScaffoldMessenger.of(context);
    final deviceSize = MediaQuery.of(context).size;

    //formatted date
    String formattedDate = DateFormat('dd:MM:yyyy').format(dateTime);
    return InkWell(
      onLongPress: () async {
        try {
          // Alert dialog for deleting listing
          showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: const Text('Are you sure ?'),
                content: const Text('Do you want to delete the listing ?'),
                // Options for the user regarding deleting a quest
                actions: [
                  TextButton(
                    onPressed: () => Navigator.of(context).pop(false),
                    child: const Text('No'),
                  ),
                  TextButton(
                    onPressed: () {
                      // TODO: delete logic here
                      Navigator.of(context).pop();
                    },
                    child: const Text('Yes'),
                  )
                ],
              );
            },
          );
        } catch (error) {
          scaffoldMessenger
              .showSnackBar(const SnackBar(content: Text('Deleting failed !')));
        }
      },
      // onTap shows the listing details screen based on the listing's id
      onTap: () => _showListingDetails(id, context),
      child: Container(
        color: Colors.amber,
        height: deviceSize.height * 0.3,
        width: deviceSize.width * 0.9,
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          elevation: 5,
          margin: const EdgeInsets.all(15),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Column(
                children: [
                  // the slideable images of each item from the listing to display
                  SlideableImagesCard(itemList: itemList),
                  // the title of the listing
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      title,
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.secondary,
                        fontSize: deviceSize.width * 0.3,
                      ),
                    ),
                  ),
                  // the date of the listing
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      formattedDate,
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.secondary,
                        fontSize: deviceSize.width * 0.15,
                      ),
                    ),
                  ),
                ],
              ),
              // the amount of items
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  amount.toString(),
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.secondary,
                    fontSize: deviceSize.width * 0.2,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
