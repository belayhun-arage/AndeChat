import 'package:ChatUI/ideas/data_provider/data_provider.dart';
import 'package:ChatUI/ideas/models/models.dart';

//Class Idearepository acts as a bridge between the ideabloc and ideadatabrovider
//accept requests from the idea business logic, filter  raw data's from ideadataProvider and respond to the bloc
class Idearepository {
  IdeaDataProvider provider;

  Idearepository() : assert(IdeaDataProvider != null) {
    IdeaDataProvider.getInstance().then((value) {
      this.provider = value;
    });
  }

  //a signature of crude createIdea to createIdeas asynchronously
  Future<Idea> createIdea(Idea idea) async {
    return await provider.createIdea(idea);
  }

  //a signature of crude getideasMoney to fech all ideas asynchronously
  Future<List<Idea>> getideasMoney() async {
    return await provider.getIdeasMoney();
  }

  // //a signature of crude getideas to fech ideas posted by a particular user asynchronously
  Future<List<Idea>> getideas(String userid) async {
    return await provider.getIdeas(userid);
  }

  //a signature of crude updateIdea to update an idea asynchronously
  Future<bool> updateIdea(Idea idea) async {
    return await provider.updateIdea(idea);
  }

 
  //a signature of crude deleteIdea to delete a particular idea 
  Future<bool> deleteIdea(String id) async {
    return await provider.deleteIdea(id);
  }
}
