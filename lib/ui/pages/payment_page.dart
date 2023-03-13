import 'dart:io';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:loh_coffee_eatery/ui/widgets/custom_button_white.dart';
import '../widgets/custom_button.dart';
import '/shared/theme.dart';
import 'package:path_provider/path_provider.dart';

class PaymentPage extends StatefulWidget {
  int? totalPrice;
  PaymentPage({super.key, this.totalPrice});

  @override
  State<PaymentPage> createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  // Initial value
  bool isUploaded = false;
  String fileName = 'paymentreceipt.png';

  // To change the selected value of bottom navigation bar
  int _selectedIndex = 0;
  void _changeSelectedIndex(int index) {
    setState(() {
      _selectedIndex = index;
      switch (index) {
        // case 1:
        //   Navigator.pushNamed(context, '/addmenu');
        //   break;
        // case 2:
        //   Navigator.pushNamed(context, '/home-admin');
        //   break;
        // case 3:
        //   Navigator.pushNamed(context, '/notification');
        //   break;
        case 4:
          Navigator.pushNamed(context, '/profilemenu');
          _selectedIndex = 0;
          break;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          margin: EdgeInsets.all(defaultRadius),
          width: double.infinity,
          child: Column(
            children: [
              Text(
                'Payment',
                style: greenTextStyle.copyWith(
                  fontSize: 20,
                  fontWeight: bold,
                ),
              ),

              const SizedBox(height: 20,),
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
                'Scan the QRIS code below to pay your order',
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
                  'After you scan the QRIS code, please attach the payment receipt to process your order.',
                  style: mainTextStyle.copyWith(
                    fontWeight: semiBold,
                  ),
                  textAlign: TextAlign.justify,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                ),
                child: CustomButton(
                  title: 'Upload Payment Receipt',
                  //TODO: Implement upload payment receipt
                  onPressed: () {},
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              CustomButtonWhite(
                title: '$fileName',
                //TODO: Implement name of the file
                onPressed: (){},
              ),
              
              // if (isUploaded)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: CustomButton(
                  title: 'Confirm Payment', onPressed: () {
                    Navigator.pushNamedAndRemoveUntil(context, '/confirmpayment', (route) => false);
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