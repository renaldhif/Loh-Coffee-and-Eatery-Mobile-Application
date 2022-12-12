import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loh_coffee_eatery/cubit/menu_cubit.dart';
import 'package:loh_coffee_eatery/models/menu_model.dart';
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

    Reference refStorage = FirebaseStorage.instance.ref().child('images/menus/${image!.path}');
    UploadTask uploadTask = refStorage.putFile(image!);
    TaskSnapshot taskSnapshot = await uploadTask.whenComplete(() => null);
    String urlImg = await taskSnapshot.ref.getDownloadURL();
    setState(() {
      _imageController.text = urlImg;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Image Uploaded'),
          backgroundColor: primaryColor,
        ),
      );
    });
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
              const SizedBox(
                height: 15,
              ),
              Text(
                'Image',
                style: greenTextStyle.copyWith(
                  fontSize: 18,
                  fontWeight: bold,
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              CustomButtonWhite(
                title: 'Choose an Image',
                onPressed: () {
                  getImage();
                  _imageController;
                },
              ),

              Padding(
                padding:
                const EdgeInsets.symmetric(horizontal: 20, vertical: 35),
                child: BlocConsumer<MenuCubit, MenuState>(
                  listener: (context, state) {
                    if(state is MenuSuccess){
                      Navigator.popAndPushNamed(context, '/home-admin');
                    }
                    else if(state is MenuFailed){
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          backgroundColor: Colors.red,
                          content: Text(state.error),
                        ),
                      );
                    }
                  },
                  builder: (context, state) {
                    if (state is MenuLoading) {
                      return const Center(
                        child: CircularProgressIndicator(
                          color: primaryColor,
                        ),
                      );
                    }
                    return CustomButton(
                      title: 'Add Menu',
                      onPressed: () {
                        context.read<MenuCubit>().addMenu(
                          title: _menuNameController.text,
                          description: _descriptionController.text,
                          price: int.parse(_priceController.text),
                          tag: _tagController.text,
                          image: _imageController.text,
                          totalLoved: 0,
                          totalOrdered: 0,
                        );
                        ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Menu Successfully Added!'),
                          backgroundColor: primaryColor,
                        ),
                      );
                      },
                    );
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
