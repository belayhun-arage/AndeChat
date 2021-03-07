import 'package:ChatUI/libs.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

//Bloc IdeaBloc maps the user event with the corresponding new state
class MyIdeaBloc extends Bloc<IdeaEvent, IdeaState>
    implements Cubit<IdeaState> {
  final Idearepository idearepository;

  MyIdeaBloc({@required this.idearepository})
      : assert(idearepository != null),
        super(IdeaLoading());

  @override
  Stream<IdeaState> mapEventToState(IdeaEvent event) async* {
    if (event is IdeaCreate) {
      try {
        await idearepository.createIdea(event.idea);

        final ideas = await idearepository.getideas(StaticDataStore.ID);
        yield IdeaLoadSuccess(ideas);
      } catch (_) {
        yield IdeaOperationFailure();
      }
    }

    if (event is IdeaLoad) {
      // yield IdeaLoading();
      try {
        final ideas = await idearepository.getideas(StaticDataStore.ID);

        yield IdeaLoadSuccess(ideas);
      } catch (_) {
        yield IdeaOperationFailure();
      }
    }

    if (event is IdeaUpdate) {
      try {
        final result = await idearepository.updateIdea(event.idea);
        if (result) {
          final ideas = await idearepository.getideas(StaticDataStore.ID);
          yield IdeaLoadSuccess(ideas);
        }
      } catch (_) {
        yield IdeaOperationFailure();
      }
    }

    if (event is IdeaDelete) {
      try {
        final value = await idearepository.deleteIdea(event.idea.id);
        final ideaso = await idearepository.getideas(StaticDataStore.ID);
        // List<Idea> ideaso = (state is IdeaLoadSuccess)
        //     ? () {
        //         (state as IdeaLoadSuccess).ideass.removeWhere((idia) {
        //           return (idia.id == event.idea.id);
        //         });
        //         return (state as IdeaLoadSuccess).ideass;
        //       }()
        //     : [];
        yield IdeaLoadSuccess(ideaso);
      } catch (e, a) {
        // print("\n\n\n\n ${e.toString()} \n\n");
        yield IdeaOperationFailure();
      }
    }
  }

  Stream<IdeaState> getMyIdeas() async* {
    try {
      final ideas = await idearepository.getideas(StaticDataStore.ID);
      print(ideas);
      yield IdeaLoadSuccess(ideas);
    } catch (_) {
      yield IdeaOperationFailure();
    }
  }
}
