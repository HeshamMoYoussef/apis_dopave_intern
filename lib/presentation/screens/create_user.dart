import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:omar_apis/data/data_source/api_service.dart';
import 'package:omar_apis/presentation/manager/user_cubit.dart';

class CreateUserScreen extends StatelessWidget {
  final _formKey = GlobalKey<FormState>(); // Key to manage form state
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _genderController = TextEditingController();
  final _statusController = TextEditingController();

  CreateUserScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Create New User')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              // Name Field
              TextFormField(
                autovalidateMode: AutovalidateMode.onUserInteraction,
                controller: _nameController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a name';
                  }
                  return null;
                },
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.symmetric(
                    vertical: 15.0,
                    horizontal: 20.0,
                  ),
                  labelText: 'Name',
                  labelStyle: const TextStyle(color: Colors.black),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(
                      100.0,
                    ), // Rounded corners
                  ),
                ),
              ),
              SizedBox(height: 16),

              // Email Field
              TextFormField(
                autovalidateMode: AutovalidateMode.onUserInteraction,
                controller: _emailController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter an email';
                  }
                  return null;
                },
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.symmetric(
                    vertical: 15.0,
                    horizontal: 20.0,
                  ),
                  labelText: 'Email Address',
                  labelStyle: const TextStyle(color: Colors.black),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(
                      100.0,
                    ), // Rounded corners
                  ),
                ),
              ),
              SizedBox(height: 16),

              // Gender Field
              TextFormField(
                autovalidateMode: AutovalidateMode.onUserInteraction,
                controller: _genderController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a gender';
                  }
                  return null;
                },
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.symmetric(
                    vertical: 15.0,
                    horizontal: 20.0,
                  ),
                  labelText: 'Gender',
                  labelStyle: const TextStyle(color: Colors.black),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(
                      100.0,
                    ), // Rounded corners
                  ),
                ),
              ),
              SizedBox(height: 16),

              // Status Field
              TextFormField(
                autovalidateMode: AutovalidateMode.onUserInteraction,
                controller: _statusController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a status';
                  }
                  return null;
                },
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.symmetric(
                    vertical: 15.0,
                    horizontal: 20.0,
                  ),
                  labelText: 'Status',
                  labelStyle: const TextStyle(color: Colors.black),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(
                      100.0,
                    ), // Rounded corners
                  ),
                ),
              ),
              SizedBox(height: 24),

              // Submit Button
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    // Create a UserModel from the form data
                    final user = UserModel(
                      name: _nameController.text,
                      email: _emailController.text,
                      gender: _genderController.text,
                      status: _statusController.text,
                    );

                    // Call the UserCubit to create the user
                    context.read<UserCubit>().emitCreateNewUser(user);

                    // Navigate back to the previous screen
                    Navigator.pushReplacementNamed(context, 'result_new_user');
                  }
                },
                child: Text('Create User'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
