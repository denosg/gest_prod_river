import 'package:flutter/material.dart';

import '../../models/item.dart';

class AddedItem extends StatelessWidget {
  final Item itemInfo;

  const AddedItem({super.key, required this.itemInfo});

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;

    return Container(
      padding: const EdgeInsets.all(3),
      width: double.infinity,
      height: height * 0.12,
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            SizedBox(
              height: height * 0.07,
              width: height * 0.07,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: itemInfo.photoUrl == ''
                    ? Image.asset('assets/images/item_vector.jpg')
                    : Image.network(itemInfo.photoUrl),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    itemInfo.title,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text('Price paid: ${itemInfo.pricePaid}'),
                  Text('Price market: ${itemInfo.priceMarket}'),
                ],
              ),
            ),
            Text(itemInfo.amountOfItem.toString()),
          ],
        ),
      ),
    );
  }
}
