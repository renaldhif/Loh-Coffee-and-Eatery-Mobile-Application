import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loh_coffee_eatery/models/review_model.dart';
import 'package:loh_coffee_eatery/ui/widgets/custom_rating_card.dart';
import '../../cubit/review_cubit.dart';
import '../../shared/theme.dart';

class ReviewPageAdmin extends StatefulWidget {
  const ReviewPageAdmin({super.key});

  @override
  State<ReviewPageAdmin> createState() => _ReviewPageAdminState();
}

class _ReviewPageAdminState extends State<ReviewPageAdmin> {
  @override
  void initState() {
    context.read<ReviewCubit>().getReviews();
    super.initState();
  }

  Widget reviewCard(List<ReviewModel> reviews) {
    return Container(
      margin: const EdgeInsets.fromLTRB(12, 0, 12, 0),
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: reviews.map((ReviewModel rev) {
              return CustomRatingCard(rev);
          }).toList(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      body: SingleChildScrollView(
        child: Container(
          color: backgroundColor,
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
                      icon: Icon(
                        Icons.arrow_circle_left_rounded,
                        color: primaryColor,
                        size: 55,
                      ),
                    ),
                    const SizedBox(height: 30),
                    Padding(
                      padding: const EdgeInsets.only(left: 12),
                      child: Text(
                        'review_list'.tr(),
                        style: greenTextStyle.copyWith(
                          fontSize: 40,
                          fontWeight: bold,
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                  ],
                ),
              ), // Header End
              //* Review Content Cards

              BlocConsumer<ReviewCubit, ReviewState>(
                listener: (context, state) {
                  if (state is ReviewFailed) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(state.error),
                      ),
                    );
                  }
                },
                builder: (context, state) {
                  if (state is ReviewLoading) {
                    return Center(
                      child: CircularProgressIndicator(
                        color: primaryColor,
                      ),
                    );
                  } else if (state is ReviewSuccess) {
                    List<ReviewModel> reviews = state.reviews;
                    reviews.sort((a, b) => -a.timestamp.compareTo(b.timestamp));
                    return reviewCard(reviews);
                    // return reviewCard(state.reviews);
                  } else {
                    return Center(
                      child: Text('something_wrong'.tr()),
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
