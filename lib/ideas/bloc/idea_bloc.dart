import 'package:ChatUI/libs.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class IdeaBloc extends Bloc<IdeaEvent, IdeaState> implements Cubit<IdeaState> {
  final Idearepository idearepository;

  IdeaBloc({@required this.idearepository})
      : assert(idearepository != null),
        super(IdeaLoading());

  @override
  Stream<IdeaState> mapEventToState(IdeaEvent event) async* {
    if (event is IdeaCreate) {
      try {
        await idearepository.createIdea(event.idea);

        final ideas = await idearepository.getideas();
        yield IdeaLoadSuccess(ideas);
      } catch (_) {
        yield IdeaOperationFailure();
      }
    }
    if (event is IdeaLoad) {
      // yield IdeaLoading();
      try {
        final ideas = await idearepository.getideas();

        yield IdeaLoadSuccess(ideas);
      } catch (_) {
        yield IdeaOperationFailure();
      }
    }

    if (event is IdeaUpdate) {
      try {
        // print("ellllllllllllllelllllll");
        await idearepository.updateIdea(event.idea);
        print("ellllllllllllllelllllll");
        final ideas = await idearepository.getideas();
        yield IdeaLoadSuccess(ideas);
      } catch (_) {
        yield IdeaOperationFailure();
      }
    }

    if (event is IdeaDelete) {
      try {
        print("samuel${event.idea.id}");
        await idearepository.deleteIdea(event.idea.id);

        print("beka litegna new" + event.idea.id);
        final ideas = await idearepository.getideas();
        yield IdeaLoadSuccess(ideas);
      } catch (_) {
        yield IdeaOperationFailure();
      }
    }
  }
  // TODO: implement mapEventToState
  //throw UnimplementedError();

  Stream<IdeaState> getMyIdeas() async* {
    try {
      final ideas = await idearepository.getideas();
      print(ideas);
      yield IdeaLoadSuccess(ideas);
    } catch (_) {
      yield IdeaOperationFailure();
    }
  }
}
