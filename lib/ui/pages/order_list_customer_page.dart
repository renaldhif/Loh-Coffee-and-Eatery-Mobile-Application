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

  bool isOpen = false;
  String diningOption = 'Dine In';
  String paymentStatus = 'Payment confirmed';
  String orderStatus = 'Order confirmed';

  Widget orderContent() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 10),
        Row(
          children: [
            Container(
              height: 0.2 * MediaQuery.of(context).size.width,
              width: 0.2 * MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(defaultRadius),
                border: Border.all(
                  color: Colors.grey.withOpacity(0.3),
                  width: 1,
                ),
              ),
              child: AspectRatio(
                aspectRatio: 1 / 1,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(defaultRadius),
                  //! Change to Image.network
                  child: Image.network(
                    'https://people.com/thmb/igqlUUjQujg8u7SO0g7iOd4GhM0=/1500x0/filters:no_upscale():max_bytes(150000):strip_icc():focal(999x0:1001x2)/hayley-langberg-5-030923-f8794dbd6c684675acde72c96b6f91cf.jpg',
                    width: 0.2 * MediaQuery.of(context).size.width,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Menu Name
                Text(
                  //getOrderName(),
                  // iName,
                  'Food 1',
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  softWrap: false,
                  style: greenTextStyle.copyWith(
                    fontSize: 16,
                    fontWeight: black,
                  ),
                ),
                const SizedBox(height: 5),

                // Menu Price
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

                const SizedBox(height: 5),

                // Quantity
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
              ],
            ),
          ],
        ),
      ],
    );
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
                // crossAxisAlignment: CrossAxisAlignment.start,
                // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
                                Column(
                                  // crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    //*Order Number
                                    Text(
                                      'Order No: 69',
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
                                  ],
                                ),
                              ],
                            ),
                          );
                        }),

                        //* Body Expansion Panel
                        body: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            // spacer line
                            const SizedBox(height: 5),
                            Container(
                              width: 0.8 * MediaQuery.of(context).size.width,
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
                              visible: diningOption == 'Dine In' ? true : false,
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
                              width: 0.8 * MediaQuery.of(context).size.width,
                              height: 5,
                              color: kUnavailableColor,
                            ),

                            //* Order Details
                            orderContent(),
                            orderContent(),
                            orderContent(),

                            const SizedBox(height: 10),

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
                              width: 0.8 * MediaQuery.of(context).size.width,
                              height: 5,
                              color: kUnavailableColor,
                            ),
                          ],
                        ),
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
