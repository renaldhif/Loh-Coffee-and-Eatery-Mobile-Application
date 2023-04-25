import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:animated_icon_button/animated_icon_button.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:loh_coffee_eatery/cubit/payment_cubit.dart';
import 'package:loh_coffee_eatery/ui/pages/payment_details_page.dart';
import 'package:loh_coffee_eatery/ui/widgets/custom_button.dart';
import 'package:loh_coffee_eatery/ui/widgets/custom_button_red.dart';
import 'package:loh_coffee_eatery/ui/widgets/custom_button_white.dart';
import '../../cubit/payment_state.dart';
import '../../models/payment_model.dart';
import '../../shared/theme.dart';

class PaymentListAdminPage extends StatefulWidget {
  const PaymentListAdminPage({super.key});

  @override
  State<PaymentListAdminPage> createState() => _PaymentListAdminPageState();
}

class _PaymentListAdminPageState extends State<PaymentListAdminPage> {
  @override
  void initState() {
    context.read<PaymentCubit>().getPayments();
    super.initState();
  }

  final CollectionReference<Map<String, dynamic>> paymentList =
      FirebaseFirestore.instance.collection('payments');

  Future<int> paymentLength() async {
    AggregateQuerySnapshot query = await paymentList.count().get();
    print('The number of payment: ${query.count}');
    return query.count;
  }

  Future<List<DateTime>> paymentDateTimeList() async {
    QuerySnapshot<Map<String, dynamic>> snapshot = await paymentList.get();
    List<QueryDocumentSnapshot<Map<String, dynamic>>> docs = snapshot.docs;
    List<DateTime> paymentDateTimeList = [];
    for (var doc in docs) {
      Timestamp paymentTimestamp = doc['paymentDateTime'];
      DateTime paymentDateTime = paymentTimestamp.toDate();
      paymentDateTimeList.add(paymentDateTime);
    }
    return paymentDateTimeList;
  }

  Future<List<DateTime>> sortedPaymentDateTimeList() async {
    List<DateTime> paymentDateTimeList2 = await paymentDateTimeList();
    paymentDateTimeList2.sort();
    for (int i = 0; i < paymentDateTimeList2.length; i++) {
      print(paymentDateTimeList2[i]);
    }
    return paymentDateTimeList2;
  }

  // Future<int> sortedPaymentDateTimeList() async {
  //   List<DateTime> paymentDateTimeList2 = await paymentDateTimeList();
  //   // paymentDateTimeList2.sort();
  //   // for (int i = 0; i < paymentDateTimeList2.length; i++) {
  //   //   print(paymentDateTimeList2[i]);
  //   // }
  //   paymentDateTimeList2.sort();
  //   return paymentDateTimeList2.length;
  // }

//sortedPayemntDateTime length
  Future<int> sortedPaymentDateTimeLength() async {
    List<DateTime> paymentDateTimeList3 = await sortedPaymentDateTimeList();
    int length = paymentDateTimeList3.length;
    return length;
  }

  //-----------------------

  //getCustomerNameByIndex string from paymentCubit
  Future<String> getCustomerNameByIndex(int index) async {
    String name =
        await context.read<PaymentCubit>().getCustomerNameByIndex(index: index);
    print('Customer Name: $name');
    return name.toString();
  }

  //getTimeByIndex string from paymentCubit
  Future<String> getTimeByIndex(int index) async {
    Timestamp time =
        (await context.read<PaymentCubit>().getTimestampByIndex(index: index));
    DateTime dateTime =
        DateTime.fromMillisecondsSinceEpoch(time.millisecondsSinceEpoch);
    DateFormat dateFormat = DateFormat('dd-MM-yyyy HH:mm:ss');
    String formattedTime = dateFormat.format(dateTime);

    return formattedTime;
  }

//getPaymentReceiptByIndex string from paymentCubit
  Future<String> getPaymentReceiptByIndex(int index) async {
    String paymentReceipt = await context
        .read<PaymentCubit>()
        .getPaymentReceiptByIndex(index: index);
    print('Payment Receipt: $paymentReceipt');
    return paymentReceipt.toString();
  }

// get payment status from paymentCubit
  Future<String> getPaymentStatusByIndex(int index) async {
    String paymentStatus = await context
        .read<PaymentCubit>()
        .getPaymentStatusByIndex(index: index);
    print('Payment Status: $paymentStatus');
    return paymentStatus.toString();
  }

  Future<int> getTotalPriceByIndex(int index) async {
    int totalPrice =
        (await context.read<PaymentCubit>().getTotalPriceByIndex(index: index));
    print('Total Price: $totalPrice');
    return totalPrice;
  }

  //get payment by index
  Future<PaymentModel> getPaymentByIndex(int index) async {
    PaymentModel payment =
        await context.read<PaymentCubit>().getPaymentByIndex(index: index);
    print('Payment: $payment');
    return payment;
  }

  bool isConfirm = false;
  // String paymentStatus = 'Waiting to be confirmed';
  bool isOpen = false;

  //method to get payments by lopping through paymentLength and combine with paymentTiles
  Widget payments() {
    return FutureBuilder<int>(
      future: sortedPaymentDateTimeLength(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          //call paymentHeader without using ListView.builder
          return Column(
            children: [
              for (int i = 0; i < snapshot.data!; i++)
                FutureBuilder<Widget>(
                  future: paymentHeader(i),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return Container(
                          width: 0.8 * MediaQuery.of(context).size.width,
                          margin: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: whiteColor,
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.1),
                                spreadRadius: 1,
                                blurRadius: 1,
                                offset: const Offset(0, 1),
                              ),
                            ],
                          ),
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
          return const Center(
            child: Text('No Payments'),
          );
        }
      },
    );
  }

  Future<Widget> paymentHeader(int index) async {
    String name = await getCustomerNameByIndex(index);
    String time = await getTimeByIndex(index);
    int paymentTotalPrice = await getTotalPriceByIndex(index);
    String paymentReceipt = await getPaymentReceiptByIndex(index);
    String paymentStatus = await getPaymentStatusByIndex(index);
    // PaymentModel payment = await getPaymentByIndex(index);

    // sortedPaymentDateTimeList();
    sortedPaymentDateTimeList();

    return GestureDetector(
      onTap: () {
        setState(() {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => PaymentDetailsPage(
                index: index,
              ),
            ),
          );
        });
      },
      child: Center(
        child: Column(
          children: [
            //* Customer Name
            Text(
              'Customer Name: $name',
              style: greenTextStyle.copyWith(
                fontSize: 14,
                fontWeight: semiBold,
              ),
            ),
            //* Payment Date
            Text(
              'Payment Date: $time',
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              softWrap: false,
              style: mainTextStyle.copyWith(
                fontSize: 14,
                fontWeight: black,
              ),
            ),
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      body: SingleChildScrollView(
        child: Container(
          color: backgroundColor,
          width: double.infinity,
          child: Column(
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
                      icon:  Icon(
                        Icons.arrow_circle_left_rounded,
                        color: primaryColor,
                        size: 55,
                      ),
                    ),
                    const SizedBox(height: 30),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 12),
                          child: Text(
                            'Payment Details',
                            style: greenTextStyle.copyWith(
                              fontSize: 26,
                              fontWeight: bold,
                            ),
                          ),
                        ),

                        //* REFRESH BUTTON
                        AnimatedIconButton(
                          size: 26,
                          onPressed: () {
                            setState(() {});
                          },
                          duration: const Duration(seconds: 1),
                          splashColor: Colors.transparent,
                          icons:  <AnimatedIconItem>[
                            AnimatedIconItem(
                              icon: Icon(Icons.refresh, color: primaryColor),
                            ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                  ],
                ),
              ), // Header End

              //* Payment Cards
              payments(),
              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }
}
