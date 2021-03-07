import 'package:ChatUI/libs.dart';
import 'dart:async';

class AdminIdeaRepository {
  AdminIdeaRepository() {
    AdminIdeaProvider.getInstance().then((prov) {
      this.provider = prov;
    });
  }

  AdminIdeaProvider provider;


  Future<List<Idea> > searchIdea(String title) async {
    return await this.provider.searchIdeas(title);
  }


  Future<List<Idea>>  loadSampleIdeas() async {
    return await this.provider.loadSampleIdeas();
  }

  Future<bool> deleteIdea(String userid) async {
    return await this.provider.deleteIdea(userid);
  }
}
