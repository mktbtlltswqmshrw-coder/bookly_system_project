import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// مراقب عام لجميع Blocs في التطبيق لتتبع Events و States
class AppBlocObserver extends BlocObserver {
  @override
  void onEvent(Bloc bloc, Object? event) {
    super.onEvent(bloc, event);
    debugPrint('🎯 [${bloc.runtimeType}] Event: $event');
  }

  @override
  void onChange(BlocBase bloc, Change change) {
    super.onChange(bloc, change);
    debugPrint(
      '🔄 [${bloc.runtimeType}] Change: ${change.currentState.runtimeType} -> ${change.nextState.runtimeType}',
    );

    // طباعة تفاصيل إضافية للـ ProductsBloc
    if (bloc.runtimeType.toString().contains('Products')) {
      debugPrint('📦 Products State Details: ${change.nextState}');
    }
  }

  @override
  void onError(BlocBase bloc, Object error, StackTrace stackTrace) {
    debugPrint('❌ [${bloc.runtimeType}] Error: $error');
    debugPrint('📍 Stack Trace: $stackTrace');
    super.onError(bloc, error, stackTrace);
  }

  @override
  void onTransition(Bloc bloc, Transition transition) {
    super.onTransition(bloc, transition);
    debugPrint('🚀 [${bloc.runtimeType}] Transition: ${transition.event} -> ${transition.nextState.runtimeType}');
  }
}
