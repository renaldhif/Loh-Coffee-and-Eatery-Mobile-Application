import 'package:checkbox_grouped/checkbox_grouped.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:loh_coffee_eatery/cubit/announce_cubit.dart';
import 'package:loh_coffee_eatery/cubit/menu_cubit.dart';
import 'package:loh_coffee_eatery/models/menu_model.dart';
import '../../models/announce_model.dart';
import '/shared/theme.dart';
import 'package:loh_coffee_eatery/ui/widgets/custom_button.dart';
import 'package:loh_coffee_eatery/ui/widgets/custom_button_white.dart';
import 'package:loh_coffee_eatery/ui/widgets/custom_textformfield.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class AddPromoPage extends StatefulWidget {
  const AddPromoPage({super.key});

  @override
  State<AddPromoPage> createState() => AddPromoPageState();
}

// need to include SingleTickerProviderStateMixin for tab controller
class AddPromoPageState extends State<AddPromoPage>
    with SingleTickerProviderStateMixin {
  // TextEditingControllers
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _announceController = TextEditingController();
  final TextEditingController _promoAvailDate = TextEditingController();
  final TextEditingController _promoEndDate = TextEditingController();
  final TextEditingController _imageController = TextEditingController();

  late TabController _tabController;

  //* Group Controller
  GroupController controller = GroupController(isMultipleSelection: true);

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
        if (isLoading == true) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('loading_upload_image'.tr()),
              backgroundColor: secondaryColor,
            ),
          );
        }
      });
    } on PlatformException catch (e) {
      print('failed_upload_image'.tr());
    }

    Reference refStorage =
        FirebaseStorage.instance.ref().child('images/promos/${image!.path}');
    UploadTask uploadTask = refStorage.putFile(image!);
    TaskSnapshot taskSnapshot = await uploadTask.whenComplete(() => null);
    String urlImg = await taskSnapshot.ref.getDownloadURL();
    setState(() {
      isLoading = false;
      _imageController.text = urlImg;
      if (isLoading == false) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('success_upload_image'.tr()),
            backgroundColor: primaryColor,
          ),
        );
      }
    });
  }

  void initState() {
    super.initState();
      _tabController = TabController(length: 2, vsync: this);
  }
  
  List<AnnounceModel> announces = [];

  //get announce length from announce_cubit
  Future<int> getAnnounceLength() async {
    int length = await AnnounceCubit().getOrderedAnnounceLength();
    return length;
  }

  //get 'announce' title from announce_cubit
  Future<String> getAnnounceTitle(int index) async {
    String title = await AnnounceCubit().getOrderedAnnounceString(index);
    return title;
  }

  Widget addPromoForm() {
    return Container(
      color: backgroundColor,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            Container(
              width: double.infinity,
              margin: const EdgeInsets.only(top: 30),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 12),
                    child: Text(
                      'add_promo'.tr(),
                      style: greenTextStyle.copyWith(
                        fontSize: 38,
                        fontWeight: bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
      
            //* Menu Name
            CustomTextFormField(
              title: 'promo_title'.tr(),
              label: 'input_promo_title'.tr(),
              hintText: 'input_promo_title'.tr(),
              controller: _titleController,
            ),
      
            //* Description
            CustomTextFormField(
              title: 'promo_description'.tr(),
              label: 'input_promo_description'.tr(),
              hintText: 'input_promo_description'.tr(),
              controller: _announceController,
            ),
      
            const SizedBox(height: 15),
      
            //* Promo Available Date
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'promo_available_date'.tr(),
                    style: greenTextStyle.copyWith(
                      fontSize: 18,
                      fontWeight: bold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  TextFormField(
                    controller: _promoAvailDate,
                    keyboardType: TextInputType.datetime,
                    readOnly: true,
                    onTap: () async {
                      DateTime? pickedDate = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(2023),
                        lastDate: DateTime(2025),
                        builder: (context, child) {
                          return FittedBox(
                            child: Theme(
                              data: isDarkMode
                                  ? ThemeData.dark().copyWith(
                                      colorScheme: ColorScheme.dark(
                                        primary: primaryColor,
                                      ),
                                      buttonTheme: const ButtonThemeData(
                                        textTheme: ButtonTextTheme.primary,
                                      ),
                                    )
                                  : ThemeData.light().copyWith(
                                      colorScheme: ColorScheme.light(
                                        primary: primaryColor,
                                      ),
                                      buttonTheme: const ButtonThemeData(
                                        textTheme: ButtonTextTheme.primary,
                                      ),
                                    ),
                              child: child!,
                            ),
                          );
                        },
                      );
                      if (pickedDate != null) {
                        var formatDate = DateTime.parse(pickedDate.toString());
                        var formattedDate =
                            "${formatDate.day}-${formatDate.month}-${formatDate.year}";
      
                        // Check if formattedDate is not empty before setting the controller text
                        if (formattedDate.isNotEmpty) {
                          _promoAvailDate.text = formattedDate;
                        }
                      } else if (pickedDate != null) {
                        var formatDate = DateTime.parse(pickedDate.toString());
                        var formattedDate = formatDate.toString().isEmpty
                            ? ""
                            : "${formatDate.day}-${formatDate.month}-${formatDate.year}";
                        _promoAvailDate.text = formattedDate;
                      } else {
                        _promoAvailDate.text = "";
                      }
                    },
                    style: mainTextStyle.copyWith(
                      fontSize: 16,
                      fontWeight: medium,
                    ),
                    decoration: InputDecoration(
                      suffixIcon: Icon(
                        Icons.calendar_today,
                        color: primaryColor,
                      ),
                      labelText: 'pick_date'.tr(),
                      labelStyle: mainTextStyle.copyWith(
                        fontSize: 16,
                        fontWeight: regular,
                      ),
                      hintText: 'pick_date'.tr(),
                      hintStyle: mainTextStyle.copyWith(
                        fontSize: 16,
                        fontWeight: regular,
                      ),
                      floatingLabelBehavior: FloatingLabelBehavior.never,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(
                          color: primaryColor,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(
                          color: primaryColor,
                          width: 1.5,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
      
            const SizedBox(height: 15),
      
            //* Promo End Date
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'promo_end_date'.tr(),
                    style: greenTextStyle.copyWith(
                      fontSize: 18,
                      fontWeight: bold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  TextFormField(
                    controller: _promoEndDate,
                    keyboardType: TextInputType.datetime,
                    readOnly: true,
                    onTap: () async {
                      DateTime? pickedDate = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(2023),
                        lastDate: DateTime(2025),
                        builder: (context, child) {
                          return FittedBox(
                            child: Theme(
                              data: isDarkMode
                                  ? ThemeData.dark().copyWith(
                                      colorScheme: ColorScheme.dark(
                                        primary: primaryColor,
                                      ),
                                      buttonTheme: const ButtonThemeData(
                                        textTheme: ButtonTextTheme.primary,
                                      ),
                                    )
                                  : ThemeData.light().copyWith(
                                      colorScheme: ColorScheme.light(
                                        primary: primaryColor,
                                      ),
                                      buttonTheme: const ButtonThemeData(
                                        textTheme: ButtonTextTheme.primary,
                                      ),
                                    ),
                              child: child!,
                            ),
                          );
                        },
                      );
                      if (pickedDate != null) {
                        var formatDate = DateTime.parse(pickedDate.toString());
                        var formattedDate =
                            "${formatDate.day}-${formatDate.month}-${formatDate.year}";
      
                        // Check if formattedDate is not empty before setting the controller text
                        if (formattedDate.isNotEmpty) {
                          _promoEndDate.text = formattedDate;
                        }
                      } else if (pickedDate != null) {
                        var formatDate = DateTime.parse(pickedDate.toString());
                        var formattedDate = formatDate.toString().isEmpty
                            ? ""
                            : "${formatDate.day}-${formatDate.month}-${formatDate.year}";
                        _promoEndDate.text = formattedDate;
                      } else {
                        _promoEndDate.text = "";
                      }
                    },
                    style: mainTextStyle.copyWith(
                      fontSize: 16,
                      fontWeight: medium,
                    ),
                    decoration: InputDecoration(
                      suffixIcon: Icon(
                        Icons.calendar_today,
                        color: primaryColor,
                      ),
                      labelText: 'pick_date'.tr(),
                      labelStyle: mainTextStyle.copyWith(
                        fontSize: 16,
                        fontWeight: regular,
                      ),
                      hintText: 'pick_date'.tr(),
                      hintStyle: mainTextStyle.copyWith(
                        fontSize: 16,
                        fontWeight: regular,
                      ),
                      floatingLabelBehavior: FloatingLabelBehavior.never,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(
                          color: primaryColor,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(
                          color: primaryColor,
                          width: 1.5,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
      
            const SizedBox(
              height: 15,
            ),
      
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                'upload_promo_image'.tr(),
                style: greenTextStyle.copyWith(
                  fontSize: 18,
                  fontWeight: bold,
                ),
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            CustomButtonWhite(
              title: _imageController.text.isEmpty
                  ? 'choose_image'.tr()
                  : image!.path.split('/').last,
              fontSize: _imageController.text.isEmpty ? 18 : 12,
              onPressed: () {
                getImage();
                _imageController;
              },
            ),
      
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 35, 20, 70),
              child: CustomButton(
                title: 'add_promo'.tr(),
                onPressed: () {
                  if (_titleController.text.isEmpty ||
                      _announceController.text.isEmpty ||
                      _promoAvailDate.text.isEmpty ||
                      _promoEndDate.text.isEmpty ||
                      _imageController.text.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('validation_all_field'.tr()),
                        backgroundColor: Colors.red,
                      ),
                    );
                  } else {
                    if (_promoEndDate.text.isNotEmpty &&
                        _promoAvailDate.text.isNotEmpty) {
                      final DateFormat dateFormat = DateFormat('dd-MM-yyyy');
                      DateTime datePromoAvail =
                          dateFormat.parse(_promoAvailDate.text);
                      DateTime datePromoEnd =
                          dateFormat.parse(_promoEndDate.text);
      
                      if (datePromoEnd.isBefore(datePromoAvail)) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('validation_promo_date'.tr()),
                            backgroundColor: Colors.red,
                          ),
                        );
                      } else {
                        String formatteddatePromoAvail =
                            DateFormat('dd MMMM yyyy').format(datePromoAvail);
                        String formatteddatePromoEnd =
                            DateFormat('dd MMMM yyyy').format(datePromoEnd);
                        String dateAvail =
                            '$formatteddatePromoAvail - $formatteddatePromoEnd';
                        Timestamp timestamp = Timestamp.now();
      
                        //* Add promo announce
                        context.read<AnnounceCubit>().addAnnounce(
                              title: _titleController.text,
                              announce: _announceController.text,
                              dateAvail: dateAvail,
                              image: _imageController.text,
                              timestamp: timestamp,
                            );
                        Navigator.pushNamed(context, '/home-admin');
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('promo_add_success'.tr()),
                            backgroundColor: greenButtonColor,
                          ),
                        );
                      }
                    }
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<Widget> promoCard(int index) async {
    String? title = await AnnounceCubit().getOrderedAnnounceTitle(index);
    String? announce = await AnnounceCubit().getOrderedAnnounceString(index);
    String? dateAvail =
        await AnnounceCubit().getOrderedAnnounceDateAvail(index);
    String? image = await AnnounceCubit().getOrderedAnnounceImage(index);
    Timestamp? timestamp =
        await AnnounceCubit().getOrderedAnnounceTimestamp(index);

    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(
          context, 
          '/promodetail', 
          arguments: {
            'title': title,
            'announce': announce,
            'dateAvail': dateAvail,
            'image': image,
            'timestamp': timestamp,
            // 'index' : index,
          }
        );
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Container(
          width: double.infinity,
          height: 150,
          decoration: BoxDecoration(
            color: whiteColor,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color:
                    isDarkMode ? backgroundColor : Colors.grey.withOpacity(0.5),
                spreadRadius: 1,
                blurRadius: 7,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //* IMAGE
              Center(
                child: Container(
                  margin: const EdgeInsets.only(left: 10),
                  width: 0.3 * MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(defaultRadius),
                    border: Border.all(
                      color: Colors.grey.withOpacity(0.3),
                      width: 1,
                    ),
                  ),
                  child: AspectRatio(
                    aspectRatio: 1 / 1,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(defaultRadius),
                      child: Image.network(
                        image!,
                        width: 0.2 * MediaQuery.of(context).size.width,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
              ),
    
              //* DETAILS
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      //* TITLE
                      Text(
                        title,
                        style: greenTextStyle.copyWith(
                          fontSize: 16,
                          fontWeight: black,
                        ),
                      ),
    
                      //* DESCRIPTION
                      Text(
                        announce,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: greenTextStyle.copyWith(
                          fontSize: 14,
                          fontWeight: light,
                        ),
                      ),
    
                      const SizedBox(height: 8),
    
                      //* PROMO DATE
                      Text(
                        dateAvail,
                        style: orangeTextStyle.copyWith(
                          fontSize: 14,
                          fontWeight: light,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget announceList() {
    return SingleChildScrollView(
      child: Column(
        children: [
          FutureBuilder<int>(
            future: getAnnounceLength(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                //call paymentHeader without using ListView.builder
                return Column(
                  children: [
                    const SizedBox(height: 20,),
                    for (int i = 0; i < snapshot.data!; i++)
                      FutureBuilder<Widget>(
                        future: promoCard(i),
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            return SizedBox(
                              child: Center(
                                child: Column(
                                  children: [
                                    snapshot.data!,
                                    const SizedBox(
                                      height: 10,
                                    ),
                                  ],
                                ),
                              ),
                            );
                          } else {
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          }
                        },
                      ),
                  ],
                );
              } else {
                //return no payments
                return const Center(
                  child: Text('No Announces'),
                );
              }
            },
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        backgroundColor: greenButtonColor,
        automaticallyImplyLeading: true,
        title: Text(
          'Promo',
          style: whiteTextButtonStyle.copyWith(
            fontSize: 18,
            fontWeight: semiBold,
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        bottom: TabBar(
          controller: _tabController,
          indicatorColor: secondaryColor,
          tabs: const [
            Tab(text: 'Add New Promo'),
            Tab(text: 'Promo List'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          addPromoForm(),
          announceList(),
        ],
      ),
    );
  }
}
