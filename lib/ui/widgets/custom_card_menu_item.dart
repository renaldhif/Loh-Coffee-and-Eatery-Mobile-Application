import 'package:flutter/material.dart';
import '../../models/menu_model.dart';
import '/shared/theme.dart';

class CustomCardMenuItem extends StatelessWidget {
  final MenuModel menu;
  // final String title, image, tag, price;
  // final double qtyLoved, qtyOrdered;
  // final Function() onPressed;

  const CustomCardMenuItem(
    this.menu,{
      super.key,
    // required this.title,
    // required this.image,
    // required this.tag,
    // required this.price,
    // required this.qtyLoved,
    // required this.qtyOrdered,
    // required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    // Menu Card
    return Container(
      margin: const EdgeInsets.symmetric(
        vertical: 3,
      ),
      width: 0.9 * MediaQuery.of(context).size.width,
      height: 140,
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
            // Image
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(defaultRadius),
                border: Border.all(
                  color: Colors.grey.withOpacity(0.3),
                  width: 1,
                ),
              ),
              child: AspectRatio(
                aspectRatio: 1/1,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(defaultRadius),
                  child: Image.network(
                    menu.image, // this field is required
                    width: 0.3 * MediaQuery.of(context).size.width,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
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
                      Text(
                        menu.title, // this field is required
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        softWrap: false,
                        style: greenTextStyle.copyWith(
                          fontSize: 14,
                          fontWeight: black,
                        ),
                      ),
                      const SizedBox(height: 5),
                      Text(
                        menu.tag, // this field is required
                        style: greenTextStyle.copyWith(
                          fontSize: 12,
                          fontWeight: light,
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
                            menu.price.toString(), // this field is required
                            style: orangeTextStyle.copyWith(
                              fontSize: 16,
                              fontWeight: extraBold,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  // Menu Card Button
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
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(
                              Icons.add,
                              color: primaryColor,
                            ),
                            const SizedBox(width: 10),
                            Text(
                              'Add to Cart',
                              style: greenTextStyle.copyWith(
                                fontSize: 12,
                                fontWeight: extraBold,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      // Favorite Button
                      const Icon(
                        Icons.favorite_border_rounded,
                        color: primaryColor,
                        size: 28,
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
}
