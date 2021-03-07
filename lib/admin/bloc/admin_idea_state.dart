import 'package:ChatUI/libs.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AdminIdeaState extends Cubit<List<Idea>> {
  static AdminIdeaState _instance;
  AdminIdeaState({this.repo}) : super(null) {
    if (_instance == null) {
      _instance == this;
    }
  }

  static AdminIdeaState get instance {
    return _instance;
  }

  AdminIdeaRepository repo;
  updateIdeas(List<Idea> ideas) {
    emit(ideas);
  }

  Future<void> searchIdeas(String title) async {
    final ideas = await this.repo.searchIdea(title);
    if (ideas != null) {
      emit(ideas);
    }
    return;
  }

  Future<void> loadSampleIdeas() async {
    final ideas = await this.repo.loadSampleIdeas();
    if (ideas != null) {
      emit(ideas);
    }
    return;
  }

  Future<void> deleteIdea(String ideaid) async {
    final success = await this.repo.deleteIdea(ideaid);
    if (success) {
      List<Idea> ideas = this.state;
      alies.removeWhere((ali) {
        if (ali.id == ideaid) {
          return true;
        }
        return false;
      });
      emit(ideas);
    }
  }
}
