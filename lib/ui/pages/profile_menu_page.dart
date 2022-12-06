import 'package:flutter/material.dart';
import '/shared/theme.dart';

class ProfileMenuPage extends StatelessWidget {
  const ProfileMenuPage ({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: whiteColor,
        elevation: 1,
        toolbarHeight: 100, //CHECK
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_circle_left_rounded,
            color: primaryColor,
            size: 55,
          ),
        ),
          bottom: PreferredSize(
             child: Container(
               color: Colors.white,
                child: Column(
                  children: [
                    const Text(
                      'Profile Menu',
                      style: TextStyle(
                        color: primaryColor,
                        fontSize: 40,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ]
                ),
             ),
         preferredSize: Size.fromHeight(50),
      ),
      ),
      body: Container(
        color: kUnavailableColor,
        child: ListView(
          children: [
            //profile detail
            const SizedBox(height: 15),
            Container(
              padding: EdgeInsets.only(top:15,left: 15),
              width: double.infinity,
                  height: 80,
                  decoration: BoxDecoration(
                    color: whiteColor,
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(defaultRadius),
                      bottomRight: Radius.circular(defaultRadius),
                    ),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      CircleAvatar(
                        backgroundImage: const AssetImage('assets/images/landing_page.png'),
                        backgroundColor: Colors.grey[400],
                        radius: 30, //size
                        ),
                      SizedBox(width: 20),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Renaldhi Fahrezi',
                            style: mainTextStyle.copyWith(
                              fontSize: 20,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          Padding(padding: EdgeInsets.only(top: 5)),
                          Text(
                            'renaldhifahrezi48@gmail.com',
                            style: mainTextStyle.copyWith(
                              fontSize: 15,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(width: 70),
                      IconButton(
                        onPressed: () {
                          Navigator.pushNamed(context, '/profile');
                        },
                        icon: const Icon(
                          Icons.arrow_forward_ios_rounded,
                          color: primaryColor,
                          size: 30,
                        ),
                      ),
                    ],
                      
                      
                    ),
                    
                  
                  ),
            //),
            const SizedBox(height: 25),
            //container???
            Container(
              color: whiteColor,
              child: Row(
                //mainAxisAlignment:MainAxisAlignment.spaceBetween,
                children: const [
                  Icon(
                    Icons.edit,
                    size: 30,
                  ),
                  SizedBox(width: 20),
                  Text(
                    "Edit Preferences",
                    style: TextStyle(
                      color: primaryColor,
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                      
                    ),
                    textAlign: TextAlign.start,
                  ),
                  SizedBox(width:150),
                  Icon(
                    Icons.arrow_forward,
                    color: primaryColor,
                    size: 55,
                  ),
                ],
              ),
            ),
            Container(
              color: whiteColor,
              child: Row(
                //mainAxisAlignment:MainAxisAlignment.spaceBetween,
                children: const [
                  Icon(
                    Icons.edit,
                    size: 30,
                  ),
                  SizedBox(width: 20),
                  Text(
                    "Submit Review",
                    style: TextStyle(
                      color: primaryColor,
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                      
                    ),
                    textAlign: TextAlign.start,
                  ),
                  SizedBox(width:150),
                  Icon(
                    Icons.arrow_forward,
                    color: primaryColor,
                    size: 55,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      );
    
  }
}