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
  int _current = 0;
  final CarouselController _controller = CarouselController();
  var photosList = <String>[];

  @override
  Widget build(BuildContext context) {
    // device sized
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    for (var item in widget.itemList) {
      photosList.add(item.photoUrl);
    }

    return Stack(
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
                    _current = index;
                  });
                }),
            itemCount: widget.itemList.length,
            itemBuilder: (context, index, realIndex) => Image.network(
              photosList[index],
              width: double.infinity,
              height: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
        ),
        // the indicator of images
        Positioned(
          bottom: 10,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: photosList.asMap().entries.map((entry) {
              return GestureDetector(
                onTap: () => _controller.animateToPage(entry.key),
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
                          .withOpacity(_current == entry.key ? 0.9 : 0.4)),
                ),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }
}
