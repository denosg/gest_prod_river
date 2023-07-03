import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerListing extends StatelessWidget {
  const ShimmerListing({super.key});

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;

    return Container(
      margin: const EdgeInsets.all(15),
      height: deviceSize.height * 0.3,
      width: deviceSize.width * 0.9,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: Colors.white,
      ),
      child: Shimmer.fromColors(
        baseColor: Colors.grey[300]!,
        highlightColor: Colors.grey[100]!,
        child: Column(
          children: [
            // the slideable images of each item from the listing to display
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Container(
                width: deviceSize.height * 0.2,
                height: deviceSize.height * 0.1,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: Colors.white,
                ),
              ),
            ),
            // title + date + amount of item
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                // title + date
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // the title of the listing
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: Colors.white,
                        ),
                        height: deviceSize.height * 0.05,
                        width: deviceSize.width * 0.2,
                      ),
                    ),
                    // the date of the listing
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: Colors.white,
                        ),
                        height: deviceSize.height * 0.03,
                        width: deviceSize.width * 0.25,
                      ),
                    ),
                  ],
                ),
                // the amount of items
                Container(
                  padding: const EdgeInsets.all(8.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: Colors.white,
                  ),
                  height: deviceSize.height * 0.06,
                  width: deviceSize.width * 0.15,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
