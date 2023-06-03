import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:loh_coffee_eatery/models/table_model.dart';
import 'package:loh_coffee_eatery/services/table_service.dart';
import 'package:loh_coffee_eatery/services/user_service.dart';
import 'package:loh_coffee_eatery/ui/widgets/custom_button_red.dart';
import '../../cubit/auth_cubit.dart';
import '../../cubit/reservation_cubit.dart';
import '../../cubit/table_cubit.dart';
import '../../models/reservation_model.dart';
import '../../models/user_model.dart';
import '/shared/theme.dart';
import 'package:loh_coffee_eatery/ui/widgets/custom_button.dart';
import 'package:loh_coffee_eatery/ui/widgets/custom_textformfield.dart';
import 'dart:io';

class ReservationPage extends StatefulWidget {
  const ReservationPage({super.key});

  @override
  State<ReservationPage> createState() => _ReservationPageState();
}

// need include SingleTickerProviderStateMixin
class _ReservationPageState extends State<ReservationPage>
    with SingleTickerProviderStateMixin {
  // TextEditingControllers
  final TextEditingController _tableNumController = TextEditingController();
  final TextEditingController _timeController = TextEditingController();
  final TextEditingController _numOfPeopleController = TextEditingController();
  final TextEditingController _locationController = TextEditingController();
  final TextEditingController _dateInputController = TextEditingController();

  late TabController _tabController;
  late Future<List<int>> _tableNumberFuture;
  int? _tableNumber;
  int? _sizeOfPeople;
  String? _location;

  int _deletedIndex = -1;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _tableNumberFuture = context.read<TableCubit>().getAvailableTableNumbers();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  final CollectionReference<Map<String, dynamic>> reserveList =
      FirebaseFirestore.instance.collection('reservations');

  Future<int> getReservationListLength() async {
    AggregateQuerySnapshot query = await reserveList
        .orderBy('dateCreated', descending: true)
        .count()
        .get();

    return query.count;
  } // sudah work

  //get reservation id list by customer email
  Future<List<String>> getReservationIds2(String email) async {
    QuerySnapshot<Map<String, dynamic>> querySnapshot = await reserveList
        .orderBy('dateCreated', descending: true)
        .where('customerEmail', isEqualTo: email)
        .get();
    // QuerySnapshot<Map<String, dynamic>> querySnapshot =
    //     await reserveList.where('customerEmail', isEqualTo: email).get();
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

    return dateCreated2;
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

  //get index by reservation id
  Future<int> getIndexByReservationId(String reservationId) async {
    final User? user = FirebaseAuth.instance.currentUser;
    final String id = user!.uid;
    UserModel userModel = await context.read<AuthCubit>().getCurrentUser(id);

    String email = userModel.email;
    List<String> reserveIDList = await getReservationIds2(email);
    int index = reserveIDList.indexOf(reservationId);
    return index;
  }

  //call the reservationHistoryCard() widget while looping through the list of reservations length
  Widget reservationHistoryList() {
    return FutureBuilder<int>(
      future: getReservationListLength2(),
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
          return Center(
            child: Text('no_reservation'.tr()),
          );
        }
      },
    );
  }

  Future<Widget> reservationHistCard(int index) async {
    final User? user = FirebaseAuth.instance.currentUser;
    final String id = user!.uid;
    UserModel userModel = await context.read<AuthCubit>().getCurrentUser(id);
    String email = userModel.email;
    getReservationIds2(email);

    List<String> reserveIDList = await getReservationIds2(email);
    if (index < 0 || index >= reserveIDList.length) {
      // If the index is out of range, return an empty Container
      return Container();
    }
    String reservationId = reserveIDList[index];

    DocumentSnapshot<Map<String, dynamic>> documentSnapshot = await reserveList.doc(reservationId).get();
    if (!documentSnapshot.exists) {
        return Text('Document does not exist');
    }

    Map<String, dynamic> data = documentSnapshot.data()!;
    ReservationModel reservation = ReservationModel.fromJson(reservationId, data);
    
    String date = reservation.date;
    String time = reservation.time;
    String location = reservation.location;
    int tableNumber = reservation.tableNum;
    int numOfPeople = reservation.sizeOfPeople;
    Timestamp dateCreated = reservation.dateCreated;
    String dateCreated2 = dateCreated.toDate().toString().substring(0, 19);
    bool isCanceled = false;

    DateFormat dateFormat = DateFormat('dd-MM-yyyy HH:mm');
    String combinedString = '$date $time';
    DateTime dateTimeConvert = dateFormat.parse(combinedString);

    // Get the current date and time in the local timezone
    DateTime dtNow = DateTime.now().toLocal();
    bool isAfterReserveDate = dtNow.isAfter(dateTimeConvert);

    return Visibility(
      visible: isCanceled == false,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Container(
          width: double.infinity,
          height: 200,
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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
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
                                'date'.tr() + ': ',
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
                                'time'.tr() + ':',
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
                      Visibility(
                        visible: isAfterReserveDate == false,
                        child: SizedBox(
                          width: MediaQuery.of(context).size.width * 0.2,
                          height: 40,
                          child: CustomButtonRed(
                            title: 'cancel'.tr(),
                            fontSize: 16,
                            onPressed: () async {
                              setState(() {
                                context.read<ReservationCubit>().cancelReservation(reservationId);
                                // FirebaseFirestore.instance
                                //     .collection('reservations')
                                //     .doc(reservationId)
                                //     .delete();
                                    
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    backgroundColor: greenButtonColor,
                                    content: Text('Reservation cancelled!'),
                                    duration: Duration(seconds: 3),
                                  ),
                                );
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
                  //* Table Number
                  Row(
                    children: [
                      const SizedBox(
                        width: 20,
                      ),
                      Text(
                        'table_number'.tr() + ':',
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
                        'number_of_people'.tr() + ':',
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
                        'location'.tr() + ':',
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
                    'reservation_created'.tr() + ':',
                    style: mainTextStyle.copyWith(
                      fontSize: 14,
                      fontWeight: medium,
                    ),
                  ),
                  const Spacer(),
                  Text(
                    '$dateCreated2',
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
      ),
    );
  }

  Widget reservationForm() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Header
        Container(
          width: double.infinity,
          margin: const EdgeInsets.only(top: 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Text(
                  'reservation_form'.tr(),
                  style: greenTextStyle.copyWith(
                    fontSize: 24,
                    fontWeight: semiBold,
                  ),
                ),
              ),
              const SizedBox(height: 30),
            ],
          ),
        ),

        //* Reservation Date
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'reservation_date'.tr(),
                style: greenTextStyle.copyWith(
                  fontSize: 18,
                  fontWeight: bold,
                ),
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: _dateInputController,
                keyboardType: TextInputType.datetime,
                readOnly: true,
                style: mainTextStyle.copyWith(
                  fontSize: 16,
                  fontWeight: medium,
                ),
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
                      _dateInputController.text = formattedDate;
                    }
                  } else if (pickedDate != null) {
                    var formatDate = DateTime.parse(pickedDate.toString());
                    var formattedDate = formatDate.toString().isEmpty
                        ? ""
                        : "${formatDate.day}-${formatDate.month}-${formatDate.year}";
                    _dateInputController.text = formattedDate;
                  } else {
                    _dateInputController.text = "";
                  }
                },
                decoration: InputDecoration(
                  suffixIcon: Icon(
                    Icons.calendar_today,
                    color: primaryColor,
                  ),
                  labelText: 'reservation_date'.tr(),
                  labelStyle: mainTextStyle.copyWith(
                    fontSize: 16,
                    fontWeight: medium,
                  ),
                  hintText: 'enter_reservation_date'.tr(),
                  hintStyle: mainTextStyle.copyWith(
                    fontSize: 16,
                    fontWeight: medium,
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

        //* Reservation Time
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              Text(
                'reservation_time'.tr() + '(10 AM - 9 PM)',
                style: greenTextStyle.copyWith(
                  fontSize: 18,
                  fontWeight: bold,
                ),
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: _timeController,
                keyboardType: TextInputType.datetime,
                readOnly: true,
                style: mainTextStyle.copyWith(
                  fontSize: 16,
                  fontWeight: medium,
                ),
                onTap: () async {
                  TimeOfDay? pickedTime = await showTimePicker(
                    context: context,
                    initialTime: TimeOfDay.now(),
                    builder: (context, child) {
                      return FittedBox(
                        child: Theme(
                          data: isDarkMode
                              ? ThemeData.dark().copyWith(
                                  colorScheme: ColorScheme.dark(
                                    primary: primaryColor,
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
                  if (pickedTime != null) {
                    var formatTime = TimeOfDay(
                        hour: pickedTime.hour, minute: pickedTime.minute);
                    var formattedTime =
                        "${formatTime.hour.toString().padLeft(2, '0')}:${formatTime.minute.toString().padLeft(2, '0')}";

                    // Check if formattedTime is not empty before setting the controller text
                    if (formattedTime.isNotEmpty) {
                      _timeController.text = formattedTime;
                    }
                  } else if (pickedTime != null) {
                    var formatTime = TimeOfDay(
                        hour: pickedTime.hour, minute: pickedTime.minute);
                    var formattedTime = formatTime.toString().isEmpty
                        ? ""
                        : "${formatTime.hour.toString().padLeft(2, '0')}:${formatTime.minute.toString().padLeft(2, '0')}";
                    _timeController.text = formattedTime;
                  } else {
                    _timeController.text = "";
                  }
                },
                decoration: InputDecoration(
                  suffixIcon: Icon(
                    Icons.access_time,
                    color: primaryColor,
                  ),
                  labelText: 'reservation_time'.tr(),
                  labelStyle: mainTextStyle.copyWith(
                    fontSize: 16,
                    fontWeight: medium,
                  ),
                  hintText: 'enter_reservation_time'.tr(),
                  hintStyle: mainTextStyle.copyWith(
                    fontSize: 16,
                    fontWeight: medium,
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

        const SizedBox(height: 20),

        //* Table Number Available Dropdown
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'table_number_available'.tr(),
                style: greenTextStyle.copyWith(
                  fontSize: 18,
                  fontWeight: bold,
                ),
              ),
              const SizedBox(height: 10),
              FutureBuilder<List<int>>(
                future: _tableNumberFuture,
                builder:
                    (BuildContext context, AsyncSnapshot<List<int>> snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const CircularProgressIndicator();
                  } else if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  } else {
                    final tableNumbers = snapshot.data ?? [];
                    return DropdownButtonFormField(
                      dropdownColor: whiteColor,
                      focusColor: primaryColor,
                      menuMaxHeight: 200,
                      isExpanded: false,
                      value: _tableNumber,
                      items: tableNumbers.map((tableNumber) {
                        return DropdownMenuItem(
                          value: tableNumber,
                          child: Text(
                            tableNumber.toString(),
                            style: greenTextStyle.copyWith(
                              fontSize: 16,
                            ),
                          ),
                        );
                      }).toList(),
                      onChanged: (value) async {
                        if (value != null) {
                          setState(() {
                            _tableNumber = value;
                            _tableNumController.text = value.toString();
                          });

                          int tableSize = await context
                              .read<TableCubit>()
                              .getTableSizeByTableNumber(value);
                          String tableLocation = await context
                              .read<TableCubit>()
                              .getTableLocationByTableNumber(value);

                          setState(() {
                            _sizeOfPeople = tableSize;
                            _location = tableLocation;

                            _numOfPeopleController.text = tableSize.toString();
                            _locationController.text = tableLocation;
                          });
                        }
                      },
                      decoration: InputDecoration(
                        labelText: 'tap_to_get_table'.tr(),
                        labelStyle: mainTextStyle.copyWith(
                          fontSize: 16,
                          fontWeight: medium,
                        ),
                        hintText: 'tap_to_get_table'.tr(),
                        hintStyle: mainTextStyle.copyWith(
                          fontSize: 16,
                          fontWeight: medium,
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
                    );
                  }
                },
              ),
            ],
          ),
        ),

        const SizedBox(
          height: 10,
        ),

        _sizeOfPeople != null
            ? Center(
                child: Text(
                  'size_of_people'.tr() + ': $_sizeOfPeople',
                  style: greenTextStyle.copyWith(
                    fontSize: 16,
                    fontWeight: semiBold,
                  ),
                ),
              )
            : const SizedBox.shrink(),

        const SizedBox(
          height: 10,
        ),

        _location != null
            ? Center(
                child: Text(
                  'location'.tr() + ': $_location',
                  style: greenTextStyle.copyWith(
                    fontSize: 16,
                    fontWeight: semiBold,
                  ),
                ),
              )
            : const SizedBox.shrink(),

        //* Reserve Now Button
        Padding(
          padding: const EdgeInsets.fromLTRB(20, 35, 20, 70),
          child: CustomButton(
            title: 'reserve_now.'.tr(),
            onPressed: () async {
              //* Validate date
              String dateInputted = _dateInputController.text;
              if (dateInputted.isEmpty) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('please_select_date'.tr()),
                    backgroundColor: Colors.red,
                  ),
                );
                return;
              }
              DateTime dateTime = DateFormat('dd-MM-yyyy').parse(dateInputted);
              if (dateTime.isBefore(DateTime.now())) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('please_input_future_date_time'.tr()),
                    backgroundColor: Colors.red,
                  ),
                );
                return; // Exit the function if input is invalid
              }

              //* Validate time
              String timeInputted = _timeController.text;
              if (timeInputted.isEmpty) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('please_select_reservation_time'.tr()),
                    backgroundColor: Colors.red,
                  ),
                );
                return; // Exit the function if input is invalid
              }
              DateTime now = DateTime.now();
              DateTime selectedDateTime = DateTime(
                now.year,
                now.month,
                now.day,
                int.tryParse(timeInputted.split(':')[0]) ??
                    0, // Extract hour from input string
                int.tryParse(timeInputted.split(':')[1]) ??
                    0, // Extract minute from input string
              );
              if (selectedDateTime
                      .isBefore(DateTime(now.year, now.month, now.day, 10)) ||
                  selectedDateTime
                      .isAfter(DateTime(now.year, now.month, now.day, 21))) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('please_select_time_between'.tr()),
                    backgroundColor: Colors.red,
                  ),
                );
                return; // Exit the function if input is invalid
              }

              if (_tableNumController.text.contains(RegExp(r'[a-zA-Z]')) ||
                  _numOfPeopleController.text.contains(RegExp(r'[a-zA-Z]'))) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('validation_table_number'.tr()),
                    backgroundColor: Colors.red,
                  ),
                );
              }

              if (_dateInputController.text.isEmpty ||
                  _timeController.text.isEmpty ||
                  _tableNumController.text.isEmpty ||
                  _numOfPeopleController.text.isEmpty ||
                  _locationController.text.isEmpty) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('validation_all_field'.tr()),
                    backgroundColor: Colors.red,
                  ),
                );
              } else {
                if (FirebaseAuth.instance.currentUser != null) {
                  User? user = FirebaseAuth.instance.currentUser;
                  UserModel userNow =
                      await context.read<AuthCubit>().getCurrentUser(user!.uid);
                  String? customerName = userNow.name;
                  String? customerEmail = userNow.email;

                  context.read<ReservationCubit>().addReservation(
                        customerName: customerName,
                        customerEmail: customerEmail,
                        date: _dateInputController.text,
                        time: _timeController.text,
                        tableNum: int.parse(_tableNumController.text),
                        sizeOfPeople: int.parse(_numOfPeopleController.text),
                        location: _locationController.text,
                        dateCreated: Timestamp.now(),
                      );
                  context
                      .read<ReservationCubit>()
                      .updateTableIsBooked(int.parse(_tableNumController.text));

                  Navigator.pushNamed(context, '/reservation-success');
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('reservation_success'.tr()),
                      backgroundColor: greenButtonColor,
                    ),
                  );
                }
              }
            },
          ),
        ),
      ],
    );
  }

  Widget reservationHistory() {
    return Container(
      color: backgroundColor,
      child: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 20,
            ),
            Text(
              'your_reservation_history'.tr(),
              style: greenTextStyle.copyWith(
                fontSize: 18,
                fontWeight: semiBold,
              ),
            ),
            const SizedBox(
              height: 20,
            ),

            //* Reservation History
            reservationHistoryList(),
          ],
        ),
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
          'reservation'.tr(),
          style: whiteTextButtonStyle.copyWith(
            fontSize: 18,
            fontWeight: semiBold,
            letterSpacing: 1.5,
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
          tabs: [
            Tab(text: 'form'.tr()),
            Tab(text: 'history'.tr()),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          reservationForm(),
          reservationHistory(),
        ],
      ),
    );
  }
}
