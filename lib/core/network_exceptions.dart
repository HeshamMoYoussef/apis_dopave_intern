import 'dart:io';
import 'package:dio/dio.dart';
import 'package:omar_apis/core/error_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'network_exceptions.freezed.dart';

@freezed
class NetworkExceptions with _$NetworkExceptions {
  const factory NetworkExceptions.requestCancelled() = RequestCancelled;
  const factory NetworkExceptions.unauthorizedRequest(String reason) =
      UnauthorizedRequest;
  const factory NetworkExceptions.badRequest() = BadRequest;
  const factory NetworkExceptions.notFound(String reason) = NotFound;
  const factory NetworkExceptions.methodNotAllowed() = MethodNotAllowed;
  const factory NetworkExceptions.notAcceptable() = NotAcceptable;
  const factory NetworkExceptions.requestTimeout() = RequestTimeout;
  const factory NetworkExceptions.sendTimeout() = SendTimeout;
  const factory NetworkExceptions.unprocessableEntity(String reason) =
      UnprocessableEntity;
  const factory NetworkExceptions.conflict() = Conflict;
  const factory NetworkExceptions.internalServerError() = InternalServerError;
  const factory NetworkExceptions.notImplemented() = NotImplemented;
  const factory NetworkExceptions.serviceUnavailable() = ServiceUnavailable;
  const factory NetworkExceptions.noInternetConnection() = NoInternetConnection;
  const factory NetworkExceptions.formatException() = FormatException;
  const factory NetworkExceptions.unableToProcess() = UnableToProcess;
  const factory NetworkExceptions.defaultError(String error) = DefaultError;
  const factory NetworkExceptions.unexpectedError() = UnexpectedError;

  /// Handles Dio response errors and returns a [NetworkExceptions] object.
  static NetworkExceptions handleResponse(Response? response) {
    final int statusCode = response?.statusCode ?? 0;
    final String errors = _extractErrors(response);

    return switch (statusCode) {
      400 || 401 || 403 => NetworkExceptions.unauthorizedRequest(errors),
      404 => NetworkExceptions.notFound(errors),
      408 => const NetworkExceptions.requestTimeout(),
      409 => const NetworkExceptions.conflict(),
      422 => NetworkExceptions.unprocessableEntity(errors),
      500 => const NetworkExceptions.internalServerError(),
      503 => const NetworkExceptions.serviceUnavailable(),
      _ => NetworkExceptions.defaultError(
        "Received invalid status code: $statusCode",
      ),
    };
  }

  /// Extracts error messages from the response and formats them.
  static String _extractErrors(Response? response) {
    if (response?.data == null) return "Unknown error";

    try {
      final dynamic data = response!.data;

      if (data is List) {
        return data
            .map((e) => ErrorModel.fromJson(e))
            .map((e) => "${e.field}: ${e.message}")
            .join(", ");
      } else if (data is Map<String, dynamic> && data.containsKey("errors")) {
        return (data["errors"] as List)
            .map(
              (e) => "${e['field'] ?? 'Error'}: ${e['message'] ?? 'Unknown'}",
            )
            .join(", ");
      }

      return "Unexpected error format";
    } catch (e) {
      return "Failed to parse error response";
    }
  }

  /// Converts Dio or other exceptions into [NetworkExceptions].
  static NetworkExceptions getDioException(dynamic error) {
    if (error is DioException) {
      return _handleDioException(error);
    } else if (error is SocketException) {
      return const NetworkExceptions.noInternetConnection();
    } else if (error is FormatException) {
      return const NetworkExceptions.formatException();
    } else if (error.toString().contains("is not a subtype of")) {
      return const NetworkExceptions.unableToProcess();
    } else {
      return const NetworkExceptions.unexpectedError();
    }
  }

  /// Handles Dio-specific exceptions.
  static NetworkExceptions _handleDioException(DioException error) {
    final DioExceptionType type = error.type;
    final Response? response = error.response;

    return switch (type) {
      DioExceptionType.cancel => const NetworkExceptions.requestCancelled(),
      DioExceptionType.connectionTimeout =>
        const NetworkExceptions.requestTimeout(),
      DioExceptionType.connectionError =>
        const NetworkExceptions.noInternetConnection(),
      DioExceptionType.receiveTimeout => const NetworkExceptions.sendTimeout(),
      DioExceptionType.sendTimeout => const NetworkExceptions.sendTimeout(),
      DioExceptionType.badResponse => handleResponse(response),
      DioExceptionType.badCertificate => const NetworkExceptions.badRequest(),
      DioExceptionType.unknown => NetworkExceptions.defaultError(
        "Unknown Dio error: ${error.message ?? 'No details available'}",
      ),
    };
  }

  /// Returns a user-friendly error message for a given [NetworkExceptions].
  static String getErrorMessage(NetworkExceptions exception) {
    return exception.when(
      requestCancelled: () => "Request was cancelled",
      unauthorizedRequest: (reason) => reason,
      badRequest: () => "Bad request, please try again",
      notFound: (reason) => "Not found: $reason",
      methodNotAllowed: () => "Method not allowed",
      notAcceptable: () => "Request not acceptable",
      requestTimeout: () => "Connection timeout, please try again",
      sendTimeout: () => "Send timeout, please check your network",
      unprocessableEntity: (reason) => "Unprocessable Entity: $reason",
      conflict: () => "Conflict occurred, please retry",
      internalServerError: () => "Internal server error, please try later",
      notImplemented: () => "Feature not implemented",
      serviceUnavailable: () => "Service unavailable, please try later",
      noInternetConnection: () => "No internet connection",
      formatException: () => "Invalid response format",
      unableToProcess: () => "Unable to process the request",
      defaultError: (error) => "Error: $error",
      unexpectedError: () => "An unexpected error occurred",
    );
  }
}
