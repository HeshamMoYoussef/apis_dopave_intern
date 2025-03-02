import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:omar_apis/core/network_exceptions.dart';
import 'package:omar_apis/presentation/manager/user_cubit.dart';
import 'package:omar_apis/presentation/manager/user_state.dart';
import 'package:omar_apis/presentation/widgets/custom_indicator.dart';
import 'package:omar_apis/presentation/widgets/dismissible_background_widget.dart';
import 'package:omar_apis/utils/animation_extension.dart';

class GetAllUsersScreen extends StatefulWidget {
  const GetAllUsersScreen({super.key});

  @override
  State<GetAllUsersScreen> createState() => _GetAllUsersScreenState();
}

class _GetAllUsersScreenState extends State<GetAllUsersScreen> {
  @override
  void initState() {
    // Fetch users when the screen is first loaded
    context.read<UserCubit>().emitGetAllUsers();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('User List').animateShimmer(),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.refresh),
          onPressed: () {
            // Refresh the user list
            context.read<UserCubit>().emitGetAllUsers();
          },
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.add_circle),
            onPressed: () {
              // Navigate to the screen for creating a new user
              Navigator.pushNamed(context, '/create_new_user');
            },
          ),
        ],
      ),
      body: SafeArea(
        child: BlocBuilder<UserCubit, ResultState<dynamic>>(
          builder: (context, ResultState<dynamic> state) {
            return state.when(
              idle: () => CustomProgressIndicator(),
              loading: () => CustomProgressIndicator(),
              success: (listData) {
                if (listData.isEmpty) {
                  context.read<UserCubit>().emitGetAllUsers();
                  return const Center(
                    child: Text(
                      'No users found',
                      style: TextStyle(fontSize: 18, color: Colors.grey),
                    ),
                  );
                }
                return ListView.builder(
                  itemCount: listData.length,
                  itemBuilder: (context, index) {
                    final user = listData[index];
                    return Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Center(
                        child: Dismissible(
                          key: Key(user.id.toString()),
                          direction: DismissDirection.horizontal,
                          background: DismissibleBackgroundWidget(),
                          onDismissed: (direction) {
                            _onDismissFunc(context, user);
                          },
                          child:
                              ListTile(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(25),
                                ),
                                horizontalTitleGap: 25,
                                leading: Text(user.status ?? "not found"),
                                title: Text(user.name ?? "not found"),
                                subtitle: Text(user.email ?? "not found"),
                                trailing: FittedBox(
                                  child: Row(
                                    children: [
                                      Text(user.gender ?? "not found"),
                                      const SizedBox(width: 10),
                                    ],
                                  ),
                                ),
                              ).animateFlipHorizontal(),
                        ),
                      ),
                    );
                  },
                );
              },
              error: (NetworkExceptions error) {
                // Show error toast
                Fluttertoast.showToast(
                  msg: NetworkExceptions.getErrorMessage(error),
                  backgroundColor: Colors.red,
                );
                return const Center(
                  child: Text(
                    'Failed to load users',
                    style: TextStyle(fontSize: 18, color: Colors.red),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }

  void _onDismissFunc(BuildContext context, user) {
    try {
      context.read<UserCubit>().emitDeleteUser(user.id.toString());

      Fluttertoast.showToast(
        msg: "Deleted Successfully!",
        backgroundColor: Colors.green,
      );
    } catch (e) {
      Fluttertoast.showToast(
        msg: "Deletion Failed!",
        backgroundColor: Colors.red,
      );
    }
    context.read<UserCubit>().emitGetAllUsers();
  }
}
