import 'package:flutter/material.dart';
import 'package:loh_coffee_eatery/ui/widgets/custom_rating_card.dart';
import '../../shared/theme.dart';


class ReviewPageAdmin extends StatefulWidget {
  const ReviewPageAdmin({super.key});

  @override
  State<ReviewPageAdmin> createState() => _ReviewPageAdminState();
}

class _ReviewPageAdminState extends State<ReviewPageAdmin> {
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
                        'Reviews',
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
              
              //* Content
              CustomRatingCard(
                username: 'John Doe',
                email: 'johndoe@gmail.com',
                review: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed euismod, nunc vel tincidunt luctus, nunc nisl aliquam nunc, vel aliquam nunc nisl euismod nunc. Sed euismod, nunc vel tincidunt luctus, nunc nisl aliquam nunc, vel aliquam nunc nisl euismod nunc.',
                rating: 5,
                date: DateTime.now(),
              ),

              CustomRatingCard(
                username: 'John Doe',
                email: 'johndoe@gmail.com',
                review: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed euismod, nunc vel tincidunt luctus, nunc nisl aliquam nunc, vel aliquam nunc nisl euismod nunc. Sed euismod, nunc vel tincidunt luctus, nunc nisl aliquam nunc, vel aliquam nunc nisl euismod nunc.',
                rating: 5,
                date: DateTime.now(),
              ),

              CustomRatingCard(
                username: 'John Doe',
                email: 'johndoe@gmail.com',
                review: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed euismod, nunc vel tincidunt luctus, nunc nisl aliquam nunc, vel aliquam nunc nisl euismod nunc. Sed euismod, nunc vel tincidunt luctus, nunc nisl aliquam nunc, vel aliquam nunc nisl euismod nunc.',
                rating: 5,
                date: DateTime.now(),
              ),

              CustomRatingCard(
                username: 'John Doe',
                email: 'johndoe@gmail.com',
                review: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed euismod, nunc vel tincidunt luctus, nunc nisl aliquam nunc, vel aliquam nunc nisl euismod nunc. Sed euismod, nunc vel tincidunt luctus, nunc nisl aliquam nunc, vel aliquam nunc nisl euismod nunc.',
                rating: 5,
                date: DateTime.now(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}