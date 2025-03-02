import 'package:flutter/material.dart';
import 'package:omar_apis/core/injection.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:omar_apis/config/bloc_observer.dart';
import 'package:omar_apis/presentation/manager/user_cubit.dart';
import 'package:omar_apis/presentation/screens/get_all_users.dart';
import 'package:omar_apis/presentation/screens/create_new_user.dart';

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
          '/': (context) => const GetAllUsersScreen(),
          '/create_new_user': (context) => const CreateNewUser(),
        },
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          appBarTheme: AppBarTheme(backgroundColor: Colors.blueGrey.shade200),
          scaffoldBackgroundColor: Colors.blueGrey.shade100,

          useMaterial3: true,
        ),
      ),
    );
  }
}
