import 'package:checkbox_grouped/checkbox_grouped.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_localization/easy_localization.dart';
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
  //* TextEditingControllers
  final TextEditingController _menuNameController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _imageController = TextEditingController();
  TextEditingController _tagController = TextEditingController();

  //* Group Controller
  GroupController controller = GroupController(isMultipleSelection: true);

  CollectionReference _menuCollection =
      FirebaseFirestore.instance.collection('menus');

  // Image Picker
  File? image;
  Future getImage() async {
    bool isLoading = false;
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (image == null) return;
      final imageTemp = File(image.path);
      setState(() {
        this.image = imageTemp;
        isLoading = true;
        if( isLoading == true){
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text("loading_upload_image".tr()),
              backgroundColor: secondaryColor,
            ),
          );
        }
      });
    } on PlatformException catch (e) {
      print('failed_upload_image'.tr() + ': $e');
    }

    Reference refStorage = FirebaseStorage.instance.ref().child('images/menus/${image!.path}');
    UploadTask uploadTask = refStorage.putFile(image!);
    TaskSnapshot taskSnapshot = await uploadTask.whenComplete(() => null);
    String urlImg = await taskSnapshot.ref.getDownloadURL();
    setState(() {
      isLoading = false;
      _imageController.text = urlImg;
      if ( isLoading == false){
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("success_upload_image".tr()),
            backgroundColor: primaryColor,
          ),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      body: SingleChildScrollView(
        child: Container(
          color: backgroundColor,
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
                      icon:  Icon(
                        Icons.arrow_circle_left_rounded,
                        color: primaryColor,
                        size: 55,
                      ),
                    ),
                    const SizedBox(height: 30),
                    Padding(
                      padding: const EdgeInsets.only(left: 12),
                      child: Text(
                        'update_menu'.tr(),
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
                  title: 'menu_name'.tr(),
                  label: widget.inMenu!.title.toString(),
                  hintText: "text_menu_name".tr(),
                  controller: _menuNameController),
              //* Description
              CustomTextFormField(
                  title: 'menu_description'.tr(),
                  label: widget.inMenu!.description.toString(),
                  hintText: "text_menu_description".tr(),
                  controller: _descriptionController),
              //* Price
              CustomTextFormField(
                  title: 'menu_price'.tr(),
                  label: widget.inMenu!.price.toString(),
                  hintText: "text_menu_price".tr(),
                  controller: _priceController),
              //* Tag
              CustomTextFormField(
                  readOnly: true,
                  title: 'menu_tag'.tr(),
                  label: widget.inMenu!.tag.toString(),
                  hintText: widget.inMenu!.tag.toString(),
                  controller: _tagController),
              //* Checkboxes
              const SizedBox(height: 25,),
              Text(
                "choose_tag".tr(),
                style: greenTextStyle.copyWith(
                  fontSize: 18,
                  fontWeight: bold,
                ),
              ),
              Theme(
                data: ThemeData(
                  unselectedWidgetColor: primaryColor,
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: SimpleGroupedCheckbox<String>(
                    controller: controller,
                    itemsTitle: const [
                      "Rice",
                      "Chicken",
                      "Beef",
                      "Seafood",
                      "Noodles",
                      "Pasta",
                      "Fish",
                      "Soup",
                      "Snacks",
                      "Vegetables",
                      "Cake and Dessert",
                      "Coffee",
                      "Milk",
                      "Tea",
                      "Spicy",
                    ],
                    values: const [
                      "Rice",
                      "Chicken",
                      "Beef",
                      "Seafood",
                      "Noodles",
                      "Pasta",
                      "Fish",
                      "Soup",
                      "Snacks",
                      "Vegetables",
                      "Cake and Dessert",
                      "Coffee",
                      "Milk",
                      "Tea",
                      "Spicy",
                    ],
                    groupStyle: GroupStyle(
                      activeColor: primaryColor,
                      itemTitleStyle: greenTextStyle.copyWith(
                        fontSize: 16,
                        fontWeight: regular,
                      ),
                      groupTitleStyle: greenTextStyle,
                    ),
                    onItemSelected: (selected) {
                      setState(() {
                        // print(selected.join(','));
                        _tagController.text = selected.join(',');
                      });
                    },
                  ),
                ),
              ),

              const SizedBox(
                height: 15,
              ),
              Text(
                'upload_image'.tr(),
                style: greenTextStyle.copyWith(
                  fontSize: 18,
                  fontWeight: bold,
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              CustomButtonWhite(
                title: _imageController.text.isEmpty ? "choose_image".tr() : image!.path.split('/').last,
                fontSize: _imageController.text.isEmpty ? 18 : 12,
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
                    if (state is MenuSuccess) {
                      Navigator.popAndPushNamed(context, '/home-admin');
                    } else if (state is MenuFailed) {
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
                      return  Center(
                        child: CircularProgressIndicator(
                          color: primaryColor,
                        ),
                      );
                    }
                    return CustomButton(
                      title: 'update_menu'.tr(),
                      onPressed: () {
                        if (_menuNameController.text.isEmpty) {
                          _menuNameController.text =
                              widget.inMenu!.title.toString();
                        }
                        if (_descriptionController.text.isEmpty) {
                          _descriptionController.text =
                              widget.inMenu!.description.toString();
                        }
                        if (_priceController.text.isEmpty) {
                          _priceController.text =
                              widget.inMenu!.price.toString();
                        }
                        if (_tagController.text.isEmpty) {
                          _tagController.text = widget.inMenu!.tag.toString();
                        }
                        if (_imageController.text.isEmpty) {
                          _imageController.text =
                              widget.inMenu!.image.toString();
                        }
                        if(_priceController.text.contains(RegExp(r'[a-zA-Z]'))) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text("validation_price".tr()),
                              backgroundColor: Colors.red,
                            ),
                          );
                        }
                        else{
                          context.read<MenuCubit>().updateMenu(
                              widget.inMenu,
                              _menuNameController.text,
                              _descriptionController.text,
                              int.parse(_priceController.text),
                              _tagController.text,
                              _imageController.text,
                            );
                            // Navigator.popAndPushNamed(context, '/home-admin');
                            ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text("menu_update_success".tr(),
                              style: whiteTextButtonStyle
                              ),
                              backgroundColor: greenButtonColor,
                            ),
                          );
                        }
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
