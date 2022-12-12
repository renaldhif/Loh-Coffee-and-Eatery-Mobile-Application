import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:loh_coffee_eatery/cubit/review_cubit.dart';
import 'package:loh_coffee_eatery/shared/theme.dart';
import 'package:loh_coffee_eatery/ui/widgets/custom_button.dart';

import '../../cubit/auth_cubit.dart';
import '../../models/user_model.dart';
import '../widgets/custom_textformfield.dart';

class AddReviewPage extends StatefulWidget {
  const AddReviewPage({super.key});

  @override
  State<AddReviewPage> createState() => _AddReviewPageState();
}

class _AddReviewPageState extends State<AddReviewPage> {
  // TextEditingControllers
  final TextEditingController _reviewController = TextEditingController();
  // initial rating
  double _initRating = 3;

  Widget starRating() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 30),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              RatingBar.builder(
                initialRating: 3,
                minRating: 1,
                direction: Axis.horizontal,
                allowHalfRating: true,
                itemCount: 5,
                itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
                itemBuilder: (context, _) => const Icon(
                  Icons.star,
                  color: primaryColor,
                ),
                onRatingUpdate: (rating) {
                  _initRating = rating;
                  print(rating);
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget reviewTextFormField() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 15),
          SizedBox(
            width: double.infinity,
            // height: 100,
            child: TextFormField(
              controller: _reviewController,
              minLines: 5,
              maxLines: 5,
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 15,
                  vertical: 15,
                ),
                labelText: 'Input Review', // this field is required
                floatingLabelBehavior: FloatingLabelBehavior.never,
                hintText: 'Submit your review here', // this field is required
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(
                    color: primaryColor,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(
                    color: primaryColor,
                    width: 1.5,
                  ),
                ),
              ),
            ),
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
                        'Submit Review',
                        style: greenTextStyle.copyWith(
                          fontSize: 40,
                          fontWeight: bold,
                        ),
                      ),
                    ),

                    // Rating Content
                    //* Star Rating
                    starRating(),
                    const SizedBox(height: 15),

                    // Submit Review Content
                    //* Review
                    reviewTextFormField(),

                    // Submit Button
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 50),
                      child: BlocConsumer<ReviewCubit, ReviewState>(
                        listener: (context, state) {
                          if (state is ReviewSuccess) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text(
                                    'Review Submitted. Thank you for your review!'),
                                backgroundColor: primaryColor,
                              ),
                            );
                            // User? user = FirebaseAuth.instance.currentUser;
                            // String? inName = user?.displayName;
                            Navigator.pop(context);
                          } else if (state is ReviewFailed) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(state.error),
                                backgroundColor: Colors.red,
                              ),
                            );
                          }
                        },
                        builder: (context, state) {
                          if (state is ReviewLoading) {
                            return const Center(
                              child: CircularProgressIndicator(
                                color: primaryColor,
                              ),
                            );
                          }
                          return CustomButton(
                            title: 'Submit Review',
                            onPressed: () async {
                              // get Date now
                              // DateTime now = DateTime.now();
                              Timestamp now = Timestamp.now();
                              // String formattedDate = "${now.day}-${now.month}-${now.year}";

                              // get firebase auth user data
                              if (FirebaseAuth.instance.currentUser != null) {
                                User? user = FirebaseAuth.instance.currentUser;
                                // Future<UserModel> userNow = context
                                //     .read<AuthCubit>()
                                //     .getCurrentUser(user!.uid)
                                UserModel userNow = await context
                                    .read<AuthCubit>()
                                    .getCurrentUser(user!.uid);
                                String? name = userNow.name;
                                String? email =
                                    FirebaseAuth.instance.currentUser?.email;

                                context.read<ReviewCubit>().addReview(
                                      name: name,
                                      email: email,
                                      review: _reviewController.text,
                                      rating: _initRating,
                                      timestamp: now,
                                    );
                              }
                            },
                          );
                        },
                      ),
                    ),
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
