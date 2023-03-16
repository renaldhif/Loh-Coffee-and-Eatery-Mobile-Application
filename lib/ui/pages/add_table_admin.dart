import 'package:checkbox_grouped/checkbox_grouped.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loh_coffee_eatery/cubit/menu_cubit.dart';
import 'package:loh_coffee_eatery/models/menu_model.dart';
import '../../cubit/table_cubit.dart';
import '/shared/theme.dart';
import 'package:loh_coffee_eatery/ui/widgets/custom_button.dart';
import 'package:loh_coffee_eatery/ui/widgets/custom_button_white.dart';
import 'package:loh_coffee_eatery/ui/widgets/custom_textformfield.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class AddTablePageAdmin extends StatefulWidget {
  const AddTablePageAdmin({super.key});

  @override
  State<AddTablePageAdmin> createState() => _AddTablePageAdminState();
}

class _AddTablePageAdminState extends State<AddTablePageAdmin> {
  // TextEditingControllers
  final TextEditingController _tableNumController = TextEditingController();
  final TextEditingController _numOfPeopleController = TextEditingController();
  final TextEditingController _locationController = TextEditingController();

  //* Group Controller
  GroupController controller = GroupController(isMultipleSelection: true);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          color: whiteColor,
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
                        'Add New Table',
                        style: greenTextStyle.copyWith(
                          fontSize: 32,
                          fontWeight: bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              //* Table Number
              CustomTextFormField(
                  title: 'Table Number',
                  label: 'Table Number',
                  hintText: 'input table number',
                  controller: _tableNumController),
              
              //* Num Of People
              CustomTextFormField(
                  title: 'Num of People',
                  label: 'Num of People',
                  hintText: 'input num of people',
                  controller: _numOfPeopleController),

              //* Location
              CustomTextFormField(
                  title: 'Location',
                  label: 'Indoor/Outdoor',
                  hintText: 'input location',
                  controller: _locationController),
              
              const SizedBox(
                height: 15,
              ),

              Padding(
                padding:
                    const EdgeInsets.fromLTRB(20,35, 20, 70),
                child: BlocConsumer<TableCubit, TableState>(
                  listener: (context, state) {
                    if (state is TableSuccess) {
                      Navigator.popAndPushNamed(context, '/home-admin');
                    } else if (state is TableFailed) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          backgroundColor: Colors.red,
                          content: Text(state.error),
                        ),
                      );
                    }
                  },
                  builder: (context, state) {
                    if (state is TableLoading) {
                      return const Center(
                        child: CircularProgressIndicator(
                          color: primaryColor,
                        ),
                      );
                    }
                    return CustomButton(
                      title: 'Add Table',
                      onPressed: () {
                        if(_tableNumController.text.contains(RegExp(r'[a-zA-Z]'))) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Please input a valid table number'),
                              backgroundColor: Colors.red,
                            ),
                          );
                        }
                        if(_numOfPeopleController.text.contains(RegExp(r'[a-zA-Z]'))) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Please input a valid table number'),
                              backgroundColor: Colors.red,
                            ),
                          );
                        }
                        if(_tableNumController.text.isEmpty ||
                            _numOfPeopleController.text.isEmpty ||
                            _locationController.text.isEmpty) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Please fill all the fields'),
                              backgroundColor: Colors.red,
                            ),
                          );
                        }
                        else{
                          context.read<TableCubit>().addTable(
                            tableNum: int.parse(_tableNumController.text),
                            sizeOfPeople: int.parse(_numOfPeopleController.text),
                            location: _locationController.text,
                            isBooked: false,
                          );
                          ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('New Table Successfully Added!'),
                            backgroundColor: primaryColor,
                          ),
                        );
                        }
                      },
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
