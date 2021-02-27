import 'package:ChatUI/ideas/models/models.dart';
import 'package:ChatUI/ideas/screens/screens.dart';

import 'package:flutter/material.dart';

import 'list_idea.dart';

class CourseAppRoute {
  static Route generateRoute(RouteSettings settings) {
    if (settings.name == '/') {
      return MaterialPageRoute(builder: (context) => IdeaList());
    }

    if (settings.name == CreateIdea.Route) {
      CourseArgument args = settings.arguments;
      return MaterialPageRoute(
          builder: (context) => CreateIdea(
                args: args,
              ));
    }

    if (settings.name == IdeaDetail.routeName) {
      Idea idea = settings.arguments;
      return MaterialPageRoute(
          builder: (context) => IdeaDetail(
                idea: idea,
              ));
    }

    return MaterialPageRoute(builder: (context) => IdeaList());
  }
}

class CourseArgument {
  final Idea idea;
  final bool edit;
  CourseArgument({this.idea, this.edit});
}
