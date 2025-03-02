import 'package:bloc/bloc.dart';
import 'package:omar_apis/core/api_result.dart';
import 'package:omar_apis/core/network_exceptions.dart';
import 'package:omar_apis/data/repo_impl/repo_impl.dart';
import 'package:omar_apis/data/data_source/api_service.dart';
import 'package:omar_apis/presentation/manager/user_state.dart';

class UserCubit extends Cubit<ResultState<dynamic>> {
  final RepoImpl repoImpl;
  UserCubit(this.repoImpl) : super(const Idle());

  void emitGetAllUsers() async {
    emit(Loading());
    ApiResult<List<UserModel>> data = await repoImpl.getAllUsers();
    data.when(
      success:
          (List<UserModel> allUsers) => emit(ResultState.success(allUsers)),
      failure:
          (NetworkExceptions networkExceptions) =>
              emit(ResultState.error(networkExceptions)),
    );
  }

  void emitCreateNewUser(UserModel newUser) async {
    emit(Loading());
    ApiResult<UserModel> data = await repoImpl.createNewUser(newUser);
    data.when(
      success: (newUser) => emit(ResultState.success(newUser)),
      failure:
          (NetworkExceptions networkExceptions) =>
              emit(ResultState.error(networkExceptions)),
    );
  }

  void emitDeleteUser(String id) async {
    emit(Loading());
    ApiResult<dynamic> data = await repoImpl.deleteUser(id);
    data.when(
      success: (data) => emit(ResultState.success(data)),
      failure:
          (NetworkExceptions networkExceptions) =>
              emit(ResultState.error(networkExceptions)),
    );
  }
}
