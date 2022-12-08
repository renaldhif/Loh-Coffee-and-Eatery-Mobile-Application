import 'package:flutter/material.dart';
import 'package:loh_coffee_eatery/shared/theme.dart';

class HomePageAdmin extends StatefulWidget {
  const HomePageAdmin({super.key});

  @override
  State<HomePageAdmin> createState() => _HomePageAdminState();
}

class _HomePageAdminState extends State<HomePageAdmin> {

  // To change the selected value of bottom navigation bar
  int _selectedIndex = 0;
  void _changeSelectedIndex(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              // Header
              Container(
                margin: EdgeInsets.all(defaultRadius),
                width: double.infinity,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Filter Menu',
                      style: greenTextStyle.copyWith(
                        fontSize: 22,
                        fontWeight: black,
                      ),
                    ),
                    const SizedBox(height: 15),
                  ],
                ),
              ),

              // Menu List
              Container(
                margin: const EdgeInsets.fromLTRB(12, 0, 12, 0),
                width: double.infinity,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Menu Card
                    Container(
                      margin: const EdgeInsets.symmetric(
                        vertical: 5,
                      ),
                      width: 0.9 * MediaQuery.of(context).size.width,
                      height: 130,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(defaultRadius),
                        border: Border.all(
                          color: kUnavailableColor,
                          width: 1,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.3),
                            spreadRadius: 3,
                            blurRadius: 7,
                            offset: const Offset(1, 3),
                          ),
                        ],
                        color: whiteColor,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),

                        // Menu Card Content
                        child: Row(
                          children: [
                            // Image
                            ClipRRect(
                              borderRadius:
                                  BorderRadius.circular(defaultRadius),
                              child: Image.asset(
                                'assets/images/login_page.png',
                                width: 0.3 * MediaQuery.of(context).size.width,
                                fit: BoxFit.cover,
                              ),
                            ),
                            const SizedBox(width: 10),
                            // Menu Details
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Paket Ayam Bakar dengan Saus BBQ dan Es Teh Manis',
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    softWrap: false,
                                    style: greenTextStyle.copyWith(
                                      fontSize: 16,
                                      fontWeight: black,
                                    ),
                                  ),
                                  const SizedBox(height: 5),
                                  Text(
                                    'Chicken, Rice, Spicy, Tea',
                                    style: greenTextStyle.copyWith(
                                      fontSize: 14,
                                      fontWeight: light,
                                    ),
                                  ),
                                  const SizedBox(height: 5),
                                  Text(
                                    'Rp 69.000',
                                    style: orangeTextStyle.copyWith(
                                      fontSize: 16,
                                      fontWeight: extraBold,
                                    ),
                                  ),
                                  // Menu Card Button
                                  const Spacer(),
                                  Row(
                                    children: [
                                      // Add to Cart Button
                                      Container(
                                        width: 0.4 *
                                            MediaQuery.of(context).size.width,
                                        height: 30,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(5),
                                          border: Border.all(
                                            color: primaryColor,
                                            width: 1,
                                          ),
                                          color: whiteColor,
                                        ),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            const Icon(
                                              Icons.add,
                                              color: primaryColor,
                                            ),
                                            const SizedBox(width: 5),
                                            Text(
                                              'Add to Cart',
                                              style: greenTextStyle.copyWith(
                                                fontSize: 12,
                                                fontWeight: extraBold,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      const Spacer(),
                                      // Favorite Button
                                      const SizedBox(
                                        width: 30,
                                        height: 30,
                                        child: Icon(
                                          Icons.favorite_border,
                                          color: primaryColor,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
          items: const [
            //* TODO: Change into Admin Navigation Bar
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.calendar_month_rounded),
              label: 'Reserve',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.format_list_bulleted_rounded),
              label: 'Order List',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.notifications_rounded),
              label: 'Notification',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: 'Profile',
            ),
          ],
          type: BottomNavigationBarType.fixed,
          currentIndex: _selectedIndex,
          selectedItemColor: primaryColor,
          unselectedItemColor: greyColor,
          showUnselectedLabels: true,
          onTap: _changeSelectedIndex),
    );
  }
}
