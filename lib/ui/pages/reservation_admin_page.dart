import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:loh_coffee_eatery/models/table_model.dart';
import 'package:loh_coffee_eatery/services/table_service.dart';
import 'package:loh_coffee_eatery/services/user_service.dart';
import 'package:loh_coffee_eatery/ui/widgets/custom_button_red.dart';
import 'package:loh_coffee_eatery/ui/widgets/custom_button_white.dart';
import '../../cubit/auth_cubit.dart';
import '../../cubit/reservation_cubit.dart';
import '../../cubit/table_cubit.dart';
import '../../models/reservation_model.dart';
import '../../models/user_model.dart';
import '/shared/theme.dart';
import 'package:loh_coffee_eatery/ui/widgets/custom_button.dart';
import 'package:loh_coffee_eatery/ui/widgets/custom_textformfield.dart';
import 'dart:io';

class ReservationAdminPage extends StatefulWidget {
  const ReservationAdminPage({super.key});

  @override
  State<ReservationAdminPage> createState() => _ReservationAdminPageState();
}

class _ReservationAdminPageState extends State<ReservationAdminPage>{

  int _deletedIndex = -1;

  final CollectionReference<Map<String, dynamic>> reserveList =
      FirebaseFirestore.instance.collection('reservations');

  Future<int> getReservationListLength() async {
    AggregateQuerySnapshot query = await 
    reserveList.orderBy('dateCreated', descending: true)
    .count()
    .get();

    return query.count;
  } // sudah work

  //get reservation id by index
  Future<String> getReservationId(int index) async {
    QuerySnapshot<Map<String, dynamic>> querySnapshot =
        await reserveList
        .orderBy('dateCreated', descending: true)
        .get();
    String reservationId = querySnapshot.docs[index].id;

    return reservationId;
  } // sudah work

  //get reservation date by id
  Future<String> getReservationDate(String id) async {
    DocumentSnapshot<Map<String, dynamic>> documentSnapshot =
        await reserveList.doc(id).get();
    Map<String, dynamic> data = documentSnapshot.data()!;
    String date = data['date'];
    return date;
  } // sudah work

  //get reservation time by id
  Future<String> getReservationTime(String id) async {
    DocumentSnapshot<Map<String, dynamic>> documentSnapshot =
        await reserveList.doc(id).get();
    Map<String, dynamic> data = documentSnapshot.data()!;
    String time = data['time'];
    return time;
  } // sudah work

  //get reservation table number by id
  Future<int> getReservationTableNumber(String id) async {
    DocumentSnapshot<Map<String, dynamic>> documentSnapshot =
        await reserveList.doc(id).get();
    Map<String, dynamic> data = documentSnapshot.data()!;
    int tableNumber = data['tableNum'];
    return tableNumber;
  } // sudah work

  //get location by id
  Future<String> getLocation(String id) async {
    DocumentSnapshot<Map<String, dynamic>> documentSnapshot =
        await reserveList.doc(id).get();
    Map<String, dynamic> data = documentSnapshot.data()!;
    String location = data['location'];
    return location;
  } // sudah work

  //get customer name by id
  Future<String> getCustomerName(String id) async {
    DocumentSnapshot<Map<String, dynamic>> documentSnapshot =
        await reserveList.doc(id).get();
    Map<String, dynamic> data = documentSnapshot.data()!;
    String customerName = data['customerName'];
    return customerName;
  } // sudah work

  //get customer email by id
  Future<String> getCustomerEmail(String id) async {
    DocumentSnapshot<Map<String, dynamic>> documentSnapshot =
        await reserveList.doc(id).get();
    Map<String, dynamic> data = documentSnapshot.data()!;
    String customerEmail = data['customerEmail'];
    return customerEmail;
  } // sudah work

  //get size of people by id
  Future<int> getSizeOfPeople(String id) async {
    DocumentSnapshot<Map<String, dynamic>> documentSnapshot =
        await reserveList.doc(id).get();
    Map<String, dynamic> data = documentSnapshot.data()!;
    int sizeOfPeople = data['sizeOfPeople'];
    return sizeOfPeople;
  } // sudah work

  //get date created by id  
  Future<String> getDateCreated(String id) async {
    DocumentSnapshot<Map<String, dynamic>> documentSnapshot =
        await reserveList.doc(id).get();
    Map<String, dynamic> data = documentSnapshot.data()!;
    Timestamp dateCreated = data['dateCreated'];
    //convert timestamp to string and the time to three digits
    String dateCreated2 = dateCreated.toDate().toString().substring(0, 19);
    //convert date format from yyyy-MM-dd hh:mm to dd MM yyyy hh:mm
    // DateTime dateTime = DateTime.parse(dateCreated2);
    DateTime dateTime = DateTime.parse(dateCreated2).toLocal();
    String formattedDate = DateFormat('dd-MM-yyyy HH:mm').format(dateTime);

    // print('dateCreated: $formattedDate');
    return formattedDate;
  } // sudah work


  //get reservation id list by customer email
  Future<List<String>> getReservationIds2(String email) async {
    QuerySnapshot<Map<String, dynamic>> querySnapshot =
        await reserveList.where('customerEmail', isEqualTo: email).get();
    List<String> reservationIds = [];
    for (int i = 0; i < querySnapshot.docs.length; i++) {
      reservationIds.add(querySnapshot.docs[i].id);
    }
    return reservationIds;
  } // sudah work

  //get length
  Future<int> getReservationListLength2() async {
    final User? user = FirebaseAuth.instance.currentUser;
    final String id = user!.uid;
    UserModel userModel = await context.read<AuthCubit>().getCurrentUser(id);
    String email = userModel.email;
    List<String> reserveIDList = await getReservationIds2(email);
    int length = reserveIDList.length;

    return length;
  }

  //get date by index
  Future<String> getDateByIndex(int index) async {
    final User? user = FirebaseAuth.instance.currentUser;
    final String id = user!.uid;
    UserModel userModel = await context.read<AuthCubit>().getCurrentUser(id);
    String email = userModel.email;
    List<String> reserveIDList = await getReservationIds2(email);
    DocumentSnapshot<Map<String, dynamic>> documentSnapshot =
        await reserveList.doc(reserveIDList[index]).get();
    Map<String, dynamic> data = documentSnapshot.data()!;
    String date = data['date'];

    return date;
  }

  //get time by index
  Future<String> getTimeByIndex(int index) async {
    final User? user = FirebaseAuth.instance.currentUser;
    final String id = user!.uid;
    UserModel userModel = await context.read<AuthCubit>().getCurrentUser(id);
    String email = userModel.email;
    List<String> reserveIDList = await getReservationIds2(email);
    DocumentSnapshot<Map<String, dynamic>> documentSnapshot =
        await reserveList.doc(reserveIDList[index]).get();
    Map<String, dynamic> data = documentSnapshot.data()!;
    String time = data['time'];

    return time;
  }

  //get location by index
  Future<String> getLocationByIndex(int index) async {
    final User? user = FirebaseAuth.instance.currentUser;
    final String id = user!.uid;
    UserModel userModel = await context.read<AuthCubit>().getCurrentUser(id);
    String email = userModel.email;
    List<String> reserveIDList = await getReservationIds2(email);
    DocumentSnapshot<Map<String, dynamic>> documentSnapshot =
        await reserveList.doc(reserveIDList[index]).get();
    Map<String, dynamic> data = documentSnapshot.data()!;
    String location = data['location'];

    return location;
  }

  //get table number by index
  Future<int> getTableNumberByIndex(int index) async {
    final User? user = FirebaseAuth.instance.currentUser;
    final String id = user!.uid;
    UserModel userModel = await context.read<AuthCubit>().getCurrentUser(id);
    String email = userModel.email;
    List<String> reserveIDList = await getReservationIds2(email);
    DocumentSnapshot<Map<String, dynamic>> documentSnapshot =
        await reserveList.doc(reserveIDList[index]).get();
    Map<String, dynamic> data = documentSnapshot.data()!;
    int tableNumber = data['tableNum'];

    return tableNumber;
  }

  //get number of people by index
  Future<int> getNumOfPeopleByIndex(int index) async {
    final User? user = FirebaseAuth.instance.currentUser;
    final String id = user!.uid;
    UserModel userModel = await context.read<AuthCubit>().getCurrentUser(id);
    String email = userModel.email;
    List<String> reserveIDList = await getReservationIds2(email);
    DocumentSnapshot<Map<String, dynamic>> documentSnapshot =
        await reserveList.doc(reserveIDList[index]).get();
    Map<String, dynamic> data = documentSnapshot.data()!;
    int numOfPeople = data['sizeOfPeople'];

    return numOfPeople;
  }

  //get date created by index
  Future<String> getDateCreatedByIndex(int index) async {
    final User? user = FirebaseAuth.instance.currentUser;
    final String id = user!.uid;
    UserModel userModel = await context.read<AuthCubit>().getCurrentUser(id);
    String email = userModel.email;
    List<String> reserveIDList = await getReservationIds2(email);
    DocumentSnapshot<Map<String, dynamic>> documentSnapshot =
        await reserveList.doc(reserveIDList[index]).get();
    Map<String, dynamic> data = documentSnapshot.data()!;
    Timestamp dateCreated = data['dateCreated'];
    //convert timestamp to string and the time to three digits
    String dateCreated2 = dateCreated.toDate().toString().substring(0, 19);
    //convert date format from yyyy-MM-dd hh:mm to dd MM yyyy hh:mm
    DateTime dateTime = DateTime.parse(dateCreated2);
    String formattedDate = DateFormat('dd-MM-yyyy hh:mm').format(dateTime);

    // print('dateCreated: $formattedDate');
    return formattedDate;
  }

  //get reservatio id by index
  Future<String> getReservationIdByIndex(int index) async {
    final User? user = FirebaseAuth.instance.currentUser;
    final String id = user!.uid;
    UserModel userModel = await context.read<AuthCubit>().getCurrentUser(id);
    String email = userModel.email;
    List<String> reserveIDList = await getReservationIds2(email);
    String reservationId = reserveIDList[index];

    return reservationId;
  }


  //call the reservationHistoryCard() widget while looping through the list of reservations length
  Widget reservationHistoryList() {
    return FutureBuilder<int>(
      future: getReservationListLength(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          //call paymentHeader without using ListView.builder
          return Column(
            children: [
              for (int i = 0; i < snapshot.data!; i++)
                if (i != _deletedIndex) 
                FutureBuilder<Widget>(
                  future: reservationHistCard(i),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return SizedBox(
                          child: Center(
                        child: Column(
                          children: [
                            const SizedBox(
                              height: 20,
                            ),
                            snapshot.data!,
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
            child: Text('No Reservations'),
          );
        }
      },
    );
  }

  Future<Widget> reservationHistCard(int index) async {
    String id = await getReservationId(index);
    String date = await getReservationDate(id);
    String time = await getReservationTime(id);
    String location = await getLocation(id);
    int tableNumber = await getReservationTableNumber(id);
    int numOfPeople = await getSizeOfPeople(id);
    String dateCreated = await getDateCreated(id);
    String custName = await getCustomerName(id);
    String custEmail = await getCustomerEmail(id);

    // String reservationId = await getReservationIdByIndex(index);
    bool isDone = false;

    DateFormat dateFormat = DateFormat('dd-MM-yyyy HH:mm');
    String combinedString = '$date $time';
    DateTime dateTimeConvert = dateFormat.parse(combinedString);

    // Get the current date and time in the local timezone
    DateTime dtNow = DateTime.now().toLocal();
    bool isAfterReserveDate = dtNow.isAfter(dateTimeConvert);

    // if the current date and time is after the reservation date and time, 
    //then the reservation is done
    if (isAfterReserveDate) {
      isDone = true;
      context.read<ReservationCubit>().doneReservation(id);
    }

    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: whiteColor,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: isDarkMode? backgroundColor : Colors.grey.withOpacity(0.5),
                spreadRadius: 1,
                blurRadius: 7,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 10,
              ),

              //* HEADER
              Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          //* Date
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(
                                width: 20,
                              ),
                              Text(
                                'Date: ',
                                style: greenTextStyle.copyWith(
                                  fontSize: 14,
                                  fontWeight: semiBold,
                                ),
                              ),
                              const SizedBox(
                                width: 20,
                              ),
                              Text(
                                '$date',
                                style: greenTextStyle.copyWith(
                                  fontSize: 14,
                                  fontWeight: semiBold,
                                ),
                              ),
                            ],
                          ),

                          const SizedBox(
                            height: 10,
                          ),

                          //* TIME
                          Row(
                            children: [
                              const SizedBox(
                                width: 20,
                              ),
                              Text(
                                'Time:',
                                style: greenTextStyle.copyWith(
                                  fontSize: 14,
                                  fontWeight: semiBold,
                                ),
                              ),
                              const SizedBox(
                                width: 20,
                              ),
                              Text(
                                '$time',
                                style: greenTextStyle.copyWith(
                                  fontSize: 14,
                                  fontWeight: semiBold,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      const Spacer(),
                      
                      // Done Button
                      Visibility(
                        visible: isAfterReserveDate == false,
                        child: isDone ? SizedBox.shrink() : SizedBox(
                          width: MediaQuery.of(context).size.width * 0.35,
                          height: 40,
                          child: CustomButtonWhite(
                            title: 'On Going',
                            fontSize: 14,
                            onPressed: () {
                              setState(() {
                                context.read<ReservationCubit>().doneReservation(id);
                                isDone = true;
                              });
                            },
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                    ],
                  ),
                ],
              ),

              const SizedBox(
                height: 10,
              ),

              //* Spacer
              const SizedBox(
                height: 2,
                child: Divider(
                  color: Colors.grey,
                ),
              ),

              const SizedBox(
                height: 10,
              ),

              //* BODY
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  //* Customer Details
                  //Customer Name
                  Row(
                    children: [
                      const SizedBox(
                        width: 20,
                      ),
                      Text(
                        'Customer Name:',
                        style: greenTextStyle.copyWith(
                          fontSize: 14,
                          fontWeight: semiBold,
                        ),
                      ),
                      const Spacer(),
                      Text(
                        custName,
                        style: greenTextStyle.copyWith(
                          fontSize: 14,
                          fontWeight: semiBold,
                        ),
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  //Customer Email
                  Row(
                    children: [
                      const SizedBox(
                        width: 20,
                      ),
                      Text(
                        'Customer Email:',
                        style: greenTextStyle.copyWith(
                          fontSize: 14,
                          fontWeight: semiBold,
                        ),
                      ),
                      const Spacer(),
                      Expanded(
                        child: Text(
                          custEmail,
                          style: greenTextStyle.copyWith(
                            fontSize: 14,
                            fontWeight: semiBold,
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  //Spacer
                  const SizedBox(
                    height: 2,
                    child: Divider(
                      color: Colors.grey,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  //* Table Number
                  Row(
                    children: [
                      const SizedBox(
                        width: 20,
                      ),
                      Text(
                        'Table Number:',
                        style: greenTextStyle.copyWith(
                          fontSize: 14,
                          fontWeight: semiBold,
                        ),
                      ),
                      const Spacer(),
                      Text(
                        '$tableNumber',
                        style: greenTextStyle.copyWith(
                          fontSize: 14,
                          fontWeight: semiBold,
                        ),
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),

                  //* Number of People
                  Row(
                    children: [
                      const SizedBox(
                        width: 20,
                      ),
                      Text(
                        'Number of People:',
                        style: greenTextStyle.copyWith(
                          fontSize: 14,
                          fontWeight: semiBold,
                        ),
                      ),
                      const Spacer(),
                      Text(
                        '$numOfPeople',
                        style: greenTextStyle.copyWith(
                          fontSize: 14,
                          fontWeight: semiBold,
                        ),
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),

                  //* Location
                  Row(
                    children: [
                      const SizedBox(
                        width: 20,
                      ),
                      Text(
                        'Location:',
                        style: greenTextStyle.copyWith(
                          fontSize: 14,
                          fontWeight: semiBold,
                        ),
                      ),
                      const Spacer(),
                      Text(
                        '$location',
                        style: greenTextStyle.copyWith(
                          fontSize: 14,
                          fontWeight: semiBold,
                        ),
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                ],
              ),

              //* Spacer
              const SizedBox(
                height: 2,
                child: Divider(
                  color: Colors.grey,
                ),
              ),

              const SizedBox(
                height: 10,
              ),

              //* Date created
              Row(
                children: [
                  const SizedBox(
                    width: 20,
                  ),
                  Text(
                    'Reservation Created:',
                    style: mainTextStyle.copyWith(
                      fontSize: 14,
                      fontWeight: medium,
                    ),
                  ),
                  const Spacer(),
                  Text(
                    '$dateCreated',
                    style: mainTextStyle.copyWith(
                      fontSize: 14,
                      fontWeight: medium,
                    ),
                    textAlign: TextAlign.right,
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                ],
              ),

              const SizedBox(
                height: 10,
              ),
            ],
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
              const SizedBox(
                height: 20,
              ),
              Center(
                child: Text(
                  'Customer\'s Reservation History',
                  style: greenTextStyle.copyWith(
                    fontSize: 24,
                    fontWeight: semiBold,
                  )
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              reservationHistoryList(),
            ],
          ),
        ),
      ),
    );
  }
}
