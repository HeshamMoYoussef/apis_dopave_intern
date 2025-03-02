import 'dart:developer';

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:omar_apis/core/network_exceptions.dart';

part 'api_result.freezed.dart';

/// A generic class that represents either a success or a failure.
@freezed
abstract class ApiResult<T> with _$ApiResult<T> {
  const factory ApiResult.success(T data) = Success<T>;
  const factory ApiResult.failure(NetworkExceptions networkExceptions) =
      Failure<T>;

  const ApiResult._();

  /// Returns `true` if the result is a success.
  bool get isSuccess => this is Success<T>;

  /// Returns `true` if the result is a failure.
  bool get isFailure => this is Failure<T>;

  /// Returns the success data if the result is a success, otherwise returns `null`.
  T? get successData => isSuccess ? (this as Success<T>).data : null;

  /// Returns the failure error if the result is a failure, otherwise returns `null`.
  NetworkExceptions? get failureError =>
      isFailure ? (this as Failure<T>).networkExceptions : null;

  /// Handles the result and returns a value based on whether it is a success or a failure.
  @override
  R when<R>({
    required R Function(T data) success,
    required R Function(NetworkExceptions error) failure,
  }) {
    return map(
      success: (s) => success(s.data),
      failure: (f) => failure(f.networkExceptions),
    );
  }

  /// Handles the result and returns a value based on whether it is a success or a failure.
  @override
  R maybeWhen<R>({
    required R Function() orElse,
    R Function(T data)? success,
    R Function(NetworkExceptions error)? failure,
  }) {
    return map(
      success: (s) => success != null ? success(s.data) : orElse(),
      failure: (f) => failure != null ? failure(f.networkExceptions) : orElse(),
    );
  }

  /// Maps the result to a new `ApiResult` type.
  ApiResult<R> mapSuccess<R>(R Function(T data) mapper) {
    return when(
      success: (data) => ApiResult.success(mapper(data)),
      failure: (error) => ApiResult.failure(error),
    );
  }

  /// Handles the failure case and returns a default value.
  T handleFailure(T Function(NetworkExceptions error) handler) {
    return when(success: (data) => data, failure: (error) => handler(error));
  }

  /// Logs the error if the result is a failure.
  void logError({String? message}) {
    if (isFailure) {
      final error = failureError!;
      log('${message ?? 'Error'}: ${NetworkExceptions.getErrorMessage(error)}');
    }
  }

  /// Safely casts the success data to a different type.
  ApiResult<R> cast<R>() {
    return when(
      success: (data) {
        if (data is R) {
          return ApiResult.success(data as R);
        } else {
          return ApiResult.failure(const NetworkExceptions.unableToProcess());
        }
      },
      failure: (error) => ApiResult.failure(error),
    );
  }
}
