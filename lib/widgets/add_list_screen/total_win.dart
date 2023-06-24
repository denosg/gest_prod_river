import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../providers/item_list_provider.dart';

class TotalWin extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    double width = MediaQuery.of(context).size.width;

    final winMoney =
        ref.read(itemListProvider.notifier).getMarketSum().toString();

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(width * 0.01),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(6),
                color: Colors.grey[300]),
            child: const Text(
              'Total WIN Money:',
              style: TextStyle(fontSize: 20),
            ),
          ),
          SizedBox(
            width: width * 0.01,
          ),
          Container(
            padding: EdgeInsets.all(width * 0.01),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(6),
                color: Colors.grey[400]),
            child: Text(
              winMoney,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }
}
