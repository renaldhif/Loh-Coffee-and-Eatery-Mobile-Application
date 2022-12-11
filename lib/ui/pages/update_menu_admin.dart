import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../cubit/menu_cubit.dart';
import '../../models/menu_model.dart';
import '../../services/menu_service.dart';
import '/shared/theme.dart';
import 'package:loh_coffee_eatery/ui/widgets/custom_button.dart';
import 'package:loh_coffee_eatery/ui/widgets/custom_button_white.dart';
import 'package:loh_coffee_eatery/ui/widgets/custom_textformfield.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class UpdateMenuPageAdmin extends StatefulWidget {
  // final MenuModel inMenu;
  MenuModel? inMenu;
  UpdateMenuPageAdmin({super.key, this.inMenu});

  @override
  State<UpdateMenuPageAdmin> createState() => _AddMenuPageAdminState();
}

class _AddMenuPageAdminState extends State<UpdateMenuPageAdmin> {
  // TextEditingControllers
  final TextEditingController _menuNameController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _tagController = TextEditingController();
  final TextEditingController _imageController = TextEditingController();

  CollectionReference _menuCollection =
      FirebaseFirestore.instance.collection('menus');

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
                  label: widget.inMenu!.title.toString(),
                  hintText: 'input menu name',
                  controller: _menuNameController),
              //* Description
              CustomTextFormField(
                  title: 'Menu Description',
                  label: widget.inMenu!.description.toString(),
                  hintText: 'input menu description',
                  controller: _descriptionController),
              //* Price
              CustomTextFormField(
                  title: 'Menu Price',
                  label: widget.inMenu!.price.toString(),
                  hintText: 'input menu price',
                  controller: _priceController),
              //* Tag
              CustomTextFormField(
                  title: 'Menu Tag',
                  label: widget.inMenu!.tag.toString(),
                  hintText: 'input menu tag',
                  controller: _tagController),
              const SizedBox(
                height: 15,
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
                    // TODO: implement listener
                    if(state is MenuSuccess){
                      // Navigator.pushNamedAndRemoveUntil(context, '/home-admin', (route) => false);
                      Navigator.popAndPushNamed(context, '/home-admin');
                      // Navigator.pop(context);
                      // ScaffoldMessenger.of(context).showSnackBar(
                      //     const SnackBar(
                      //       content: Text('Menu Successfully Updated!'),
                      //       backgroundColor: primaryColor,
                      //     ),
                      //   );
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
                      title: 'Update Menu',
                      onPressed: () {
                        if(_menuNameController.text.isEmpty){
                          _menuNameController.text = widget.inMenu!.title.toString();
                        }
                        if(_descriptionController.text.isEmpty){
                          _descriptionController.text = widget.inMenu!.description.toString();
                        }
                        if(_priceController.text.isEmpty){
                          _priceController.text = widget.inMenu!.price.toString();
                        }
                        if(_tagController.text.isEmpty){
                          _tagController.text = widget.inMenu!.tag.toString();
                        }
                        if(_imageController.text.isEmpty){
                          _imageController.text = widget.inMenu!.image.toString();
                        }
                        context.read<MenuCubit>().updateMenu(
                              widget.inMenu,
                              _menuNameController.text,
                              _descriptionController.text,
                              int.parse(_priceController.text),
                              _tagController.text,
                              _imageController.text,
                            );
                        // Navigator.pushReplacementNamed(context, '/home-admin');
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Menu Successfully Updated!'),
                            backgroundColor: primaryColor,
                          ),
                        );
                        
                        //! Implement Update Menu Function
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
