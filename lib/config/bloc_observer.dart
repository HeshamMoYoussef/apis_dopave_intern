import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';

/// Log levels for categorizing logs.
enum LogLevel { info, warning, error }

/// A custom BlocObserver that logs detailed information about Bloc and Cubit events.
class AppBlocObserver extends BlocObserver {
  /// Logs when a Bloc or Cubit is created.
  @override
  void onCreate(BlocBase bloc) {
    super.onCreate(bloc);
    _log('🚀 ${bloc.runtimeType} created', bloc, level: LogLevel.info);
  }

  /// Logs when a Bloc or Cubit receives an event.
  @override
  void onEvent(Bloc bloc, Object? event) {
    super.onEvent(bloc, event);
    _log(
      '🎯 ${bloc.runtimeType} received event: $event',
      bloc,
      level: LogLevel.info,
    );
  }

  /// Logs when a Bloc or Cubit's state changes.
  @override
  void onChange(BlocBase bloc, Change change) {
    super.onChange(bloc, change);
    _log(
      '🔄 ${bloc.runtimeType} state changed: ${change.currentState} -> ${change.nextState}',
      bloc,
      level: LogLevel.info,
    );
  }

  /// Logs when an error occurs in a Bloc or Cubit.
  @override
  void onError(BlocBase bloc, Object error, StackTrace stackTrace) {
    super.onError(bloc, error, stackTrace);
    _log(
      '❌ ${bloc.runtimeType} error: $error',
      bloc,
      level: LogLevel.error,
      stackTrace: stackTrace,
    );
  }

  /// Logs when a Bloc or Cubit is closed.
  @override
  void onClose(BlocBase bloc) {
    super.onClose(bloc);
    _log('🔚 ${bloc.runtimeType} closed', bloc, level: LogLevel.info);
  }

  /// Logs when a transition occurs in a Bloc.
  @override
  void onTransition(Bloc bloc, Transition transition) {
    super.onTransition(bloc, transition);
    _log(
      '➡️ ${bloc.runtimeType} transition: ${transition.event} -> ${transition.nextState}',
      bloc,
      level: LogLevel.info,
    );
  }

  /// Helper method to log messages with additional context.
  void _log(
    String message,
    BlocBase bloc, {
    LogLevel level = LogLevel.info,
    StackTrace? stackTrace,
  }) {
    final timestamp = DateTime.now().toIso8601String();
    final logMessage = '''
📝 [$timestamp] ${_getLogLevelEmoji(level)} $message
📦 Bloc: ${bloc.runtimeType}
🆔 HashCode: ${bloc.hashCode}
''';

    if (level == LogLevel.error) {
      log(
        logMessage,
        name: 'AppBlocObserver',
        error: message,
        stackTrace: stackTrace,
      );
    } else {
      log(logMessage, name: 'AppBlocObserver');
    }

    // Optionally, send logs to a remote server or save them to a file.
    _sendLogsToRemote(logMessage);
  }

  /// Returns an emoji based on the log level.
  String _getLogLevelEmoji(LogLevel level) {
    return switch (level) {
      LogLevel.info => 'ℹ️',
      LogLevel.warning => '⚠️',
      LogLevel.error => '❌',
    };
  }

  /// Sends logs to a remote server or saves them to a file (optional).
  void _sendLogsToRemote(String logMessage) {
    // Example: Send logs to a remote server or save them to a file.
    // This is a placeholder for actual implementation.
    // You can use packages like `dio` or `http` to send logs to a server.
    // Alternatively, use `package:logger` to save logs to a file.
    // print('Sending logs to remote server: $logMessage');
  }
}

// import 'dart:developer';

// import 'package:flutter_bloc/flutter_bloc.dart';

// /// A custom BlocObserver that logs detailed information about Bloc and Cubit events.
// class AppBlocObserver extends BlocObserver {
//   /// Logs when a Bloc or Cubit is created.
//   @override
//   void onCreate(BlocBase bloc) {
//     super.onCreate(bloc);
//     _log('🚀 ${bloc.runtimeType} created', bloc);
//   }

//   /// Logs when a Bloc or Cubit receives an event.
//   @override
//   void onEvent(Bloc bloc, Object? event) {
//     super.onEvent(bloc, event);
//     _log('🎯 ${bloc.runtimeType} received event: $event', bloc);
//   }

//   /// Logs when a Bloc or Cubit's state changes.
//   @override
//   void onChange(BlocBase bloc, Change change) {
//     super.onChange(bloc, change);
//     _log(
//       '🔄 ${bloc.runtimeType} state changed: ${change.currentState} -> ${change.nextState}',
//       bloc,
//     );
//   }

//   /// Logs when an error occurs in a Bloc or Cubit.
//   @override
//   void onError(BlocBase bloc, Object error, StackTrace stackTrace) {
//     super.onError(bloc, error, stackTrace);
//     _log(
//       '❌ ${bloc.runtimeType} error: $error\nStack trace: $stackTrace',
//       bloc,
//       isError: true,
//     );
//   }

//   /// Logs when a Bloc or Cubit is closed.
//   @override
//   void onClose(BlocBase bloc) {
//     super.onClose(bloc);
//     _log('🔚 ${bloc.runtimeType} closed', bloc);
//   }

//   /// Logs when a transition occurs in a Bloc.
//   @override
//   void onTransition(Bloc bloc, Transition transition) {
//     super.onTransition(bloc, transition);
//     _log(
//       '➡️ ${bloc.runtimeType} transition: ${transition.event} -> ${transition.nextState}',
//       bloc,
//     );
//   }

//   /// Helper method to log messages with additional context.
//   void _log(String message, BlocBase bloc, {bool isError = false}) {
//     final logMessage = '$message\nBloc: ${bloc.runtimeType}';
//     if (isError) {
//       log(
//         logMessage,
//         name: 'AppBlocObserver',
//         error: message,
//         stackTrace: StackTrace.current,
//       );
//     } else {
//       log(logMessage, name: 'AppBlocObserver');
//     }
//   }
// }
