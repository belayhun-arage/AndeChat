import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc/src/bloc_provider.dart';


class ValuesObserver extends BlocObserver {
  @override
  void onEvent(Bloc bloc, dynamic event) {
    super.onEvent(bloc, event);
  }

  @override
  void onTransition(Bloc bloc, dynamic event) {
    print(event);
    super.onTransition(bloc, event);
  }

  @override
  void onChange(Cubit cubit, Change change) {
    print(change);
    super.onChange(cubit, change);
  }

  @override
  void onError(Cubit cubit, Object error, StackTrace stackTrace) {
    print(error);
    super.onError(cubit, error, stackTrace);
  }
}
