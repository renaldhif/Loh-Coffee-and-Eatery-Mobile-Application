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

class DeleteTableAdminPage extends StatefulWidget {
  const DeleteTableAdminPage({super.key});

  @override
  State<DeleteTableAdminPage> createState() => _DeleteTableAdminPageState();
}

class _DeleteTableAdminPageState extends State<DeleteTableAdminPage> {
  // TextEditingControllers
  final TextEditingController _tableNumController = TextEditingController();

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
                        'Delete Table',
                        style: greenTextStyle.copyWith(
                          fontSize: 32,
                          fontWeight: bold,
                        ),
                      ),
                    ),
                    const SizedBox(height: 15),
                  ],
                ),
              ),

              //* Table Number
              CustomTextFormField(
                title: 'Table Number',
                label: 'Table Number',
                hintText: 'input table number',
                controller: _tableNumController,
              ),

              Padding(
                padding: const EdgeInsets.fromLTRB(20, 35, 20, 70),
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
                      title: 'Delete Table',
                      onPressed: () {
                        if (_tableNumController.text
                            .contains(RegExp(r'[a-zA-Z]'))) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content:
                                  Text('Please input a valid table number'),
                              backgroundColor: Colors.red,
                            ),
                          );
                        }
                        if (_tableNumController.text.isEmpty) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Please fill the fields'),
                              backgroundColor: Colors.red,
                            ),
                          );
                        } else {
                          //TODO: Implement delete table
                          // context.read<TableCubit>().addTable();
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