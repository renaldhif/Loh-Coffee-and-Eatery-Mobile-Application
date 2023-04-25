import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import '../../cubit/order_cubit.dart';
import '../../cubit/payment_cubit.dart';
import '../../cubit/payment_state.dart';
import '../widgets/custom_button.dart';
import '../widgets/custom_button_red.dart';
import '/shared/theme.dart';

class PaymentDetailsPage extends StatefulWidget {
  int? index;

  PaymentDetailsPage({super.key, this.index});

  @override
  State<PaymentDetailsPage> createState() => _PaymentDetailsPageState();
}

class _PaymentDetailsPageState extends State<PaymentDetailsPage> {
 
  @override
  void initState() {
    context.read<PaymentCubit>().getPayments();
    super.initState();
  }

  final CollectionReference<Map<String, dynamic>> paymentList =
      FirebaseFirestore.instance.collection('payments');

   Future<int> paymentLength() async {
    AggregateQuerySnapshot query = await paymentList.count().get();
    // print('The number of payment: ${query.count}');
    return query.count;
  }

  //getCustomerNameByIndex string from paymentCubit
  Future<String> getCustomerNameByIndex(int index) async {
    String name =
        await context.read<PaymentCubit>().getCustomerNameByIndex(index: index);
    // print('Customer Name: $name');
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
    // print('Payment Receipt: $paymentReceipt');
    return paymentReceipt.toString();
  }

// get payment status from paymentCubit
  Future<String> getPaymentStatusByIndex(int index) async {
    String paymentStatus = await context
        .read<PaymentCubit>()
        .getPaymentStatusByIndex(index: index);
    // print('Payment Status: $paymentStatus');
    return paymentStatus.toString();
  }

  Future<int> getTotalPriceByIndex(int index) async {
    int totalPrice = (await context
        .read<PaymentCubit>()
        .getTotalPriceByIndex(index: index));
    // print('Total Price: $totalPrice');
    return totalPrice;
  }

  //get timestamp by index
  Future<Timestamp> getTimestampByIndex(int index) async {
    Timestamp time =
        (await context.read<PaymentCubit>().getTimestampByIndex(index: index));
    return time;
  }

  //! Change to String paymentstatus
  bool isConfirm = false;
  // int index = 1;

  Future<Widget> paymentDetails(int index) async {
    String name = await getCustomerNameByIndex(index);
    String time = await getTimeByIndex(index);
    int paymentTotalPrice = await getTotalPriceByIndex(index);
    String paymentReceipt = await getPaymentReceiptByIndex(index);
    String paymentStatus = await getPaymentStatusByIndex(index);
    Timestamp timestamp = await getTimestampByIndex(index);

    isConfirm = paymentStatus == 'Confirmed' || paymentStatus == 'Rejected' ? true : false;

    return Center(
      child: Column(
        children: [
          //* Customer Name
          Text(
            'customer_name'.tr() + ': $name',
            style: greenTextStyle.copyWith(
              fontSize: 16,
              fontWeight: semiBold,
            ),
          ),
          //* Payment Date
          Text(
            'payment_date'.tr() + ': $time',
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            softWrap: false,
            style: mainTextStyle.copyWith(
              fontSize: 16,
              fontWeight: black,
            ),
          ),
          const SizedBox(height: 10),

          Column(
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
                  height: 0.9 * MediaQuery.of(context).size.width,
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

              Visibility(
                visible: paymentReceipt == 'none',
                child: Text(
                  "detail_payment_opt".tr(),
                  style: mainTextStyle.copyWith(
                    fontSize: 14,
                    fontWeight: black,
                  ),
                ),
              ),

              const SizedBox(height: 20),
              //* Payment Status
              Text(
                'total_price'.tr() + ': ',
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
                'Rp ${paymentTotalPrice.toString()}',
                style: greenTextStyle.copyWith(
                  fontSize: 18,
                  fontWeight: bold,
                ),
              ),

              const SizedBox(height: 20),
              //* Payment Status
              Text(
                'payment_status'.tr() + ': ',
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
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 45),
                child: Visibility(
                  visible: !isConfirm,
                  child: BlocConsumer<PaymentCubit, PaymentState>(
                    listener: (context, state) {

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
                          title: 'confirm_payment'.tr(),
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
                              
                               //update in order collection
                              context
                                  .read<OrderCubit>()
                                  .changePaymentStatusByPayment(
                                    orderDateTime: timestamp,
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
              ),
              const SizedBox(height: 15),

              //* Reject payment button
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 45),
                child: Visibility(
                  visible: !isConfirm,
                  child: BlocConsumer<PaymentCubit, PaymentState>(
                    listener: (context, state) {
                      
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
                        title: 'reject_payment'.tr(),
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
                            //update in order collection
                            context
                                .read<OrderCubit>()
                                .changePaymentStatusByPayment(
                                  orderDateTime: timestamp,
                                  status: 'Rejected',
                                );
                            
                            //update order status
                            context.read<OrderCubit>().updateOrderStatusByOrderDateTime(
                              orderDateTime: timestamp,
                              orderStatus: 'Canceled',
                            );
              
                            print('isConfirm now: ');
                            print('pay status now: ');
                          });
                        },
                      );
                    },
                  ),
                ),
              ),
              const SizedBox(height: 70),
            ],
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          color: whiteColor,
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
                      icon: const Icon(
                        Icons.arrow_circle_left_rounded,
                        color: primaryColor,
                        size: 55,
                      ),
                    ),
                  ],
                ),
              ),

              // The detail of the menu selected
              Text(
                'payment_details'.tr(),
                style: greenTextStyle.copyWith(
                  fontSize: 22,
                  fontWeight: black,
                ),
              ),
              const SizedBox(height: 30),

              FutureBuilder<dynamic>(
                future: paymentDetails(widget.index!),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return snapshot.data as Widget;
                  } else if (snapshot.hasError) {
                    return Text('${snapshot.error}');
                  }
                  // Handle other cases
                  return Container();
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
