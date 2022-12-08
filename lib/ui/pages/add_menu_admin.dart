import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '/shared/theme.dart';
import 'package:loh_coffee_eatery/ui/widgets/custom_button.dart';
import 'package:loh_coffee_eatery/ui/widgets/custom_button_white.dart';
import 'package:loh_coffee_eatery/ui/widgets/custom_textformfield.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class AddMenuPageAdmin extends StatefulWidget {
  const AddMenuPageAdmin({super.key});

  @override
  State<AddMenuPageAdmin> createState() => _AddMenuPageAdminState();
}

class _AddMenuPageAdminState extends State<AddMenuPageAdmin> {
  // TextEditingControllers
  final TextEditingController _menuNameController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _tagController = TextEditingController();
  final TextEditingController _imageController = TextEditingController();

  // Image Picker
  File? image;
  Future getImage() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (image == null) return;
      final imageTemp = File(image.path);
      setState(() {
        this.image = imageTemp;
      });
    } on PlatformException catch (e) {
      print('Failed to pick image: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          color: whiteColor,
          child: Column(
            children: [
              // Header
              Container(
                width: double.infinity,
                margin: const EdgeInsets.only(top: 30),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: const Icon(
                        Icons.arrow_circle_left_rounded,
                        color: primaryColor,
                        size: 55,
                      ),
                    ),
                    const SizedBox(height: 30),
                    Padding(
                      padding: const EdgeInsets.only(left: 12),
                      child: Text(
                        'Add Menu',
                        style: greenTextStyle.copyWith(
                          fontSize: 40,
                          fontWeight: bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              // Add Menu Content

              //* Menu Name
              CustomTextFormField(
                  title: 'Menu Name',
                  label: 'Menu Name',
                  hintText: 'input menu name',
                  controller: _menuNameController),
              //* Description
              CustomTextFormField(
                  title: 'Menu Description',
                  label: 'Menu Description',
                  hintText: 'input menu description',
                  controller: _descriptionController),
              //* Price
              CustomTextFormField(
                  title: 'Menu Price',
                  label: 'Menu Price',
                  hintText: 'input menu price',
                  controller: _priceController),
              //* Tag
              CustomTextFormField(
                  title: 'Menu Tag',
                  label: 'Menu Tag',
                  hintText: 'input menu tag',
                  controller: _tagController),
              //* Image
              CustomTextFormField(
                  title: 'Menu Image',
                  label: 'Menu Image',
                  hintText: 'input menu image',
                  controller: _imageController),

              const SizedBox(
                height: 15,
              ),
              Text(
                'Or',
                style: greenTextStyle.copyWith(fontSize: 18),
              ),
              const SizedBox(
                height: 15,
              ),
              CustomButtonWhite(
                title: 'Choose an Image',
                onPressed: () {
                  getImage();
                },
              ),

              const SizedBox(
                height: 50,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: CustomButton(
                  title: 'Add Menu',
                  onPressed: () {
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
