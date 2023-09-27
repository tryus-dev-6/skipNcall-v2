
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ImageSelectionDialog extends StatefulWidget {
  Function(String) onPressed;
  ImageSelectionDialog({Key? key, required this.onPressed}) : super(key: key);

  @override
  State<ImageSelectionDialog> createState() => _ImageSelectionDialogState();
}

class _ImageSelectionDialogState extends State<ImageSelectionDialog> {

  Future<void> pickImageFromGallery() async {
    final imagePicker = ImagePicker();
    final pickedImage = await imagePicker.pickImage(source: ImageSource.gallery, imageQuality: 25);

    if (pickedImage != null) {
      widget.onPressed(pickedImage.path);

    } else {
      // User canceled the image picking.
    }
  }

  Future<void> openCamera() async {
    final imagePicker = ImagePicker();
    final pickedImage = await imagePicker.pickImage(source: ImageSource.camera, imageQuality: 25);

    if (pickedImage != null) {
      widget.onPressed(pickedImage.path);

    } else {
      // User canceled taking a picture.
    }
  }

  @override
  Widget build(BuildContext context) {

    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      content: SizedBox(
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text("Choose Image From",
                style: TextStyle(
                    color: Color(0xff1E1E1E), fontSize: 20, fontWeight: FontWeight.w500)),
            const SizedBox(
              height: 15,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                GestureDetector(
                  onTap: (){
                    Navigator.of(context).pop();
                    pickImageFromGallery();
                  },
                  child: Card(
                      color: const Color(0xfff2f4f5),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      child: const Padding(
                        padding: EdgeInsets.all(10.0),
                        child: Icon(Icons.storage, size: 40, color: Color(0xffF1504C)),
                      )),
                ),
                GestureDetector(
                  onTap: (){
                    Navigator.of(context).pop();
                    openCamera();
                  },
                  child: Card(
                      color: const Color(0xfff2f4f5),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      child: const Padding(
                        padding: EdgeInsets.all(10.0),
                        child: Icon(
                          Icons.camera_alt,
                          size: 40,
                          color: Color(0xffF1504C),
                        ),
                      )),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
