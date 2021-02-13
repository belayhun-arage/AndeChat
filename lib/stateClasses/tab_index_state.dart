import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc/src/bloc_provider.dart';
import 'package:flutter/material.dart';

enum TabChangeEvent {
  home,
  messages,
  online,
  groups,
}

class TabIndex extends Bloc<TabChangeEvent, int> {
  TabIndex() : super(0);

  @override
  Stream<int> mapEventToState(TabChangeEvent event) async* {
    switch (event) {
      case TabChangeEvent.home:
        {
          yield 0;
          break;
        }
      case TabChangeEvent.messages:
        {
          yield 1;
          break;
        }
      case TabChangeEvent.online:
        {
          yield 2;
          break;
        }
      case TabChangeEvent.groups:
        {
          yield 3;
          break;
        }
    }
  }
}
