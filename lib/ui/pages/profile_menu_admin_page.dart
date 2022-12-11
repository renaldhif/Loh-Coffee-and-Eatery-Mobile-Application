import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:loh_coffee_eatery/cubit/auth_cubit.dart';
import '../../models/user_model.dart';
import '/ui/widgets/custom_button_red.dart';
import '/shared/theme.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfileMenuAdminPage extends StatefulWidget {
  const ProfileMenuAdminPage({super.key});

  @override
  State<ProfileMenuAdminPage> createState() => _ProfileMenuAdminPageState();
}

class _ProfileMenuAdminPageState extends State<ProfileMenuAdminPage> {
  // boolean for dark mode
  bool _isSwitched = false;

  // To change the selected value of bottom navigation bar
  int _selectedIndex = 4;
  void _changeSelectedIndex(int index) {
    setState(() {
      _selectedIndex = index;
      switch (index) {
        case 0:
          Navigator.pushReplacementNamed(context, '/home');
          // Navigator.pop(context);
          break;
        // case 2:
        //   Navigator.pushNamed(context, '/order');
        //   break;
        // case 3:
        //   Navigator.pushNamed(context, '/notification');
        //   break;
        // case 4:
        //   Navigator.pushNamed(context, '/profilemenu');
        //   break;
      }
    });
  }

  Widget signOutButton() {
    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is AuthFailed) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              backgroundColor: Colors.red,
              content: Text(state.error),
            ),
          );
        } else if (state is AuthInitial) {
          Navigator.pushNamedAndRemoveUntil(
              context, '/login', (route) => false);
        }
      },
      builder: (context, state) {
        if (state is AuthLoading) {
          return const Center(child: CircularProgressIndicator());
        }
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: CustomButtonRed(
              title: 'Sign Out',
              onPressed: () {
                context.read<AuthCubit>().signOut();
              }),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        color: kUnavailableColor,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                color: whiteColor,
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
                        'Profile Menu',
                        style: greenTextStyle.copyWith(
                          fontSize: 40,
                          fontWeight: bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              // profile detail
              const SizedBox(height: 15),

              // profile card
              Container(
                width: double.infinity,
                height: 80,
                decoration: BoxDecoration(
                  color: whiteColor,
                  border: Border.all(
                    color: backgroundColor,
                    width: 2,
                  ),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        const Padding(
                          padding: EdgeInsets.only(left: 15),
                        ),
                        CircleAvatar(
                          radius: 30,
                          backgroundColor: primaryColor,
                          child: CircleAvatar(
                            backgroundImage: Image.asset('assets/images/lohlogo.jpeg').image,
                            radius: 29, //size
                            backgroundColor: primaryColor,
                          ),
                        ),
                        const SizedBox(width: 20),
                        BlocBuilder<AuthCubit, AuthState>(
                          builder: (context, state) {
                            if (state is AuthSuccess) {
                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    '${state.user.name}',
                                    style: mainTextStyle.copyWith(
                                      fontSize: 20,
                                      fontWeight: bold,
                                    ),
                                  ),
                                  const Padding(
                                    padding: EdgeInsets.only(top: 5),
                                  ),
                                  Text(
                                    '${state.user.email}',
                                    style: mainTextStyle.copyWith(
                                      fontSize: 15,
                                      fontWeight: bold,
                                    ),
                                  ),
                                ],
                              );
                            } else {}
                            return const SizedBox();
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              // Reviews
              const SizedBox(height: 25),
              Padding(
                padding: const EdgeInsets.only(left: 15, bottom: 10),
                child: Text(
                  'Reviews & Ratings',
                  style: greenTextStyle.copyWith(
                    fontSize: 14,
                    fontWeight: bold,
                  ),
                  textAlign: TextAlign.left,
                ),
              ),

              Container(
                padding: const EdgeInsets.only(left: 15, right: 15),
                height: 50,
                decoration: BoxDecoration(
                  color: whiteColor,
                  border: Border.all(
                    color: backgroundColor,
                    width: 1,
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        const Icon(
                          Icons.reviews_rounded,
                          size: 26,
                          color: primaryColor,
                        ),
                        const SizedBox(width: 20),
                        Text(
                          "View Review",
                          style: greenTextStyle.copyWith(
                            fontSize: 17,
                            fontWeight: bold,
                          ),
                          textAlign: TextAlign.start,
                        ),
                      ],
                    ),
                    IconButton(
                      onPressed: () {
                        Navigator.pushNamed(context, '/reviews');
                      },
                      icon: const Icon(
                        Icons.arrow_forward,
                        color: primaryColor,
                      ),
                    ),
                  ],
                ),
              ),

              // General Setting title
              const SizedBox(height: 25),
              Padding(
                padding: const EdgeInsets.only(left: 15, bottom: 10),
                child: Text(
                  'General Settings',
                  style: greenTextStyle.copyWith(
                    fontSize: 14,
                    fontWeight: bold,
                  ),
                  textAlign: TextAlign.left,
                ),
              ),

              // General Setting Content

              // Dark Mode
              Container(
                padding: const EdgeInsets.only(left: 15, right: 15),
                height: 50,
                decoration: BoxDecoration(
                  color: whiteColor,
                  border: Border.all(
                    color: backgroundColor,
                    width: 1,
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        const Icon(
                          Icons.dark_mode_rounded,
                          size: 26,
                          color: primaryColor,
                        ),
                        const SizedBox(width: 20),
                        Text(
                          "Dark Mode",
                          style: greenTextStyle.copyWith(
                            fontSize: 17,
                            fontWeight: bold,
                          ),
                          textAlign: TextAlign.start,
                        ),
                      ],
                    ),
                    Switch(
                      // * TODO: Iteration 3: Implement Dark Mode
                      onChanged: (value) {
                        setState(() {
                          _isSwitched = value;
                        });
                      },
                      value: _isSwitched,
                      activeColor: primaryColor,
                    ),
                  ],
                ),
              ),

              // Switch Language
              Container(
                padding: const EdgeInsets.only(left: 15, right: 15),
                height: 50,
                decoration: BoxDecoration(
                  color: whiteColor,
                  border: Border.all(
                    color: backgroundColor,
                    width: 1,
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        const Icon(
                          Icons.translate_rounded,
                          size: 26,
                          color: primaryColor,
                        ),
                        const SizedBox(width: 20),
                        Text(
                          "Switch Language to Indonesia",
                          style: greenTextStyle.copyWith(
                            fontSize: 17,
                            fontWeight: bold,
                          ),
                          textAlign: TextAlign.start,
                        ),
                      ],
                    ),
                    Switch(
                      // * TODO: Iteration 3: Implement Switch Language
                      onChanged: (value) {
                        setState(() {
                          _isSwitched = value;
                        });
                      },
                      value: _isSwitched,
                      activeColor: primaryColor,
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 25),
              // Sign Out Button
              signOutButton(),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.calendar_month_rounded),
              label: 'Reserve',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.format_list_bulleted_rounded),
              label: 'Order List',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.notifications_rounded),
              label: 'Notification',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: 'Profile',
            ),
          ],
          type: BottomNavigationBarType.fixed,
          currentIndex: _selectedIndex,
          selectedItemColor: primaryColor,
          unselectedItemColor: greyColor,
          showUnselectedLabels: true,
          onTap: _changeSelectedIndex),
    );
  }
}
