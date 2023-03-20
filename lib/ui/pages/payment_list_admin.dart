import 'package:flutter/material.dart';
import 'package:animated_icon_button/animated_icon_button.dart';
import 'package:loh_coffee_eatery/ui/widgets/custom_button.dart';
import 'package:loh_coffee_eatery/ui/widgets/custom_button_red.dart';
import 'package:loh_coffee_eatery/ui/widgets/custom_button_white.dart';
import '../../shared/theme.dart';

class PaymentListAdminPage extends StatefulWidget {
  const PaymentListAdminPage({super.key});

  @override
  State<PaymentListAdminPage> createState() => _PaymentListAdminPageState();
}

class _PaymentListAdminPageState extends State<PaymentListAdminPage> {
  @override
  void initState() {
    super.initState();
  }

  bool isConfirm = false;
  String paymentStatus = 'Waiting to be confirmed';
  bool isOpen = false;

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
                                    //* Customer Name
                                    Text(
                                      'Customer Name: \${Customer Name}',
                                      style: greenTextStyle.copyWith(
                                        fontSize: 14,
                                        fontWeight: semiBold,
                                      ),
                                    ),
                                    //* Payment Date
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
                                Container(
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
                                  child: const Center(
                                    child: Text('Network Image Receipt'),
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
                                  child: CustomButton(
                                      title: 'Confirm payment',
                                      onPressed: () {
                                        setState(() {
                                          print('confirm button');
                                          print('isConfirm then: ${isConfirm}');
                                          print('pay status then: ${paymentStatus}');
                                          isConfirm = true;
                                          paymentStatus = 'Payment confirmed';
                                          print('isConfirm now: ${isConfirm}');
                                          print('pay status now: ${paymentStatus}');
                                        });
                                      }),
                                ),
                                const SizedBox(height: 15),

                                //* Reject payment button
                                Visibility(
                                  visible: !isConfirm,
                                  child: CustomButtonRed(
                                    title: 'Reject payment',
                                    onPressed: () {
                                      setState(() {
                                        print('reject button');
                                        print('isConfirm then: ${isConfirm}');
                                        print('pay status then: ${paymentStatus}');
                                        isConfirm = true;
                                        paymentStatus = 'Payment rejected';
                                        print('isConfirm now: ${isConfirm}');
                                        print('pay status now: ${paymentStatus}');
                                      });
                                    },
                                  ),
                                ),
                                const SizedBox(height: 10),
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
