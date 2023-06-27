import 'package:flutter/material.dart';

import '../../screens/add_listing_screen.dart';

class AddButton extends StatelessWidget {
  const AddButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 60,
      height: 60,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Theme.of(context).primaryColor,
      ),
      child: IconButton(
        splashRadius: 40,
        onPressed: () {
          Navigator.of(context).pushNamed(AddListingScreen.routeName);
        },
        icon: const Icon(Icons.add),
      ),
    );
  }
}
