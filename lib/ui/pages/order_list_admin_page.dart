import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:animated_icon_button/animated_icon_button.dart';
import 'package:loh_coffee_eatery/models/review_model.dart';
import 'package:loh_coffee_eatery/ui/widgets/custom_button.dart';
import 'package:loh_coffee_eatery/ui/widgets/custom_button_white.dart';
import '../../cubit/review_cubit.dart';
import '../../shared/theme.dart';

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

  Widget orderDetailCard() {
    bool isConfirm = false;
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
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      //*Order Number
                      Text(
                        //getOrderName(),
                        // iName,
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
                        //getOrderName(),
                        // iName,
                        '31 February 2023 14:00',
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        softWrap: false,
                        style: mainTextStyle.copyWith(
                          fontSize: 14,
                          fontWeight: black,
                        ),
                      ),

                      // spacer line
                      const SizedBox(height: 5),
                      Container(
                        width: 0.8 * MediaQuery.of(context).size.width,
                        height: 5,
                        color: kUnavailableColor,
                      ),

                      const SizedBox(height: 20),

                      //TODO: Implement Order Details Cubit
                      //* Order Name
                      Text(
                        //getOrderName(),
                        // iName,
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
                    ],
                  ),
                  const SizedBox(height: 5),

                  Text(
                    //getOrderName(),
                    // iName,
                    'Qty: 1',
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    softWrap: false,
                    style: greenTextStyle.copyWith(
                      fontSize: 14,
                      fontWeight: medium,
                    ),
                  ),
                  const SizedBox(height: 20),

                  // spacer line
                  const SizedBox(height: 5),
                  Container(
                    width: 0.8 * MediaQuery.of(context).size.width,
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
                    width: 0.8 * MediaQuery.of(context).size.width,
                    height: 5,
                    color: kUnavailableColor,
                  ),

                  // order status
                  const SizedBox(height: 15),

                  // Confirm Order Button
                  SizedBox(
                      width: 0.8 * MediaQuery.of(context).size.width,
                      height: 40,
                      child: isConfirm
                      ? CustomButtonWhite(
                          title: 'Order Confirmed',
                          onPressed: () {},
                        )
                      : CustomButton(
                          title: 'Confirm Order',
                          onPressed: () {
                            setState(() {
                              isConfirm = true;
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
                            'Customer Order Details',
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
