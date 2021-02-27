import 'package:ChatUI/ideas/data_provider/data_provider.dart';
import 'package:ChatUI/ideas/models/models.dart';

class Idearepository {
  final IdeaDataProvider provider;

  Idearepository({this.provider}) : assert(IdeaDataProvider != null);

  Future<Idea> createIdea(Idea idea) async {
    return await provider.createIdea(idea);
  }

  Future<List<Idea>> getideas() async {
    return await provider.getIdeas();
  }

  Future<void> updateIdea(Idea idea) async {
    return await provider.updateIdea(idea);
  }

  Future<void> deleteIdea(String id) async {
    return await provider.deleteIdea(id);
  }
}
