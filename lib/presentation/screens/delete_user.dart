import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:omar_apis/core/network_exceptions.dart';
import 'package:omar_apis/presentation/manager/user_cubit.dart';
import 'package:omar_apis/presentation/manager/user_state.dart';

class DeleteUserScreen extends StatelessWidget {
  // final VoidCallback onSave;
  const DeleteUserScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Delete User Screen'),
        centerTitle: true,
        automaticallyImplyLeading: true,
        leading: IconButton(
          onPressed: () {
            // onSave();
            context.read<UserCubit>().emitGetAllUsers();
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back),
        ),
      ),
      body: SafeArea(
        child: BlocBuilder<UserCubit, ResultState<dynamic>>(
          builder: (context, ResultState<dynamic> state) {
            return state.when(
              idle: () => const Center(child: CircularProgressIndicator()),
              loading: () => const Center(child: CircularProgressIndicator()),
              success: (data) {
                log("*******************data ${data.toString()}");
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Center(
                    child: Text(
                      'This User has been deleted Successfully',
                      style: TextStyle(color: Colors.red, fontSize: 20),
                    ),
                  ),
                );
              },
              error:
                  (NetworkExceptions error) => Center(
                    child: Text(
                      NetworkExceptions.getErrorMessage(error),
                      style: TextStyle(color: Colors.red, fontSize: 20),
                    ),
                  ),
            );
          },
        ),
      ),
    );
  }
}
