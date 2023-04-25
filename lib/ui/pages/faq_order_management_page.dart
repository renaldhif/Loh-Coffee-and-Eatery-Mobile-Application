import 'package:flutter/material.dart';
import 'package:loh_coffee_eatery/ui/widgets/custom_faq_card.dart';
import '/shared/theme.dart';

class FAQOrderManagement extends StatelessWidget {
  const FAQOrderManagement({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
        child: Container(
          color: backgroundColor,
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 30), 
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
              const SizedBox(height: 20), 
              Center(
                child: Text(
                  'Ordering Food', 
                  style: greenTextStyle.copyWith(
                    fontSize: 22, 
                    fontWeight: bold,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    SizedBox(height: 20),
                    // Q1
                    CustomFAQCard(
                      question: 'Can I view the menu in the Loh Coffee and Eatery application?', 
                      answer: 'Yes, you can view the menu in the application by going to the "Home Page" which can be accessed through tapping the bottom navigation.'
                    ),
                    SizedBox(height: 20),
                    // Q2
                    CustomFAQCard(
                      question: 'How do I place an order in the Loh Coffee and Eatery mobile application?', 
                      answer: 'To place an order in the Loh Coffee and Eatery mobile application, go to the "Home" page, select the menu you want to order by tapping add to cart. Then, go to the "Cart" page by tapping on cart button in the bottom right corner. After that, select for the dining option and payment option, and tap "Pay Now".'
                    ),
                    SizedBox(height: 20),
                    // Q3
                    CustomFAQCard(
                      question: 'Can I cancel an order in the Loh Coffee and Eatery application?',
                      answer: 'No, you cannot cancel an order in the Loh Coffee and Eatery application. You can only cancel an order before it is confirmed by the administrator. Once the order is confirmed, you will not be able to cancel it.'
                    ),
                    SizedBox(height: 20),
                    // Q4
                    CustomFAQCard(
                      question: 'What dining options are available in the Loh Coffee and Eatery mobile application?',
                      answer: 'There are two dining options available in the Loh Coffee and Eatery mobile application: Dine in and Takeaway.',
                    ),
                    SizedBox(height: 20),
                    // Q5
                    CustomFAQCard(
                      question: 'What payment options are available in the Loh Coffee and Eatery mobile application?',
                      answer: 'There are two payment options available in the Loh Coffee and Eatery mobile application: QRIS and Pay at the Cashier.',
                    ),
                    SizedBox(height: 20),
                    // Q6
                    CustomFAQCard(
                      question: 'What is QRIS payment option?',
                      answer: 'The QRIS payment option provides the customer with a barcode to scan and make payment for their order using their phone. The payment is done outside the application, and the customer must upload their payment receipt to the Loh Coffee and Eatery mobile application for the administrator to accept or reject the payment.',
                    ),
                    SizedBox(height: 20),
                    // Q7
                    CustomFAQCard(
                      question: 'How does the QRIS payment option work?',
                      answer: 'To use the QRIS payment option, the customer must select the QRIS option at checkout and receive a barcode to scan for payment. They must then make the payment outside the application and upload the payment receipt to the Loh Coffee and Eatery mobile application. The administrator will review the payment receipt and either accept or reject the payment.',
                    ),
                    SizedBox(height: 20),
                    // Q8
                    CustomFAQCard(
                      question: 'What happens if the administrator rejects a QRIS payment?',
                      answer: 'If the administrator rejects a QRIS payment, the customer order\'s status will be automatically canceled. The customer will be informed by the staff and the customer have to re-order.',
                    ),
                    SizedBox(height: 20),
                    // Q9
                    CustomFAQCard(
                      question: 'Can I use E-wallet for QRIS payment?',
                      answer: 'Yes, you can use an E-wallet for QRIS payment, as long as the payment is accepted by the QRIS provider. Please check with your payment provider for more information.',
                    ),
                    SizedBox(height: 20),
                    // 10
                    CustomFAQCard(
                      question: 'What is Pay at the Cashier payment option?',
                      answer: 'The Pay at the Cashier payment option requires the customer to go to the cashier manually to pay for their order. They can place their order in the mobile application and select the Pay at Cashier option at the cart page.',
                    ),
                    SizedBox(height: 20),
                    // 11
                    CustomFAQCard(
                      question: 'Where can I find the order history in the Loh Coffee and Eatery mobile application?',
                      answer: 'You can find your order history in the Loh Coffee and Eatery mobile application by going to the "Order List" page which can be accessed through tapping the bottom navigation.',
                    ),
                    SizedBox(height: 20),
                    // 12
                    CustomFAQCard(
                      question: 'What to do if I have completed my payment?',
                      answer: 'If you have completed your payment, The administrator will review the payment receipt and either accept or reject the payment. If the payment is accepted, the order status will be changed to "Confirmed" and the customer wait for the order to be delivered.',
                    ),
                    SizedBox(height: 20),
                    // 13
                    CustomFAQCard(
                      question: 'My payment is confirmed but my order status is rejected?',
                      answer: 'If your payment is confirmed but your order status is rejected, it means that the order is rejected. It is possible that the order is rejected because the menu is not available at the moment. You will be informed by the staff and you can re-order.',
                    ),
                    SizedBox(height: 20),
                    // 14
                    CustomFAQCard(
                      question: 'What if I choose to take away my order?',
                      answer: 'If you choose to take away your order, just need to wait for the order to be ready and the staff will call you to pick up your order.',
                    ),
                    SizedBox(height: 50),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}