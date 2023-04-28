// import 'package:flutter/material.dart';
// import 'package:loh_coffee_eatery/shared/theme.dart';

// class PromoAdminPage extends StatefulWidget {
//   const PromoAdminPage({super.key});

//   @override
//   State<PromoAdminPage> createState() => _PromoAdminPageState();
// }

// class _PromoAdminPageState extends State<PromoAdminPage> {
//   // To change the selected value of bottom navigation bar
//   int _selectedIndex = 0;
//   void _changeSelectedIndex(int index) {
//     setState(() {
//       _selectedIndex = index;
//       switch (index) {
//         case 0:
//           Navigator.pushReplacementNamed(context, '/home');
//           break;
//         case 1:
//           Navigator.pushReplacementNamed(context, '/reservation');
//           break;
//         case 2:
//           Navigator.pushReplacementNamed(context, '/orderlist');
//           break;
//         // case 3:
//         //   Navigator.pushNamed(context, '/notification');
//         //   break;
//         case 4:
//           Navigator.pushReplacementNamed(context, '/profilemenu');
//           _selectedIndex = 0;
//           break;
//       }
//     });
//   }



//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SafeArea(
//         child: SingleChildScrollView(
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               IconButton(
//                 onPressed: () {
//                   Navigator.pop(context);
//                 },
//                 icon: Icon(
//                   Icons.arrow_circle_left_rounded,
//                   color: primaryColor,
//                   size: 55,
//                 ),
//               ),
//               // Header
//               Container(
//                 margin: EdgeInsets.all(defaultRadius),
//                 padding: const EdgeInsets.only(left: 12),
//                 width: double.infinity,
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     const SizedBox(height: 5),
//                     Center(
//                       child: Text(
//                         'Limited Time Offers 🎉',
//                         style: greenTextStyle.copyWith(
//                           fontSize: 26,
//                           fontWeight: black,
//                         ),
//                         textAlign: TextAlign.start,
//                       ),
//                     ),
//                     const SizedBox(height: 10),
//                     Center(
//                       child: Text(
//                         '✨ Don\'t Miss Our Exclusive Promotions ✨',
//                         style: greenTextStyle.copyWith(
//                           fontSize: 16,
//                           fontWeight: medium,
//                         ),
//                         textAlign: TextAlign.center,
//                       ),
//                     ),
//                     const SizedBox(height: 20),
//                   ],
//                 ),
//               ),

//               //* PROMO CARD
//               promoCard(),
//             ],
//           ),
//         ),
//       ),
//       bottomNavigationBar: BottomNavigationBar(
//         items: const [
//           BottomNavigationBarItem(
//             icon: Icon(Icons.home),
//             label: 'Home',
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.calendar_month_rounded),
//             label: 'Reserve',
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.format_list_bulleted_rounded),
//             label: 'Order List',
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.local_post_office_sharp),
//             label: 'Promo',
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.person),
//             label: 'Profile',
//           ),
//         ],
//         type: BottomNavigationBarType.fixed,
//         currentIndex: _selectedIndex,
//         selectedItemColor: primaryColor,
//         unselectedItemColor: greyColor,
//         showUnselectedLabels: true,
//         onTap: _changeSelectedIndex,
//       ),
//     );
//   }
// }
