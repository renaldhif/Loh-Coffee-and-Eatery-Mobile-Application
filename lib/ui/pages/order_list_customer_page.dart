import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loh_coffee_eatery/models/review_model.dart';
import 'package:loh_coffee_eatery/ui/widgets/custom_rating_card.dart';
import '../../cubit/review_cubit.dart';
import '../../shared/theme.dart';

class OrderListCustomerPage extends StatefulWidget {
  const OrderListCustomerPage({super.key});

  @override
  State<OrderListCustomerPage> createState() => _OrderListCustomerPageState();
}

class _OrderListCustomerPageState extends State<OrderListCustomerPage> {
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

        // Menu Card Content
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
                  Row(
                    children: [
                      // Add to Cart Button
                      Container(
                        width: 0.35 * MediaQuery.of(context).size.width,
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
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            // if isConfirm == false then show status waiting otherwise show status confirmed
                            Text(
                              'STATUS: WAITING',
                              style: mainTextStyle.copyWith(
                                fontSize: 12,
                                fontWeight: medium,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        width: 50,
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
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
                    Padding(
                      padding: const EdgeInsets.only(left: 12),
                      child: Text(
                        'Your Order🍽',
                        style: greenTextStyle.copyWith(
                          fontSize: 28,
                          fontWeight: bold,
                        ),
                      ),
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
