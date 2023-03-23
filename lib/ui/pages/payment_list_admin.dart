import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:animated_icon_button/animated_icon_button.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:loh_coffee_eatery/cubit/payment_cubit.dart';
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

  bool isConfirm = false;
  // String paymentStatus = 'Waiting to be confirmed';
  bool isOpen = false;

  //method to get payments by lopping through paymentLength and combine with paymentTiles
  Widget payments() {
    return FutureBuilder<int>(
      future: paymentLength(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          //call paymentTiles without using ListView.builder
          return Column(
            children: [
              for (int i = 0; i < snapshot.data!; i++)
                FutureBuilder<Widget>(
                  future: paymentTiles(i),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return snapshot.data!;
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

  Future<Widget> paymentTiles(int index) async {
    String name = await getCustomerNameByIndex(index);
    String time = await getTimeByIndex(index);
    String paymentReceipt = await getPaymentReceiptByIndex(index);
    String paymentStatus = await getPaymentStatusByIndex(index);

    return ExpansionPanelList(
      animationDuration: const Duration(milliseconds: 500),
      dividerColor: kUnavailableColor,
      elevation: 0,
      expansionCallback: (int index, bool isExpanded) {
        setState(() {
          isOpen = !isOpen;
        });
      },
      children: [
        //* Header Expansion Panel
        ExpansionPanel(
          isExpanded: isOpen,
          canTapOnHeader: true,
          headerBuilder: ((context, isExpanded) {
            return Center(
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
                ],
              ),
            );
          }),

          //* Body Expansion Panel
          body: Column(
            children: [
              // spacer line
              const SizedBox(height: 5),
              Container(
                width: 0.8 * MediaQuery.of(context).size.width,
                height: 5,
                color: kUnavailableColor,
              ),

              const SizedBox(height: 20),
              // payment image
              //! Change to NetworkImage
              Visibility(
                visible: paymentReceipt != 'none',
                child: Container(
                  width: 0.8 * MediaQuery.of(context).size.width,
                  height: 0.3 * MediaQuery.of(context).size.height,
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
                  child: Center(
                    child: Image.network(
                      paymentReceipt,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 20),
              //* Payment Status
              Text(
                'Payment Status:',
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
                paymentStatus,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                softWrap: false,
                style: paymentStatus == 'Payment confirmed'
                    ? greenTextStyle.copyWith(
                        fontSize: 14,
                        fontWeight: medium,
                      )
                    : orangeTextStyle.copyWith(
                        fontSize: 14,
                        fontWeight: bold,
                      ),
              ),
              const SizedBox(height: 10),
              // spacer line
              const SizedBox(height: 5),
              Container(
                width: 0.8 * MediaQuery.of(context).size.width,
                height: 5,
                color: kUnavailableColor,
              ),

              // order status
              const SizedBox(height: 15),
              //* Confirm payment button
              Visibility(
                visible: !isConfirm,
                child: BlocConsumer<PaymentCubit, PaymentState>(
                  listener: (context, state) {
                    // TODO: implement listener
                    if (state is PaymentSuccess) {
                      print('payment success');
                    } else if (state is PaymentFailed) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(state.error),
                          backgroundColor: Colors.red,
                        ),
                      );
                    }
                  },
                  builder: (context, state) {
                    return CustomButton(
                        title: 'Confirm payment',
                        onPressed: () {
                          setState(() {
                            print('confirm button');
                            print('isConfirm then: ${isConfirm}');
                            print('pay status then: ');
                            isConfirm = true;
                            context
                                .read<PaymentCubit>()
                                .changePaymentStatusByIndex(
                                  index: index,
                                  status: 'Confirmed',
                                );

                            // paymentStatus = 'Payment confirmed';
                            print('isConfirm now: ');
                            print('pay status now: ');
                          });
                        });
                  },
                ),
              ),
              const SizedBox(height: 15),

              //* Reject payment button
              Visibility(
                visible: !isConfirm,
                child: BlocConsumer<PaymentCubit, PaymentState>(
                  listener: (context, state) {
                    // TODO: implement listener
                    if (state is PaymentSuccess) {
                      print('payment success');
                    } else if (state is PaymentFailed) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(state.error),
                          backgroundColor: Colors.red,
                        ),
                      );
                    }
                  },
                  builder: (context, state) {
                    return CustomButtonRed(
                      title: 'Reject payment',
                      onPressed: () {
                        setState(() {
                          print('reject button');
                          print('isConfirm then: ${isConfirm}');
                          print('pay status then: ');
                          isConfirm = true;
                          // paymentStatus = 'Payment rejected';
                          context
                                .read<PaymentCubit>()
                                .changePaymentStatusByIndex(
                                  index: index,
                                  status: 'Rejected',
                                );

                          print('isConfirm now: ');
                          print('pay status now: ');
                        });
                      },
                    );
                  },
                ),
              ),
              const SizedBox(height: 10),
            ],
          ),
        ),
      ],
    );
  }

  Widget paymentDetailCard() {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 3, horizontal: 9),
      width: 0.9 * MediaQuery.of(context).size.width,
      // height: double.infinity,
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

        //* Menu Card Content
        child: Row(
          children: [
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                // crossAxisAlignment: CrossAxisAlignment.start,
                // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      payments(),
                      const SizedBox(height: 10),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          color: whiteColor,
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
                      icon: const Icon(
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
                          icons: const <AnimatedIconItem>[
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
              paymentDetailCard(),
            ],
          ),
        ),
      ),
    );
  }
}
