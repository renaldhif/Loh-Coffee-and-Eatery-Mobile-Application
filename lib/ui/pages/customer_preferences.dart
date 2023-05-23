import 'package:checkbox_grouped/checkbox_grouped.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loh_coffee_eatery/cubit/auth_cubit.dart';
import '../../services/user_service.dart';
import '/shared/theme.dart';
import 'package:loh_coffee_eatery/ui/widgets/custom_button.dart';
import 'package:loh_coffee_eatery/ui/widgets/custom_textformfield.dart';
import 'dart:io';

class CustomerPreferencesPage extends StatefulWidget {
  const CustomerPreferencesPage({super.key});

  @override
  State<CustomerPreferencesPage> createState() =>
      _CustomerPreferencesPageState();
}

class _CustomerPreferencesPageState extends State<CustomerPreferencesPage> {
  TextEditingController _tagController = TextEditingController();

  //* Group Controller
  GroupController controller = GroupController(isMultipleSelection: true);

  //list string of preferences
  List<String> newPreferences = [];

  User? user = FirebaseAuth.instance.currentUser;
  // String uid = user!.uid;

  @override
  void initState() {
    super.initState();
    String uid = user!.uid;
  }


  // get the preferences from the database
  Future<String> getPreferences(uid) async {
    String uid = user!.uid;
    List<String> preferences = await UserService().getUserPreferences(uid);
    print(preferences);
    // _tagController.text = preferences.join(', ');
    return preferences.join(',');
  }

  @override
  Widget build(BuildContext context) {    
    return Scaffold(
      backgroundColor: backgroundColor,
      body: SingleChildScrollView(
        child: Container(
          color: backgroundColor,
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
                        'edit_your_preferences'.tr(),
                        style: greenTextStyle.copyWith(
                          fontSize: 28,
                          fontWeight: bold,
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Padding(
                      padding: const EdgeInsets.only(left: 12),
                      child: Text(
                        'your_preferences'.tr(),
                          style: greenTextStyle.copyWith(
                            fontSize: 16,
                            fontWeight: bold,
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Padding(
                      padding: const EdgeInsets.only(left: 12),
                      child: FutureBuilder<String>(
                        future: getPreferences(user!.uid),
                        builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
                          if (snapshot.hasData) {
                            return Text(
                              snapshot.data!,
                              style: greenTextStyle.copyWith(
                                fontSize: 16,
                                fontWeight: medium,
                              ),
                            );
                          } else {
                            return Text(
                              'loading'.tr(), // or any other placeholder text
                              style: greenTextStyle.copyWith(
                                fontSize: 16,
                                fontWeight: medium,
                              ),
                            );
                          }
                        },
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              //* Tag
              CustomTextFormField(
                  readOnly: true,
                  title: 'menu_preferences'.tr(),
                  label: 'menu_preferences'.tr(),
                  hintText: 'choose_menu'.tr(),
                  controller: _tagController),
              //* Checkboxes
              const SizedBox(
                height: 25,
              ),
              Text(
                'please_choose_menu'.tr(),
                style: greenTextStyle.copyWith(
                  fontSize: 16,
                  fontWeight: bold,
                ),
              ),
              Theme(
                data: ThemeData(
                  unselectedWidgetColor: primaryColor,
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: SimpleGroupedCheckbox<String>(
                    controller: controller,
                    itemsTitle: const [
                      "Rice",
                      "Chicken",
                      "Beef",
                      "Seafood",
                      "Noodles",
                      "Pasta",
                      "Fish",
                      "Soup",
                      "Snacks",
                      "Vegetables",
                      "Cake and Dessert",
                      "Coffee",
                      "Milk",
                      "Tea",
                      "Spicy",
                    ],
                    values: const [
                      "Rice",
                      "Chicken",
                      "Beef",
                      "Seafood",
                      "Noodles",
                      "Pasta",
                      "Fish",
                      "Soup",
                      "Snacks",
                      "Vegetables",
                      "Cake and Dessert",
                      "Coffee",
                      "Milk",
                      "Tea",
                      "Spicy",
                    ],
                    groupStyle: GroupStyle(
                      activeColor: primaryColor,
                      itemTitleStyle: greenTextStyle.copyWith(
                        fontSize: 16,
                        fontWeight: medium,
                      ),
                      groupTitleStyle: greenTextStyle,
                    ),
                    onItemSelected: (selected) {
                      setState(() {
                        _tagController.text = selected.join(',');
                        newPreferences = selected;
                      });
                    },
                  ),
                ),
              ),

              Padding(
                padding: const EdgeInsets.fromLTRB(20, 35, 20, 70),
                child: BlocConsumer<AuthCubit, AuthState>(
                  listener: (context, state) {
                    if (state is AuthSuccess) {
                      Navigator.popAndPushNamed(context, '/home');
                    } else if (state is AuthFailed) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          backgroundColor: Colors.red,
                          content: Text(state.error),
                        ),
                      );
                    }
                  },
                  builder: (context, state) {
                    if (state is AuthLoading) {
                      return Center(
                        child: CircularProgressIndicator(
                          color: primaryColor,
                        ),
                      );
                    }
                    return CustomButton(
                      title: 'edit_preferences'.tr(),
                      onPressed: () {
                        String uid = user!.uid;
                        context.read<AuthCubit>().updateFoodPreferences(
                          id: uid, 
                          foodPreference: newPreferences,
                        );
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('preferences_update_success'.tr(),
                              style: whiteTextButtonStyle,
                            ),
                            backgroundColor: greenButtonColor,
                          ),
                        );
                      }
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
