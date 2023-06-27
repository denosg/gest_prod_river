import 'package:flutter/material.dart';

import '../widgets/listing_screen/add_button.dart';
import '../widgets/listing_screen/products_list.dart';

class ListingsOverviewScreen extends StatelessWidget {
  static const routeName = '/listings-overview-screen';
  const ListingsOverviewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Listings', style: TextStyle(fontSize: 24)),
      ),
      body: const ProductsList(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: const AddButton(),
    );
  }
}
