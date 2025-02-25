import 'dart:developer';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppBlocObserver extends BlocObserver {
  @override
  void onCreate(BlocBase bloc) {
    super.onCreate(bloc);
    log('${bloc.runtimeType} created');
  }

  @override
  void onEvent(Bloc bloc, Object? event) {
    super.onEvent(bloc, event);
    log('${bloc.runtimeType} received event: $event');
  }

  @override
  void onChange(BlocBase bloc, Change change) {
    super.onChange(bloc, change);
    log('${bloc.runtimeType} state changed: $change');
  }

  @override
  void onError(BlocBase bloc, Object error, StackTrace stackTrace) {
    super.onError(bloc, error, stackTrace);
    log('${bloc.runtimeType} error: $error');
  }

  @override
  void onClose(BlocBase bloc) {
    super.onClose(bloc);
    log('${bloc.runtimeType} closed');
  }
}
