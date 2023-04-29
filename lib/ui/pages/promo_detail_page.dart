import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:loh_coffee_eatery/main.dart';
import '/shared/theme.dart';

class PromoDetailPage extends StatefulWidget {
  PromoDetailPage({super.key});

  @override
  State<PromoDetailPage> createState() => _PromoDetailPageState();
}

class _PromoDetailPageState extends State<PromoDetailPage> {
  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic> arguments =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;

    final String title = arguments['title'];
    final String announce = arguments['announce'];
    final String dateAvail = arguments['dateAvail'];
    final String image = arguments['image'];
    final Timestamp timestamp = arguments['timestamp'];
    // final int index = arguments['index']; // retrieve the index from the arguments map
    
    DateTime date = timestamp.toDate(); // convert to DateTime
    String timestampFormatted = DateFormat('dd MMMM yyyy').format(date);
    
    return Scaffold(
      backgroundColor: backgroundColor,
      body: SingleChildScrollView(
        child: Container(
          color: backgroundColor,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
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
                      icon: Icon(
                        Icons.arrow_circle_left_rounded,
                        color: primaryColor,
                        size: 55,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 15),

              // The detail of the menu selected
              Text(
                title,
                style: greenTextStyle.copyWith(
                  fontSize: 22,
                  fontWeight: black,
                ),
              ),
              const SizedBox(height: 15),
              // image
              Container(
                width: 0.9 * MediaQuery.of(context).size.width,
                height: 400,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(image),
                    fit: BoxFit.contain,
                  ),
                ),
              ),
              const SizedBox(height: 15),
              // name
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Text(
                  announce,
                  style: greenTextStyle.copyWith(
                    fontSize: 18,
                    fontWeight: medium,
                  ),
                ),
              ),
              const SizedBox(height: 30),
              // price
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Text(
                        'promo_available'.tr() + ': \n$dateAvail',
                        style: orangeTextStyle.copyWith(
                          fontSize: 16,
                          fontWeight: medium,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 30),

              Text(
                'date_posted'.tr() + ': $timestampFormatted',
                style: mainTextStyle.copyWith(
                  fontSize: 16,
                  fontWeight: medium,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }
}
