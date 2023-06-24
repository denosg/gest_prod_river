import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../../../models/item.dart';

class ImageUrlForm extends StatefulWidget {
  final Item tempItem;
  final Function(Item) onSave;

  const ImageUrlForm({Key? key, required this.tempItem, required this.onSave})
      : super(key: key);

  @override
  State<ImageUrlForm> createState() => _ImageUrlFormState();
}

class _ImageUrlFormState extends State<ImageUrlForm> {
  bool isImageLoaded = false;
  String? finalImageUrl;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    // get image from phone gallery method
    Future<File?> getImage() async {
      final ImagePicker picker = ImagePicker();
      final XFile? pickedFile =
          await picker.pickImage(source: ImageSource.gallery);

      if (pickedFile != null) {
        return File(pickedFile.path);
      }

      return null;
    }

    //upload image to firebase cloud db
    Future<String> uploadImageToFirebase(File image) async {
      final storage = FirebaseStorage.instance;
      final imageName = DateTime.now().millisecondsSinceEpoch.toString();
      //Create a reference for the image to be stored + storage root
      final reference = storage.ref().child('images/$imageName.jpg');
      //Store the file
      await reference.putFile(image);
      //Success: get download URL
      final downloadUrl = await reference.getDownloadURL();

      return downloadUrl;
    }

    Future<void> showcaseImage() async {
      final uploadImage = await getImage();
      if (uploadImage != null) {
        final imageUrl = await uploadImageToFirebase(uploadImage);
        print('Image uploaded successfully. URL: $imageUrl');
        setState(() {
          finalImageUrl = imageUrl;
          isImageLoaded = true;
        });
        // updates the widget with the image url
        if (finalImageUrl != null) {
          Item updatedItem = Item(
            title: widget.tempItem.title,
            photoUrl: finalImageUrl!,
            pricePaid: widget.tempItem.pricePaid,
            priceMarket: widget.tempItem.priceMarket,
            amountOfItem: widget.tempItem.amountOfItem,
          );
          widget.onSave(updatedItem);
        }
      } else {
        print('No image selected.');
      }
    }

    return Padding(
      padding: EdgeInsets.symmetric(
          vertical: height * 0.02, horizontal: width * 0.25),
      child: InkWell(
        onTap: showcaseImage,
        child: Container(
          width: width * 0.5,
          height: height * 0.15,
          padding: EdgeInsets.all(width * 0.03),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(6),
            color: Colors.grey[300],
          ),
          child: Center(
            child: isImageLoaded
                ? Image.network(
                    finalImageUrl!,
                    width: double.infinity,
                    height: double.infinity,
                    fit: BoxFit.cover,
                  )
                : const Icon(
                    Icons.image,
                    color: Colors.black54,
                    size: 50,
                  ),
          ),
        ),
      ),
    );
  }
}
