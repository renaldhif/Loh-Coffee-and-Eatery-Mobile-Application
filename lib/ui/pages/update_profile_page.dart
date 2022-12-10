import 'package:cloud_firestore/cloud_firestore.dart';
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
      body: Container(
        child: BlocBuilder<AuthCubit, AuthState>(
          builder: (context, state) {
            if(state is AuthSuccess){
                          return Column(
              children: [
                CustomTextFormField(
                  title: 'Name',
                  label: '${state.user.name}',
                  hintText: 'Update name',
                  controller: _fullnameController,
                ),
                CustomTextFormField(
                  title: 'Email',
                  label: '${state.user.email}',
                  hintText: 'Update email',
                  controller: _emailController,
                ),
                CustomTextFormField(
                  title: 'Date of Birth',
                  label: '${state.user.dob}',
                  hintText: 'Update date of birth',
                  controller: _dateInputController,
                ),
                SizedBox(
                  height: 20,
                ),
                //submitButton(),
                CustomButton(
                  title: 'Update',
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

              ],
            );
            }else{
              return SizedBox();
            }

          },
        ),
      ),
    );
  }
}
