import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:omar_apis/core/network_exceptions.dart';
import 'package:omar_apis/data/data_source/api_service.dart';
import 'package:omar_apis/presentation/manager/user_cubit.dart';
import 'package:omar_apis/presentation/manager/user_state.dart';

class ResultNewUserScreen extends StatelessWidget {
  final newUser = UserModel();
  ResultNewUserScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('New User Screen'), centerTitle: true),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: BlocBuilder<UserCubit, ResultState<dynamic>>(
            builder: (context, ResultState<dynamic> state) {
              return state.when(
                idle: () => const Center(child: CircularProgressIndicator()),
                loading: () => const Center(child: CircularProgressIndicator()),
                success: (data) {
                  var newUser = data;
                  return Center(
                    child: ListTile(
                      title: Text(newUser.email!),
                      subtitle: Text(newUser.name!),
                      trailing: Text(newUser.gender!),
                      leading: Text(newUser.id!.toString()),
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
      ),
    );
  }
}
