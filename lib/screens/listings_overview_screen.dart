import 'package:flutter/material.dart';

import '../widgets/listing_screen/add_button.dart';
import '../widgets/listing_screen/products_list.dart';

class ListingsOverviewScreen extends StatelessWidget {
  const ListingsOverviewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            // bani investiti
            Text('invest: '),
            // profit (recuperat - bani investiti)
            Text('profit: '),
            // recuperat
            Text('recuperat: '),
          ],
        ),
      ),
      body: ProductsList(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: const AddButton(),
    );
  }
}
