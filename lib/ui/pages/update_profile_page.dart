import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:loh_coffee_eatery/cubit/auth_cubit.dart';
import '../../models/user_model.dart';
import '../widgets/custom_button.dart';
import '../widgets/custom_textformfield.dart';
import '/ui/widgets/custom_button_red.dart';
import '/shared/theme.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../cubit/auth_cubit.dart';

class UpdateProfilePage extends StatefulWidget {
  const UpdateProfilePage({super.key});

  @override
  State<UpdateProfilePage> createState() => _UpdateProfilePageState();
}

class _UpdateProfilePageState extends State<UpdateProfilePage> {
  TextEditingController _fullnameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _dateInputController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
          child: BlocBuilder<AuthCubit, AuthState>(
            builder: (context, state) {
              if(state is AuthSuccess){
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
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
                          icon:  Icon(
                            Icons.arrow_circle_left_rounded,
                            color: primaryColor,
                            size: 55,
                          ),
                        ),
                        const SizedBox(height: 30),
                        Padding(
                          padding: const EdgeInsets.only(left: 12),
                          child: Text(
                            'update_profile'.tr(),
                            style: greenTextStyle.copyWith(
                              fontSize: 40,
                              fontWeight: bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  CustomTextFormField(
                    title: 'name'.tr(),
                    label: '${state.user.name}',
                    hintText: 'update_name'.tr(),
                    controller: _fullnameController,
                  ),
                  CustomTextFormField(
                    title: 'email'.tr(),
                    label: '${state.user.email}',
                    hintText: 'update_email'.tr(),
                    controller: _emailController,
                  ),
                  // CustomTextFormField(
                  //   title: 'Date of Birth',
                  //   label: '${state.user.dob}',
                  //   hintText: 'Update date of birth',
                  //   controller: _dateInputController,
                  // ),
                  const SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20,),
                    child: Text(
                      'date_of_birth'.tr(),
                      style: greenTextStyle.copyWith(
                        fontSize: 18,
                        fontWeight: bold,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    child: SizedBox(
                        height: 50,
                        child: TextFormField(
                          controller: _dateInputController,
                          keyboardType: TextInputType.datetime,
                          readOnly: true,
                          onTap: () async {
                            DateTime? pickedDate = await showDatePicker(
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime(1950),
                              lastDate: DateTime(2050),
                              builder: (context, child) {
                                return FittedBox(
                                  child: Theme(
                                    data: ThemeData.light().copyWith(
                                      colorScheme:  ColorScheme.light(
                                        primary: primaryColor,
                                      ),
                                      buttonTheme:  ButtonThemeData(
                                        textTheme: ButtonTextTheme.primary,
                                      ),
                                    ),
                                    child: child!,
                                  ),
                                );
                              },
                            );
                            if (pickedDate != null) {
                              var formatDate =
                                  DateTime.parse(pickedDate.toString());
                              var formattedDate =
                                  "${formatDate.day}-${formatDate.month}-${formatDate.year}";
                              _dateInputController.text = formattedDate;
                            }
                          },
                          decoration: InputDecoration(
                            labelText: '${state.user.dob}',
                            floatingLabelBehavior: FloatingLabelBehavior.never,
                            hintText: 'enter_dob'.tr(),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide:  BorderSide(
                                color: primaryColor,
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide:  BorderSide(
                                color: primaryColor,
                                width: 1.5,
                              ),
                            ),
                          ),
                        ),
                      ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  //submitButton(),
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: CustomButton(
                      title: 'update'.tr(),
                      onPressed: () {
                        User ? user = FirebaseAuth.instance.currentUser;
                        Future<UserModel> userNow = context.read<AuthCubit>().getCurrentUser(user!.uid);
                        if(_fullnameController.text == ''){
                          _fullnameController.text = '${state.user.name}';
                        }
                        if(_emailController.text == ''){
                          _emailController.text = '${state.user.email}';
                        }
                        if(_dateInputController.text == ''){
                          _dateInputController.text = '${state.user.dob}';
                        }
      
                        context.read<AuthCubit>().updateUser(
                              id: user.uid,
                              name: _fullnameController.text,
                              email: _emailController.text,
                              dob: _dateInputController.text,
                            );
                        Navigator.pushNamed(context, '/profilemenu');
                      },
                    ),
                  ),
      
                ],
              );
              }else{
                return SizedBox();
              }
            },
          ),
        ),
      ),
    );
  }
}
