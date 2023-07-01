import 'package:flutter/material.dart';

import '../../screens/listing_detail_screen.dart';

class ListingItem extends StatelessWidget {
  final String id;
  final String title;
  final DateTime dateTime;
  final double amount;

  const ListingItem(
      {super.key,
      required this.id,
      required this.title,
      required this.dateTime,
      required this.amount});

  void _showListingDetails(String id, BuildContext ctx) {
    Navigator.of(ctx).pushNamed(ListingDetailsScreen.routeName, arguments: id);
  }

  @override
  Widget build(BuildContext context) {
    final scaffoldMessenger = ScaffoldMessenger.of(context);
    final deviceSize = MediaQuery.of(context).size;
    return InkWell(
      onLongPress: () async {
        try {
          // Alert dialog for deleting listing
          showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: const Text('Esti sigur ?'),
                content: const Text('Vrei sa stergi lista ?'),
                // Options for the user regarding deleting a quest
                actions: [
                  TextButton(
                    onPressed: () => Navigator.of(context).pop(false),
                    child: const Text('Nu'),
                  ),
                  TextButton(
                    onPressed: () {
                      // TODO: delete logic here
                      Navigator.of(context).pop();
                    },
                    child: const Text('Da'),
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
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: SizedBox(
          width: double.infinity,
          height: deviceSize.height / 7,
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            elevation: 10,
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListTile(
                  leading: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.network(
                        'https://ae01.alicdn.com/kf/H3c5b317b00d042e296c30dfaddc55c25o/2020-New-Arrival-1-Piece-High-Quality-ABS-Retractable-Nurse-Badge-Holder-Reel-Reel-Elegant-Hospital.jpg_50x50.jpg_.webp'),
                  ),
                  title: Text(title),
                  subtitle: Text(dateTime.toIso8601String()),
                  trailing: Text(amount.toString()),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
