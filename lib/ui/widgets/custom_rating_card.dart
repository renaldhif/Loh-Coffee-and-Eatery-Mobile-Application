import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../models/review_model.dart';
import '/shared/theme.dart';

class CustomRatingCard extends StatelessWidget {
  // final ReviewModel review;
  final String username, email, review;
  final double rating;
  final DateTime date;

  const CustomRatingCard(
      // this.review, {
      {
    super.key,
    required this.username,
    required this.email,
    required this.review,
    required this.rating,
    required this.date,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(
        vertical: 10,
      ),
      width: 0.9 * MediaQuery.of(context).size.width,
      height: 180,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(defaultRadius),
        border: Border.all(
          color: primaryColor,
          width: 0.5,
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
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        child: Row(
          children: [
            // Content
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      //* HEADER
                      // Username
                      Text(
                        username,
                        style: greenTextStyle.copyWith(
                          fontSize: 18,
                          fontWeight: bold,
                        ),
                      ),

                      // Rating
                      Row(
                        children: [
                          const Icon(
                            Icons.star,
                            color: primaryColor,
                          ),
                          const SizedBox(width: 5,),
                          Text(
                            rating.toString(),
                            style: mainTextStyle.copyWith(
                              fontSize: 14,
                              fontWeight: regular,
                            ),
                          ),
                          const SizedBox(width: 10,),
                        ],
                      ),
                    ],
                  ),

                  // Email
                  Text(
                    email,
                    style: mainTextStyle.copyWith(
                      fontSize: 14,
                      fontWeight: medium,
                    ),
                  ),
                  const SizedBox(height: 5
                  ,),
                  // Date
                  Text(
                    DateFormat('dd MMM yyyy').format(date),
                    style: mainTextStyle.copyWith(
                      fontSize: 14,
                      fontWeight: light,
                    ),
                  ),
                  // Header End

                  //* CONTENT REVIEW
                  const SizedBox(height: 10,),
                  // Review
                  Text(
                    review,
                    textAlign: TextAlign.justify,
                    style: mainTextStyle.copyWith(
                      fontSize: 14,
                      fontWeight: light,
                    ),
                  ),
                  // Date
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
