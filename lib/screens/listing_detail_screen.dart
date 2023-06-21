import 'package:flutter/material.dart';

class ListingDetailsScreen extends StatelessWidget {
  static const routeName = "/listing-details-screen";

  @override
  Widget build(BuildContext context) {
    // get the id of the specific listing from the list of listings
    final String id = ModalRoute.of(context)?.settings.arguments as String;

    return const Placeholder();
  }
}
