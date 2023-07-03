import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

import '../../models/item.dart';

class SlideableImagesCard extends StatefulWidget {
  final List<Item> itemList;
  const SlideableImagesCard({super.key, required this.itemList});

  @override
  State<SlideableImagesCard> createState() => _SlideableImagesCardState();
}

class _SlideableImagesCardState extends State<SlideableImagesCard> {
  final CarouselController _controller = CarouselController();
  var photosList = <String>[];
  int current = 0;

  @override
  Widget build(BuildContext context) {
    // device sized
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    // adding the urls of the images in a list
    for (var item in widget.itemList) {
      photosList.add(item.photoUrl);
    }

    return Padding(
      padding: const EdgeInsets.only(top: 8),
      child: Stack(
        alignment: Alignment.center,
        children: [
          // carousel of images
          SizedBox(
            height: height * 0.15,
            width: width * 0.9,
            child: CarouselSlider.builder(
              carouselController: _controller,
              options: CarouselOptions(
                  enlargeCenterPage: true,
                  aspectRatio: 2.0,
                  onPageChanged: (index, reason) {
                    setState(() {
                      current = index;
                    });
                  }),
              itemCount: widget.itemList.length,
              itemBuilder: (context, index, realIndex) => ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.network(
                  photosList[index],
                  width: height * 0.2,
                  height: height * 0.1,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          // the indicator of images
          Positioned(
            bottom: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(widget.itemList.length, (index) {
                return GestureDetector(
                  onTap: () => _controller.animateToPage(index),
                  child: Container(
                    width: 12.0,
                    height: 12.0,
                    margin: const EdgeInsets.symmetric(
                        vertical: 8.0, horizontal: 4.0),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: (Theme.of(context).brightness == Brightness.dark
                              ? Colors.white
                              : Colors.black)
                          .withOpacity(current == index ? 0.9 : 0.4),
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }
}
