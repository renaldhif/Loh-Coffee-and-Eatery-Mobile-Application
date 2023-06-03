import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:loh_coffee_eatery/cubit/announce_cubit.dart';
import 'package:loh_coffee_eatery/models/announce_model.dart';
import 'package:loh_coffee_eatery/shared/theme.dart';

import '../../services/announce_service.dart';

class PromoPage extends StatefulWidget {
  const PromoPage({super.key});

  @override
  State<PromoPage> createState() => _PromoPageState();
}

class _PromoPageState extends State<PromoPage> {
  // To change the selected value of bottom navigation bar
  int _selectedIndex = 3;
  void _changeSelectedIndex(int index) {
    setState(() {
      _selectedIndex = index;
      switch (index) {
        case 0:
          Navigator.pushReplacementNamed(context, '/home');
          // _selectedIndex = 0;
          break;
        case 1:
          Navigator.pushReplacementNamed(context, '/reservation');
          break;
        case 2:
          Navigator.pushReplacementNamed(context, '/orderlist');
          break;
        // case 3:
        //   Navigator.pushNamed(context, '/notification');
        //   break;
        case 4:
          Navigator.pushReplacementNamed(context, '/profilemenu');
          break;
      }
    });
  }

  List<AnnounceModel> announces = [];

  //get announce length from announce_cubit
  Future<int> getAnnounceLength() async {
    int length = await AnnounceCubit().getOrderedAnnounceLength();
    // print('length: $length');
    return length;
  }

  //get 'announce' title from announce_cubit
  Future<String> getAnnounceTitle(int index) async {
    String title = await AnnounceCubit().getOrderedAnnounceString(index);
    // print('title: $title');
    return title;
  }

  //call the promoCard() widget while looping through the list of announcements
  Widget announceList() {
    return FutureBuilder<int>(
      future: getAnnounceLength(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          //call paymentHeader without using ListView.builder
          return Column(
            children: [
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
                      ));
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
    );
  }

  Future<Widget> promoCard(int index) async {
    String? title = await AnnounceCubit().getOrderedAnnounceTitle(index);
    String? announce = await AnnounceCubit().getOrderedAnnounceString(index);
    String? dateAvail = await AnnounceCubit().getOrderedAnnounceDateAvail(index);
    String? image = await AnnounceCubit().getOrderedAnnounceImage(index);
    Timestamp? timestamp = await AnnounceCubit().getOrderedAnnounceTimestamp(index);

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
                color: isDarkMode ? backgroundColor : Colors.grey.withOpacity(0.5),
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      body: SafeArea(
        child: SingleChildScrollView(
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
              // Header
              Container(
                margin: const EdgeInsets.only(top: 20),
                // margin: EdgeInsets.all(defaultRadius),
                // padding: const EdgeInsets.only(left: 12),
                width: double.infinity,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 5),
                    Center(
                      child: Text(
                        'limited_time_offer'.tr() + '🎉',
                        style: greenTextStyle.copyWith(
                          fontSize: 26,
                          fontWeight: black,
                        ),
                        textAlign: TextAlign.start,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Center(
                      child: Text(
                        '✨' + 'text_promo'.tr() + '✨',
                        style: greenTextStyle.copyWith(
                          fontSize: 16,
                          fontWeight: medium,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              ),

              //* PROMO CARD
              announceList(),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'nav_home'.tr(),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_month_rounded),
            label: 'nav_reservations'.tr(),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.format_list_bulleted_rounded),
            label: 'nav_orders'.tr(),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.local_post_office_sharp),
            label: 'nav_promo'.tr(),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'nav_profile'.tr(),
          ),
        ],
        backgroundColor: whiteColor,
        type: BottomNavigationBarType.fixed,
        currentIndex: _selectedIndex,
        selectedItemColor: primaryColor,
        unselectedItemColor: greyColor,
        showUnselectedLabels: true,
        onTap: _changeSelectedIndex,
      ),
    );
  }
}
