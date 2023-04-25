import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loh_coffee_eatery/ui/pages/update_menu_admin.dart';
import 'package:loh_coffee_eatery/ui/widgets/custom_button.dart';
import 'package:loh_coffee_eatery/ui/widgets/custom_button_red.dart';
import '../../cubit/menu_cubit.dart';
import '../../models/menu_model.dart';
import '/shared/theme.dart';

class CustomCardMenuItemAdmin extends StatelessWidget {
  final MenuModel menu;

  const CustomCardMenuItemAdmin(
    this.menu, {
    super.key,
  });

  @override
  void initState(){
    initializeTheme(false);
  }

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
            color: isDarkMode ? backgroundColor.withOpacity(0.3) : Colors.grey.withOpacity(0.5),
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
                aspectRatio: 1 / 1,
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
                      // Update Button
                      SizedBox(
                        width: 0.2 * MediaQuery.of(context).size.width,
                        height: 35,
                        child: CustomButton(
                          title: 'Update',
                          fontSize: 14,
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => UpdateMenuPageAdmin(inMenu: menu),
                              ),
                            );
                          },
                        ),
                      ),
                      const SizedBox(width: 20),
                      SizedBox(
                        width: 0.2 * MediaQuery.of(context).size.width,
                        height: 35,
                        child: BlocConsumer<MenuCubit, MenuState>(
                          listener: (context, state) {
                            if(state is MenuSuccess){
                            }
                            else if(state is MenuFailed){
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  backgroundColor: Colors.red,
                                  content: Text(state.error),
                                ),
                              );
                            }
                            // TODO: implement listener
                          },
                          builder: (context, state) {
                            if (state is MenuLoading) {
                              return  Center(
                                child: CircularProgressIndicator(
                                  color: primaryColor,
                                ),
                              );
                            }
                            return CustomButtonRed(
                              title: 'Delete',
                              fontSize: 14,
                              onPressed: () {
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      title: const Text("Delete Menu"),
                                      content: const Text(
                                          "Are you sure you want to delete this menu?"),
                                      actions: [
                                        TextButton(
                                          child: Text(
                                            "Cancel",
                                            style: greenTextButtonStyle
                                          ),
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          },
                                        ),
                                        TextButton(
                                          child: Text(
                                            "Delete",
                                            style: greenTextButtonStyle,
                                          ),
                                          onPressed: () {
                                            context
                                              .read<MenuCubit>()
                                              .deleteMenu(menu);
                                              // Navigator.pushNamed(context, '/home-admin');
                                              Navigator.of(context).pop();
                                              ScaffoldMessenger.of(context).showSnackBar(
                                                SnackBar(
                                                content: Text(
                                                  'Menu Successfully Deleted!',
                                                  style: whiteTextButtonStyle
                                                ),
                                                backgroundColor: greenButtonColor,
                                              ),
                                            );
                                          },
                                        ),
                                      ],
                                    );
                                  },
                                );
                              },
                            );
                          },
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
}
