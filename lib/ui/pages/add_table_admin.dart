import 'package:checkbox_grouped/checkbox_grouped.dart';
import 'package:easy_localization/easy_localization.dart';
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
                        "add_new_table".tr(),
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
                  title: "table_number".tr(),
                  label: "table_number".tr(),
                  hintText: "text_table_number".tr(),
                  controller: _tableNumController),
              
              //* Num Of People
              CustomTextFormField(
                  title: 'num_of_people'.tr(),
                  label: 'num_of_people'.tr(),
                  hintText: 'text_num_of_people'.tr(),
                  controller: _numOfPeopleController),

              //* Location
              CustomTextFormField(
                  title: 'location'.tr(),
                  label: 'indoor_outdoor'.tr(),
                  hintText: 'text_location'.tr(),
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
                      return Center(
                        child: CircularProgressIndicator(
                          color: primaryColor,
                        ),
                      );
                    }
                    return CustomButton(
                      title: 'add_table'.tr(),
                      onPressed: () {
                        if(_tableNumController.text.contains(RegExp(r'[a-zA-Z]'))) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('validation_table_number'.tr()),
                              backgroundColor: Colors.red,
                            ),
                          );
                        }
                        if(_numOfPeopleController.text.contains(RegExp(r'[a-zA-Z]'))) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('validation_num_of_people'.tr()),
                              backgroundColor: Colors.red,
                            ),
                          );
                        }
                        if(_tableNumController.text.isEmpty ||
                            _numOfPeopleController.text.isEmpty ||
                            _locationController.text.isEmpty) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('validation_all_field'.tr()),
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

                          SnackBar(
                            content: Text('table_add_success'.tr()),
                            backgroundColor: primaryColor,
                            style: whiteTextButtonStyle,
                          ),
                          backgroundColor: greenButtonColor,
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
