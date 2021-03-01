import 'package:ChatUI/ideas/data_provider/data_provider.dart';
import 'package:ChatUI/ideas/models/models.dart';

class Idearepository {
  IdeaDataProvider provider;

  Idearepository() : assert(IdeaDataProvider != null) {
    IdeaDataProvider.getInstance().then((value) {
      this.provider = value;
    });
  }

  Future<Idea> createIdea(Idea idea) async {
    return await provider.createIdea(idea);
  }

  Future<List<Idea>> getideasMoney() async {
    return await provider.getIdeasMoney();
  }

  Future<List<Idea>> getideas(String userid) async {
    return await provider.getIdeas(userid);
  }

  Future<void> updateIdea(Idea idea) async {
    return await provider.updateIdea(idea);
  }

  Future<void> deleteIdea(String id) async {
    return await provider.deleteIdea(id);
  }
}
