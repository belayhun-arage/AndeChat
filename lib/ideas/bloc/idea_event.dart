import 'package:ChatUI/ideas/models/models.dart';

import 'package:equatable/equatable.dart';

//Equatable IdeaEvent helps to compare IdeaEvents
abstract class IdeaEvent extends Equatable {
  const IdeaEvent();
}

class IdeaLoadMoney extends IdeaEvent {
  const IdeaLoadMoney();

  @override
  @override
  List<Object> get props => [];
}

class IdeaLoad extends IdeaEvent {
  const IdeaLoad();

  @override
  @override
  List<Object> get props => [];
}

//class IdeaCreate creats a new idea 
class IdeaCreate extends IdeaEvent {
  final Idea idea;

  const IdeaCreate(this.idea);
  @override
  List<Object> get props => [idea];

  @override
  String toString() => 'idea created {idea: $idea} ';
}

//class IdeaUpdate update the content of an idea from the list of ideas
class IdeaUpdate extends IdeaEvent {
  final Idea idea;

  const IdeaUpdate(this.idea);

  @override
  List<Object> get props => [idea];

  @override
  String toString() => 'Idea Updated {idea: $idea}';
}

//class ideaevent delete ideas that are no more important anymore
class IdeaDelete extends IdeaEvent {
  final Idea idea;

  const IdeaDelete(this.idea);

  @override
  List<Object> get props => [idea];

  @override
  toString() => 'Idea Deleted {idea: $idea}';
}
