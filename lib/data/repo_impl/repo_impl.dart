import 'package:omar_apis/core/api_result.dart';
import 'package:omar_apis/core/network_exceptions.dart';
import 'package:omar_apis/data/data_source/api_service.dart';

class RepoImpl {
  final ApiService apiService;

  RepoImpl(this.apiService);

  Future<ApiResult<List<UserModel>>> getAllUsers() async {
    try {
      List<UserModel> response = await apiService.getAllUsers();
      return ApiResult.success(response);
    } catch (error) {
      return ApiResult.failure(NetworkExceptions.getDioException(error));
    }
  }

  Future<ApiResult<UserModel>> createNewUser(UserModel newUser) async {
    try {
      UserModel response = await apiService.createNewUser(newUser);
      return ApiResult.success(response);
    } catch (error) {
      return ApiResult.failure(NetworkExceptions.getDioException(error));
    }
  }

  Future<ApiResult> deleteUser(String id) async {
    try {
      dynamic response = await apiService.deleteUser(id);
      return ApiResult.success(response);
    } catch (error) {
      return ApiResult.failure(NetworkExceptions.getDioException(error));
    }
  }
}
