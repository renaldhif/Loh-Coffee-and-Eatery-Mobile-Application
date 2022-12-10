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
        child: Column(
          children: [
            CustomTextFormField(
              title: 'Name',
              label: 'Name',
              hintText: 'Update name',
              controller: _fullnameController,
            ),
            CustomTextFormField(
              title: 'Email',
              label: 'Email',
              hintText: 'Update email',
              controller: _emailController,
            ),
            CustomTextFormField(
              title: 'Date of Birth',
              label: 'Date of Birth',
              hintText: 'Update date of birth',
              controller: _dateInputController,
            ),
            const SizedBox(height: 20,),
            //submitButton(),
            CustomButton(
              title: 'Update', 
              onPressed: (){
                User ? user = FirebaseAuth.instance.currentUser;
                Future<UserModel> userNow = context.read<AuthCubit>().getCurrentUser(user!.uid);
                // ScaffoldMessenger.of(context).showSnackBar(
                //   SnackBar(
                //     backgroundColor: Colors.red,
                //     content: Text(user.uid),
                //   ),
                // );
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
        ),
      ),
    );
  }
}
