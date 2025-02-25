import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:omar_apis/core/network_exceptions.dart';
import 'package:omar_apis/presentation/manager/user_cubit.dart';
import 'package:omar_apis/presentation/manager/user_state.dart';

class GetAllUsersScreen extends StatelessWidget {
  const GetAllUsersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Home Screen'), centerTitle: true),
      body: SafeArea(
        child: BlocBuilder<UserCubit, ResultState<dynamic>>(
          builder: (context, ResultState<dynamic> state) {
            return state.when(
              idle: () => const Center(child: CircularProgressIndicator()),
              loading: () => const Center(child: CircularProgressIndicator()),
              success: (listData) {
                // if (listData is List<UserModel>) {
                //   usersList = listData;
                // } else if (listData is UserModel) {
                //   usersList = [listData];
                // }
                return ListView.builder(
                  itemCount: listData.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Center(
                        child: ListTile(
                          leading: Text(listData[index].id!.toString()),
                          title: Text(listData[index].name ?? "not found"),
                          subtitle: Text(listData[index].email ?? "not found"),
                          trailing: FittedBox(
                            child: Row(
                              children: [
                                Text(listData[index].gender ?? "not found"),
                                SizedBox(width: 10),

                                ElevatedButton(
                                  onPressed: () {
                                    // ToDO : New User Function
                                    context.read<UserCubit>().emitDeleteUser(
                                      listData[index].id.toString(),
                                    );
                                    Navigator.pushNamed(
                                      context,
                                      '/delete_user',
                                    );
                                  },
                                  child: Text(
                                    'Delete',
                                    style: TextStyle(color: Colors.red),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  },
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
