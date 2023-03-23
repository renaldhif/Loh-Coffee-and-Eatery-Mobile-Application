import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:loh_coffee_eatery/ui/pages/home_page.dart';
import 'package:loh_coffee_eatery/ui/pages/menu_detail_page.dart';
import '../../cubit/menu_cubit.dart';
import '../../models/menu_model.dart';
import '/shared/theme.dart';

List _cartItems = [];

class CustomCardMenuItem extends StatefulWidget {
  final MenuModel menu;

  CustomCardMenuItem(
    this.menu, {
    super.key,
  });

  @override
  State<CustomCardMenuItem> createState() => _CustomCardMenuItemState();
}

class _CustomCardMenuItemState extends State<CustomCardMenuItem> {
  @override
  void initState() {
    super.initState();
    isLiked = widget.menu.userId.contains(getUserId());
  }
  
  void _addToCart() {
    _cartItems.add(widget.menu);
  }

  String? getUserId() {
    if (FirebaseAuth.instance.currentUser != null) {
      User? user = FirebaseAuth.instance.currentUser;
      String userid;
      return userid = user!.uid;
    }
  }

  //final _shoppingBox = Hive.box('shopping_box');
  Box<MenuModel> localDBBox = Hive.box<MenuModel>('shopping_box');
  bool isLiked = false;

  @override
  Widget build(BuildContext context) {
    // bool isLiked = false;
    // Menu Card
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context, MaterialPageRoute(
            builder: (context) => MenuDetailPage(
          inMenu: widget.menu,
        )));
      },
      child: Container(
        margin: const EdgeInsets.symmetric(
          vertical: 3,
        ),
        width: 0.9 * MediaQuery.of(context).size.width,
        height: 150,
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
          padding: const EdgeInsets.fromLTRB(12, 10, 0, 0),

          // Menu Card Content
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Image
              Container(
                width: 0.3 * MediaQuery.of(context).size.width,
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
                    child: Image.network(
                      widget.menu.image, // this field is required
                      width: 0.2 * MediaQuery.of(context).size.width,
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
                          widget.menu.title, // this field is required
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
                          widget.menu.tag, // this field is required
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
                              widget.menu.price
                                  .toString(), // this field is required
                              style: orangeTextStyle.copyWith(
                                fontSize: 16,
                                fontWeight: extraBold,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 5),
                        // Loved
                        Row(
                          children: [
                            const Icon(
                              Icons.favorite,
                              color: primaryColor,
                              size: 20,
                            ),
                            const SizedBox(width: 5),
                            Text(
                              widget.menu.totalLoved
                                  .toString(), // this field is required
                              style: greenTextStyle.copyWith(
                                fontSize: 12,
                                fontWeight: light,
                              ),
                            ),

                            // Ordered
                            const SizedBox(width: 50),
                            const Icon(
                              Icons.shopping_cart,
                              color: primaryColor,
                              size: 20,
                            ),
                            const SizedBox(width: 5),
                            Text(
                              widget.menu.totalOrdered
                                  .toString(), // this field is required
                              style: greenTextStyle.copyWith(
                                fontSize: 12,
                                fontWeight: light,
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                    // Menu Card Button
                    Row(
                      children: [
                        // Add to Cart Button
                        GestureDetector(
                          child: Container(
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
                          onTap: () {
                            _addToCart();
                            double totalPrice = 0;
                            for (int i = 0; i < _cartItems.length; i++) {
                              totalPrice += _cartItems[i].price;
                            }
                            print(_cartItems.length);
                            print(totalPrice);

                            localDBBox.add(widget.menu);

                            //refresh page
                            Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const HomePage(),
                              ),
                              (route) => false,
                            );
                          },
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        // Favorite Button
                        BlocConsumer<MenuCubit, MenuState>(
                          listener: (context, state) {
                            if (state is MenuSuccess) {
                            } else if (state is MenuFailed) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(state.error),
                                  backgroundColor: Colors.red,
                                ),
                              );
                            }
                          },
                          builder: (context, state) {
                            if (state is MenuLoading) {
                              return const Center(
                                child: CircularProgressIndicator(
                                  color: primaryColor,
                                ),
                              );
                            }
                            return IconButton(
                              icon: isLiked
                                  ? const Icon(
                                      Icons.favorite,
                                      // Icons.favorite_border_outlined,
                                    )
                                  : const Icon(Icons.favorite_border_outlined
                                      // Icons.favorite
                                      ),
                              iconSize: 20,
                              color: primaryColor,
                              onPressed: () {
                                setState(() {
                                  print('user: ${getUserId()}');
                                  print('isLiked before changed: $isLiked');
                                  isLiked = !isLiked;
                                  context.read<MenuCubit>().addLikeMenu(
                                      widget.menu, getUserId()!);
                                  // isLiked = !isLiked;
                                  print('isLiked after changed: $isLiked');
                                });
                              },
                            );
                          },
                        ),
                      ],
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
