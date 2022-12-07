import 'package:flutter/material.dart';
import 'package:loh_coffee_eatery/shared/theme.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
 // Initial Selected Value
  String dropdownvalue = 'All Menu';  
  // List of items in our dropdown menu
  var items = [   
    'All Menu',
    'Based on your preferences',
    'Based on most loved menu'
  ];

  // To change the selected value of bottom navigation bar
  int _selectedIndex = 0;  
  void _changeSelectedIndex(int index) {
    setState(() {
      _selectedIndex = index;
      switch(index){
        // case 1:
        //   Navigator.pushNamed(context, '/reserve');
        //   break;
        // case 2:
        //   Navigator.pushNamed(context, '/order');
        //   break;
        // case 3:
        //   Navigator.pushNamed(context, '/notification');
        //   break;
        case 4:
          Navigator.pushReplacementNamed(context, '/profilemenu');
          break;
      }
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
                  children:[ 
                    Text(
                      'Filter Menu', 
                      style: greenTextStyle.copyWith(
                        fontSize: 22, 
                        fontWeight: black,
                      ),
                    ),
                    const SizedBox(height: 15),
                    // Dropdown Menu
                    Padding(
                      padding: const EdgeInsets.fromLTRB(24, 0, 24, 0),
                      child: DropdownButton(
                        value: dropdownvalue,
                        icon: const Icon(
                          Icons.keyboard_arrow_down,
                          color: primaryColor,
                        ),   
                        items: items.map((String items) {
                          return DropdownMenuItem(
                            value: items,
                            child: Text(items),
                          );
                        }).toList(),
                        onChanged: (String? newValue) {
                          setState(() {
                            dropdownvalue = newValue!;
                          });
                        },
                        isExpanded: true,
                        underline: Container(
                          height: 1,
                          color: primaryColor,
                        ),
                      ),
                    ),
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
                      margin: const EdgeInsets.symmetric(vertical: 3,),
                      width: 0.9 * MediaQuery.of(context).size.width,
                      height: 140,
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
                            ClipRRect (
                              borderRadius: BorderRadius.circular(defaultRadius),
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
                                        width: 0.4 * MediaQuery.of(context).size.width,
                                        height: 25,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(5),
                                          border: Border.all(
                                            color: primaryColor,
                                            width: 1,
                                          ),
                                          color: whiteColor,
                                        ),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
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
                                      const SizedBox(width: 12,),
                                      // Favorite Button
                                      const Icon(
                                        Icons.favorite_border_rounded,
                                        color: primaryColor,
                                        size: 30,
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
        onTap: _changeSelectedIndex
      ),
    );
  }
}