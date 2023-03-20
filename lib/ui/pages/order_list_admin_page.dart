import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:animated_icon_button/animated_icon_button.dart';
import 'package:loh_coffee_eatery/cubit/payment_state.dart';
import 'package:loh_coffee_eatery/models/review_model.dart';
import 'package:loh_coffee_eatery/ui/widgets/custom_button.dart';
import 'package:loh_coffee_eatery/ui/widgets/custom_button_white.dart';
import '../../cubit/review_cubit.dart';
import '../../shared/theme.dart';
import '../widgets/custom_button_red.dart';

class OrderListAdminPage extends StatefulWidget {
  const OrderListAdminPage({super.key});

  @override
  State<OrderListAdminPage> createState() => _OrderListAdminPageState();
}

class _OrderListAdminPageState extends State<OrderListAdminPage> {
  @override
  void initState() {
    super.initState();
  }

  String orderStatus = 'Waiting to be confirmed';
  String diningOption = 'Dine In';
  String paymentStatus = 'Payment confirmed';
  bool isOpen = false;
  bool isConfirm = false;

  Widget orderContent() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 10),
        //* Order Name
        Text(
          'Makanan 1',
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
          'Qty: 1',
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          softWrap: false,
          style: greenTextStyle.copyWith(
            fontSize: 14,
            fontWeight: medium,
          ),
        ),
        const SizedBox(height: 10),
      ],
    );
  }

  Widget orderDetailCard() {
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
            // Menu Details
            Expanded(
              child: Column(
                // crossAxisAlignment: CrossAxisAlignment.start,
                // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                    // crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ExpansionPanelList(
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
                                    //*Order Number
                                    Text(
                                      'Order No: 123',
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      softWrap: false,
                                      style: greenTextStyle.copyWith(
                                        fontSize: 14,
                                        fontWeight: black,
                                      ),
                                    ),
                                    const SizedBox(height: 5),

                                    //* Order Date
                                    Text(
                                      '31 February 2023 14:00',
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
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // spacer line
                                const SizedBox(height: 5),
                                Container(
                                  width:
                                      0.8 * MediaQuery.of(context).size.width,
                                  height: 5,
                                  color: kUnavailableColor,
                                ),

                                const SizedBox(height: 10),
                                //* Customer Name
                                Text(
                                  'Customer Name: \${Customer Name}',
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  softWrap: false,
                                  style: greenTextStyle.copyWith(
                                    fontSize: 16,
                                    fontWeight: medium,
                                  ),
                                ),
                                const SizedBox(height: 10),
                                // spacer line
                                const SizedBox(height: 5),
                                Container(
                                  width:
                                      0.8 * MediaQuery.of(context).size.width,
                                  height: 5,
                                  color: kUnavailableColor,
                                ),
                                const SizedBox(height: 10),

                                //* Order Details
                                Text(
                                  'Dining Option: \${Dine In/Takeaway}',
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  softWrap: false,
                                  style: greenTextStyle.copyWith(
                                    fontSize: 16,
                                    fontWeight: medium,
                                  ),
                                ),
                                const SizedBox(height: 10),
                                //* Table Number
                                Visibility(
                                  visible:
                                      diningOption == 'Dine In' ? true : false,
                                  child: Text(
                                    'Table Number: \${1}',
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    softWrap: false,
                                    style: greenTextStyle.copyWith(
                                      fontSize: 16,
                                      fontWeight: medium,
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 5),

                                // spacer line
                                const SizedBox(height: 5),
                                Container(
                                  width:
                                      0.8 * MediaQuery.of(context).size.width,
                                  height: 5,
                                  color: kUnavailableColor,
                                ),
                                //* Order Content
                                orderContent(),
                                orderContent(),
                                // spacer line
                                Container(
                                  width:
                                      0.8 * MediaQuery.of(context).size.width,
                                  height: 5,
                                  color: kUnavailableColor,
                                ),

                                //* TOTAL PRICE
                                const SizedBox(height: 10),
                                Text(
                                  'Total Price:',
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  softWrap: false,
                                  style: greenTextStyle.copyWith(
                                    fontSize: 16,
                                    fontWeight: black,
                                  ),
                                ),
                                const SizedBox(height: 5),
                                Row(
                                  children: [
                                    Text(
                                      'Rp',
                                      style: orangeTextStyle.copyWith(
                                        fontSize: 16,
                                        fontWeight: extraBold,
                                      ),
                                    ),
                                    const SizedBox(width: 5),
                                    Text(
                                      // iPrice.toString(),
                                      '69420',
                                      style: orangeTextStyle.copyWith(
                                        fontSize: 16,
                                        fontWeight: extraBold,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 10),
                                // spacer line
                                const SizedBox(height: 5),
                                Container(
                                  width:
                                      0.8 * MediaQuery.of(context).size.width,
                                  height: 5,
                                  color: kUnavailableColor,
                                ),
                                const SizedBox(height: 10),

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
                                  style: greenTextStyle.copyWith(
                                    fontSize: 14,
                                    fontWeight: medium,
                                  ),
                                ),
                                const SizedBox(height: 10),

                                //* order Status
                                Text(
                                  'Order Status:',
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
                                  orderStatus,
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  softWrap: false,
                                  style: orderStatus == 'Order confirmed'
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
                                  width:
                                      0.8 * MediaQuery.of(context).size.width,
                                  height: 5,
                                  color: kUnavailableColor,
                                ),

                                const SizedBox(height: 15),
                                //* Confirm order button
                                Visibility(
                                  visible: !isConfirm &&
                                      paymentStatus == 'Payment confirmed',
                                  child: CustomButton(
                                      title: 'Confirm order',
                                      onPressed: () {
                                        setState(() {
                                          print('confirm button');
                                          print('isConfirm then: ${isConfirm}');
                                          print(
                                              'pay status then: ${orderStatus}');
                                          isConfirm = true;
                                          orderStatus = 'Order confirmed';
                                          print('isConfirm now: ${isConfirm}');
                                          print(
                                              'pay status now: ${orderStatus}');
                                        });
                                      }),
                                ),
                                const SizedBox(height: 15),

                                //* Reject order button
                                Visibility(
                                  visible: !isConfirm &&
                                      paymentStatus == 'Payment confirmed',
                                  child: CustomButtonRed(
                                    title: 'Reject order',
                                    onPressed: () {
                                      setState(() {
                                        print('reject button');
                                        print('isConfirm then: ${isConfirm}');
                                        print(
                                            'pay status then: ${orderStatus}');
                                        isConfirm = true;
                                        orderStatus = 'Order rejected';
                                        print('isConfirm now: ${isConfirm}');
                                        print('pay status now: ${orderStatus}');
                                      });
                                    },
                                  ),
                                ),
                                // order status
                                const SizedBox(height: 15),
                              ],
                            ),
                          ),
                        ],
                      ),
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
    if (paymentStatus == 'Payment confirmed' && !isConfirm) {
      orderStatus = 'Waiting to be confirmed';
    } else if (paymentStatus == 'Payment confirmed' && isConfirm) {
      if (orderStatus == 'Order confirmed') {
        orderStatus = 'Order confirmed';
      } else if (orderStatus == 'Order rejected') {
        orderStatus = 'Order rejected';
      }
    } else if (paymentStatus == 'Payment rejected') {
      orderStatus = 'Order rejected';
    }
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
                            'Customer Order Lists',
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
              //* Order Cards
              orderDetailCard(),
            ],
          ),
        ),
      ),
    );
  }
}
