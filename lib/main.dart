import 'package:flutter/material.dart';
import 'package:omar_apis/core/injection.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:omar_apis/config/bloc_observer.dart';
import 'package:omar_apis/presentation/manager/user_cubit.dart';
import 'package:omar_apis/presentation/screens/create_user.dart';
import 'package:omar_apis/presentation/screens/delete_user.dart';
import 'package:omar_apis/presentation/screens/home_screen.dart';
import 'package:omar_apis/presentation/screens/get_all_users.dart';
import 'package:omar_apis/presentation/screens/result_new_user.dart';

void main() {
  // Set the global BlocObserver
  Bloc.observer = AppBlocObserver();
  initGetIt();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    // Provide UserCubit here to all screens
    return BlocProvider(
      create: (context) => getIt<UserCubit>(),
      child: MaterialApp(
        routes: {
          '/': (context) => const HomeScreen(),
          '/get_all_users': (context) => const GetAllUsersScreen(),
          'create_new_user': (context) => CreateUserScreen(),
          'result_new_user': (context) => ResultNewUserScreen(),
          '/delete_user': (context) => const DeleteUserScreen(),
        },
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.white),
          useMaterial3: true,
        ),
      ),
    );
  }
}
