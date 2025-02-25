import 'package:omar_apis/core/network_exceptions.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_state.freezed.dart';

@freezed
class ResultState<T> with _$ResultState<T> {
  const factory ResultState.idle() = Idle<T>;
  const factory ResultState.loading() = Loading<T>;
  const factory ResultState.success(T data) = Success<T>;
  const factory ResultState.error(NetworkExceptions networkExceptions) =
      Error<T>;
}

// part of 'user_cubit.dart';

// abstract class UserState {}

// class UserInitial extends UserState {}

// /*   States for all users HomeScreen   */
// class GetAllUsersSuccessState extends UserState {
//   final List<UserModel> users;
//   GetAllUsersSuccessState(this.users);
// }

// class GetAllUsersErrorState extends UserState {
//   final String errorMessage;
//   GetAllUsersErrorState(this.errorMessage);
// }

// /*  States for creating new user  */

// class CreateNewUserState extends UserState {
//   final UserModel newUser;

//   CreateNewUserState(this.newUser);
// }

// class DeleteUserState extends UserState {
//   final HttpResponse data;

//   DeleteUserState(this.data);
// }
