import 'dart:async';
import 'dart:io';
import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:image_picker/image_picker.dart';
import 'package:loh_coffee_eatery/cubit/payment_cubit.dart';
import 'package:loh_coffee_eatery/models/menu_model.dart';
import 'package:loh_coffee_eatery/models/order_model.dart';
import 'package:loh_coffee_eatery/ui/widgets/custom_button_white.dart';
import '../../cubit/auth_cubit.dart';
import '../../cubit/order_cubit.dart';
import '../../cubit/payment_state.dart';
import '../../models/payment_model.dart';
import '../../models/user_model.dart';
import '../widgets/custom_button.dart';
import '/shared/theme.dart';
import 'package:path_provider/path_provider.dart';

class PaymentPage extends StatefulWidget {
  String? paymentOption;
  String? diningOption;
  int? totalPrice;
  int? tableNumber;
  PaymentPage(
      {super.key, this.paymentOption, this.diningOption, this.totalPrice,
      this.tableNumber});

  @override
  State<PaymentPage> createState() => _PaymentPageState();
}

Box<MenuModel> localDBBox = Hive.box<MenuModel>('shopping_box');

//get length of order list
  final CollectionReference<Map<String, dynamic>> orderList =
      FirebaseFirestore.instance.collection('orders');

  //method get how many order in orderlist
Future<int> orderLength() async {
    AggregateQuerySnapshot query = await orderList.count().get();
    print('The number of table: ${query.count}');
    return query.count;
  }

  //method convert orderLength return type to int
  int orderLengthInt() {
    int orderLengthInt = 0;
    orderLength().then((value) => orderLengthInt = value);
    return orderLengthInt + 1;
  }

  //method get list of menumodel in localdbbox
  List<MenuModel> getList() {
    List<MenuModel> list = [];
    for (int i = 0; i < localDBBox.length; i++) {
      list.add(localDBBox.getAt(i)!);
    }
    return list;
  }

class _PaymentPageState extends State<PaymentPage> {

late Timer _timer;

@override
  void initState() {
    super.initState();
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      // do something
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }


  bool isUploaded = false;
  String addOn = Timestamp.now().toString();
  String fileName = 'paymentreceipt1.png';
  final TextEditingController _imageController = TextEditingController();

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
      print('failed_upload_image'.tr() + ': $e');
    }


    Reference refStorage =
        FirebaseStorage.instance.ref().child('images/payments/${image!.path}');
    UploadTask uploadTask = refStorage.putFile(image!);
    TaskSnapshot taskSnapshot = await uploadTask.whenComplete(() {
      print(fileName);
    });
    String urlImg = await taskSnapshot.ref.getDownloadURL();
    setState(() {
      isLoading = false;
      _imageController.text = urlImg;
      if (isLoading == false) {
        ScaffoldMessenger.of(context).showSnackBar(
           SnackBar(
            content: Text(
              'success_upload_image'.tr(),
              style: whiteTextButtonStyle
            ),
            backgroundColor: greenButtonColor,
          ),
        );
        setState(() {
          isUploaded = true;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      body: SafeArea(
        child: Container(
          margin: EdgeInsets.all(defaultRadius),
          width: double.infinity,
          child: Column(
            children: [
              Text(
                'payment'.tr(),
                style: greenTextStyle.copyWith(
                  fontSize: 20,
                  fontWeight: bold,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Rp ',
                    style: greenTextStyle.copyWith(
                      fontSize: 24,
                      fontWeight: bold,
                    ),
                  ),
                  Text(
                    widget.totalPrice.toString(),
                    style: greenTextStyle.copyWith(
                      fontSize: 24,
                      fontWeight: bold,
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Text(
                'scan_text'.tr(),
                style: mainTextStyle.copyWith(
                  fontWeight: semiBold,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Image.asset(
                'assets/images/qris.jpg',
                scale: 2.2,
              ),
              const SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 32),
                child: Text(
                  'scan_text_2'.tr(),
                  style: mainTextStyle.copyWith(
                    fontWeight: semiBold,
                  ),
                  textAlign: TextAlign.justify,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Visibility(
                visible: !isUploaded,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                  ),
                  child: CustomButton(
                    title: 'upload_payment_receipt'.tr(),
                    onPressed: () {
                      getImage();
                    },
                  ),
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              Visibility(
                visible: isUploaded,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: BlocConsumer<PaymentCubit, PaymentState>(
                    listener: (context, state) {
                      if (state is PaymentSuccess) {
                        Navigator.pushNamedAndRemoveUntil(context, '/confirmpayment', (route) => false);
                      } else if (state is PaymentFailed) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(state.error),
                            backgroundColor: Colors.red,
                          ),
                        );
                      }
                    },
                    builder: (context, state) {
                      if(state is PaymentLoading){
                        return  Center(
                          child: CircularProgressIndicator(
                            color: primaryColor,
                          ),
                        );
                      }
                      return CustomButton(
                        title: 'confirm_payment'.tr(),
                        onPressed: () async {
                          Timestamp now = Timestamp.now();
                          int num = await orderLength();
                          if (FirebaseAuth.instance.currentUser != null) {
                                User? user = FirebaseAuth.instance.currentUser;
                                UserModel userNow = await context
                                    .read<AuthCubit>()
                                    .getCurrentUser(user!.uid);
                                String? name = userNow.name;
                          
                          if (isUploaded == true) {
                            context.read<PaymentCubit>().addPayment(
                              paymentReceipt: _imageController.text,
                              paymentOption: widget.paymentOption!,
                              diningOption: widget.diningOption!,
                              totalPrice: widget.totalPrice!,
                              status: 'Pending',
                              paymentDateTime: now,
                              customerName: name,
                            );
                            
                            PaymentModel payment = await context.read<PaymentCubit>().getPaymentByTimestamp(paymentDateTime: now);
                            context.read<OrderCubit>().createOrder(
                              number: num + 1,
                              user: userNow,
                              menu: localDBBox.values.toList(),
                              tableNum: widget.tableNumber!,
                              payment: payment,
                              orderStatus: 'Pending',
                              orderDateTime: now
                            );
                            localDBBox.clear();
                            ScaffoldMessenger.of(context).showSnackBar(
                               SnackBar(
                                content: Text(
                                  'payment_uploaded'.tr(),
                                  style: whiteTextButtonStyle
                                ),
                                backgroundColor: greenButtonColor,
                              ),
                            );
                          }
                          }
                        },
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}