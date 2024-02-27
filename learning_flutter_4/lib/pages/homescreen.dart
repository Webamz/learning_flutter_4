import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String selectedImagePath = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue, // Change background color to blue
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            selectedImagePath.isEmpty
                ? Container(
                    color: Colors.grey, // Placeholder color
                    height: 200,
                    width: 200,
                    child: const Icon(
                      Icons.image,
                      size: 100,
                      color: Colors.white, // Icon color
                    ),
                  )
                : Image.file(
                    File(selectedImagePath),
                    height: 200,
                    width: 200,
                    fit: BoxFit.fill,
                  ),
            const Text(
              'Select Image',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
            ),
            const SizedBox(
              height: 20.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () async {
                    await _selectImage(ImageSource.gallery);
                  },
                  child: const Text('Select from Gallery'),
                ),
                const SizedBox(width: 20),
                ElevatedButton(
                  onPressed: () async {
                    await _selectImage(ImageSource.camera);
                  },
                  child: const Text('Capture with Camera'),
                ),
              ],
            ),
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }

  Future<void> _selectImage(ImageSource source) async {
    final XFile? file = await ImagePicker().pickImage(
      source: source,
      imageQuality: 10,
    );
    if (file != null) {
      setState(() {
        selectedImagePath = file.path;
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("No Image Selected !"),
        ),
      );
    }
  }
}
