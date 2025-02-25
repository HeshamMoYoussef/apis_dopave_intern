import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:json_annotation/json_annotation.dart';

part 'api_service.g.dart';

@RestApi(baseUrl: 'https://gorest.co.in/public/v2/')
abstract class ApiService {
  factory ApiService(Dio dio, {String baseUrl}) = _ApiService;

  // Simple GET request to get all users
  @GET('users')
  Future<List<UserModel>> getAllUsers();

  // Create New User
  @POST('users')
  Future<UserModel> createNewUser(
    @Body() UserModel newUser,
    // @Header('Authorization') String token,
  );

  // Delete User
  @DELETE('users/{id}')
  Future<dynamic> deleteUser(@Path() String id);
}

//        Users Model //
@JsonSerializable()
class UserModel {
  int? id;
  String? name;
  String? email;
  String? gender;
  String? status;

  UserModel({this.id, this.name, this.email, this.gender, this.status});

  /// Connect the generated [_$UsersModelFromJson] function to the `fromJson`
  /// factory.
  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);

  /// Connect the generated [_$UsersModelToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() => _$UserModelToJson(this);
}

//        Dio  Interceptors //
Dio createAndSetupDio() {
  Dio dio = Dio();
  dio
    ..options.connectTimeout = const Duration(seconds: 10)
    ..options.receiveTimeout = const Duration(seconds: 5)
    ..options.sendTimeout = const Duration(seconds: 5)
    ..options.headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization':
          'Bearer f764fca38cda9cbe067a216ac55919e9774dc0ec9b2e991822e67fd38fc17827',
    };
  dio.interceptors.add(
    LogInterceptor(
      requestBody: true,
      responseBody: true,
      request: true,
      error: true,
      requestHeader: false,
      responseHeader: false,
    ),
  );
  return dio;
}
