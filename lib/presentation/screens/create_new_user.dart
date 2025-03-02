import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:omar_apis/utils/app_validation.dart';
import 'package:omar_apis/core/network_exceptions.dart';
import 'package:omar_apis/utils/animation_extension.dart';
import 'package:omar_apis/data/data_source/api_service.dart';
import 'package:omar_apis/presentation/manager/user_cubit.dart';
import 'package:omar_apis/presentation/manager/user_state.dart';
import 'package:omar_apis/presentation/widgets/custom_dropdown.dart';
import 'package:omar_apis/presentation/widgets/custom_form_field.dart';

class CreateNewUser extends StatefulWidget {
  const CreateNewUser({super.key});

  @override
  State<CreateNewUser> createState() => _CreateNewUserState();
}

class _CreateNewUserState extends State<CreateNewUser> {
  final _formKey = GlobalKey<FormState>(); // Key to manage form state
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  String? _selectedGender;
  String? _selectedStatus;
  @override
  void dispose() {
    // Dispose controllers to avoid memory leaks
    _nameController.dispose();
    _emailController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Dismiss the keyboard when tapping outside the input fields
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Create New User').animateShimmer(),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Name Field
                  CustomTextFormField(
                    controller: _nameController,
                    labelText: 'Name',
                    hintText: 'Enter your name',
                    validator: AppValidation.nameValidation(),
                  ),
                  const SizedBox(height: 16),
                  // Email Field
                  CustomTextFormField(
                    controller: _emailController,
                    labelText: 'Email Address',
                    hintText: 'Enter your email',
                    validator: AppValidation.emailValidation(),
                  ),
                  const SizedBox(height: 16),
                  // Gender Field
                  CustomDropdownFormField(
                    labelText: 'Select Your Gender',
                    value: _selectedGender,
                    onChanged: (value) {
                      setState(() {
                        _selectedGender = value; // Update selected gender
                      });
                    },
                    dropdownItems: const [
                      DropdownMenuItem(
                        alignment: Alignment.center,
                        value: 'male',
                        child: Text('Male'),
                      ),
                      DropdownMenuItem(
                        alignment: Alignment.center,
                        value: 'female',
                        child: Text('Female'),
                      ),
                    ],
                    validator: AppValidation.genderValidation(),
                  ),
                  const SizedBox(height: 16),
                  // Status Field
                  CustomDropdownFormField(
                    labelText: 'Select Your Status',
                    value: _selectedStatus,
                    onChanged: (value) {
                      setState(() {
                        _selectedStatus = value; // Update selected status
                      });
                    },
                    dropdownItems: const [
                      DropdownMenuItem(
                        alignment: Alignment.center,
                        value: 'active',
                        child: Text('Active'),
                      ),
                      DropdownMenuItem(
                        alignment: Alignment.center,
                        value: 'inactive',
                        child: Text('Inactive'),
                      ),
                    ],
                    validator: AppValidation.statusValidation(),
                  ),
                  const SizedBox(height: 24),
                  // Submit Button
                  BlocConsumer<UserCubit, ResultState<dynamic>>(
                    listener: (context, state) {
                      state.when(
                        idle: () {},
                        loading: () {},
                        success: (data) {
                          // Show success toast
                          Fluttertoast.showToast(
                            msg: "User created successfully!",
                            backgroundColor: Colors.green,
                          );
                          // Clear the form fields after successful creation
                          _nameController.clear();
                          _emailController.clear();
                          setState(() {
                            _selectedGender = null;
                            _selectedStatus = null;
                          });
                          // Refresh the user list and navigate back
                          context.read<UserCubit>().emitGetAllUsers();
                          Navigator.pop(context);
                        },
                        error: (NetworkExceptions error) {
                          // Show error toast
                          Fluttertoast.showToast(
                            msg: NetworkExceptions.getErrorMessage(error),
                            backgroundColor: Colors.red,
                          );
                        },
                      );
                    },
                    builder: (context, state) {
                      return SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              // Create a UserModel from the form data
                              final user = UserModel(
                                name: _nameController.text,
                                email: _emailController.text,
                                gender: _selectedGender,
                                status: _selectedStatus,
                              );

                              // Call the UserCubit to create the user
                              context.read<UserCubit>().emitCreateNewUser(user);
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 32,
                              vertical: 16,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(100),
                            ),
                          ),
                          child:
                              state is Loading
                                  ? const SizedBox(
                                    height: 20,
                                    width: 20,
                                    child: CircularProgressIndicator(
                                      color: Color(0xff6200ee),
                                      strokeWidth: 2.5,
                                    ),
                                  ) // Show loading indicator
                                  : const Text(
                                    'Create User',
                                    style: TextStyle(fontSize: 16),
                                  ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
