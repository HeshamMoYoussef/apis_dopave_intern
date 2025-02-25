import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:omar_apis/presentation/manager/user_cubit.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Home Screen'), centerTitle: true),
      body: SizedBox(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ElevatedButton(
              child: Text('Get All Users'),
              onPressed: () {
                context.read<UserCubit>().emitGetAllUsers();
                Navigator.pushNamed(context, '/get_all_users');
              },
            ),
            SizedBox(height: 20),
            ElevatedButton(
              child: Text('Create New User'),
              onPressed: () {
                Navigator.of(context).pushNamed('create_new_user');
              },
            ),
          ],
        ),
      ),
    );
  }
}
