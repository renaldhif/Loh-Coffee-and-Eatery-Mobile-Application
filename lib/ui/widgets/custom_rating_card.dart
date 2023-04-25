import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../models/review_model.dart';
import '/shared/theme.dart';

class CustomRatingCard extends StatelessWidget {
  final ReviewModel reviewModel;
  // final String username, email, review;
  // final double rating;
  // final DateTime dt = reviewModel.timestamp.toDate();

  const CustomRatingCard(
    this.reviewModel, {
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10,
        vertical: 10,
      ),
      width: 0.9 * MediaQuery.of(context).size.width,
      // height: 130,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(defaultRadius),
        border: Border.all(
          color: primaryColor,
          width: 0.5,
        ),
        boxShadow: [
          BoxShadow(
            color: isDarkMode ? backgroundColor : Colors.grey.withOpacity(0.3),
            spreadRadius: 3,
            blurRadius: 7,
            offset: const Offset(1, 3),
          ),
        ],
        color: whiteColor,
      ),
      child: Padding(
        padding: const EdgeInsets.all(15),
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
                        reviewModel.name.toString(),
                        style: greenTextStyle.copyWith(
                          fontSize: 18,
                          fontWeight: bold,
                        ),
                      ),

                      // Rating
                      Row(
                        children: [
                           Icon(
                            Icons.star,
                            color: primaryColor,
                          ),
                          const SizedBox(width: 5,),
                          Text(
                            reviewModel.rating.toString(),
                            style: mainTextStyle.copyWith(
                              fontSize: 14,
                              fontWeight: regular,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),

                  // Email
                  Text(
                    reviewModel.email.toString(),
                    style: mainTextStyle.copyWith(
                      fontSize: 14,
                      fontWeight: medium,
                    ),
                  ),
                  const SizedBox(height: 5
                  ,),
                  // Date
                  Text(
                    // reviewModel.timestamp.toDate().toString(),
                    DateFormat('dd MMMM yyyy').format(reviewModel.timestamp.toDate()),
                    style: mainTextStyle.copyWith(
                      fontSize: 14,
                      fontWeight: light,
                    ),
                  ),
                  // Header End

                  //* CONTENT REVIEW
                  const SizedBox(height: 20,),
                  // Review
                  Text(
                    reviewModel.review,
                    textAlign: TextAlign.justify,
                    style: mainTextStyle.copyWith(
                      fontSize: 14,
                      fontWeight: regular,
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
