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
  

  // Widget updateButton(){
  //   return BlocBuilder<AuthCubit, AuthState>(
  //     builder: (context, state) {
  //       if(state is AuthSuccess){
  //         return CustomButton(
  //           title: 'Update', 
  //           onPressed: (){
  //             context.read<AuthCubit>().updateUser(

  //             );
  //           },
  //         );
  //       }
  //     },
  //   );
  // }
  //   User ? userNow = FirebaseAuth.instance.currentUser;
  //   Widget submitButton(){
  //   return BlocConsumer<AuthCubit, AuthState>(
  //     listener: (context, state) {
  //       if(state is AuthSuccessUpdate){
  //         Navigator.pushNamed(context, '/profilemenu');
  //       }else if(state is AuthFailed){
  //         ScaffoldMessenger.of(context).showSnackBar(
  //           SnackBar(
  //             backgroundColor: Colors.red,
  //             content: Text(state.error),
  //           ),
  //         );
  //       }
  //     },
  //     builder: (context, state) {
  //       if(state is AuthLoading){
  //         return const Center(
  //           child: CircularProgressIndicator(
  //           ),
  //         );
  //       }
  //       return CustomButton(
  //         title: 'Update', 
  //         onPressed: (){
  //           context.read<AuthCubit>().updateUser(
  //             name: 
  //           )
  //         },
  //       );
  //     },
  //   );
  // }
  // @override
  // void initState() {
  // WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
  //   if (FirebaseAuth.instance.currentUser == null) {
  //     ScaffoldMessenger.of(context).showSnackBar(
  //         SnackBar(content: Text('please complete profile firstly')));
  //   } else {
  //     FirebaseFirestore.instance
  //         .collection('users')
  //         .doc(FirebaseAuth.instance.currentUser!.uid)
  //         .get()
  //         .then((DocumentSnapshot<Map<String, dynamic>> snapshot) {
  //           _fullnameController = snapshot['name'];
  //           _emailController = snapshot['email'];
  //           _dateInputController = snapshot['dateOfBirth'];
  //     });
  //   }
  // });
  // super.initState();
  // }


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
            SizedBox(height: 20,),
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
            // BlocConsumer<AuthCubit, AuthState>(
            //   listener: (context, state) {
            //     if(state is AuthSuccess){
            //       // state.user.name = _fullnameController.text;
            //       // state.user.email = _emailController.text;
            //       // state.user.dob = _dateInputController.text;
            //       Navigator.pushNamedAndRemoveUntil(context, '/home', (route) => false);
            //     }
            //     else if(state is AuthFailed){
            //       ScaffoldMessenger.of(context).showSnackBar(
            //         SnackBar(
            //           backgroundColor: Colors.red,
            //           content: Text(state.error),
            //         ),
            //       );
            //     }
            //   },
            //   builder: (context, state) {
            //     if (state is AuthLoading) {
            //       return const Center(
            //         child: CircularProgressIndicator(
            //           color: primaryColor,
            //         ),
            //       );
            //     }
            //     return CustomButton(
            //       title: 'Update',
            //       onPressed: () {
            //         context.read<AuthCubit>().updateUser(
            //           name: _fullnameController.text,
            //           email: _emailController.text,
            //           dob: _dateInputController.text,
            //         );
            //       },
            //     );
            //   },
            // ),
          ],
        ),
      ),
    );
  }
}
