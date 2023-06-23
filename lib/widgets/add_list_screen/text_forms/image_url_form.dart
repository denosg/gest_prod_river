import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../../../models/item.dart';

class ImageUrlForm extends StatefulWidget {
  final Item tempItem;
  final Function(Item) onSave;

  const ImageUrlForm({super.key, required this.tempItem, required this.onSave});

  @override
  State<ImageUrlForm> createState() => _ImageUrlFormState();
}

class _ImageUrlFormState extends State<ImageUrlForm> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    File? uploadImage;
    String? finalImageUrl;

    // get image from phone gallery method
    Future<File?> getImage() async {
      final picker = ImagePicker();
      final pickedFile = await picker.pickImage(source: ImageSource.gallery);

      if (pickedFile != null) {
        return File(pickedFile.path);
      }

      return null;
    }

    //upload image to firebase cloud db
    Future<String> uploadImageToFirebase(File image) async {
      final storage = FirebaseStorage.instance;
      final imageName = DateTime.now().millisecondsSinceEpoch.toString();
      final reference = storage.ref().child('images/$imageName.jpg');

      await reference.putFile(image);
      final downloadUrl = await reference.getDownloadURL();

      return downloadUrl;
    }

    return InkWell(
      // onTap uploads image to cloud db and retrives link to show
      onTap: () async {
        uploadImage = await getImage();
        if (uploadImage != null) {
          final imageUrl = await uploadImageToFirebase(uploadImage!);
          print('Image uploaded successfully. URL: $imageUrl');
          setState(() {
            finalImageUrl = imageUrl;
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
      },
      child: Container(
        width: width * 0.5,
        height: height * 0.15,
        padding: EdgeInsets.all(width * 0.03),
        margin: EdgeInsets.symmetric(
            horizontal: width * 0.2, vertical: height * 0.01),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(6), color: Colors.grey[300]),
        child: Center(
          child: finalImageUrl == null
              ? const Icon(
                  Icons.image,
                  color: Colors.black54,
                  size: 50,
                )
              : Image.network('$finalImageUrl.jpg'),
        ),
      ),
    );
  }
}
