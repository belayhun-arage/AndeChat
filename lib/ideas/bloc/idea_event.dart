import 'package:ChatUI/ideas/models/models.dart';

import 'package:equatable/equatable.dart';

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

class IdeaCreate extends IdeaEvent {
  final Idea idea;

  const IdeaCreate(this.idea);
  @override
  List<Object> get props => [idea];

  @override
  String toString() => 'idea created {idea: $idea} ';
}

class IdeaUpdate extends IdeaEvent {
  final Idea idea;

  const IdeaUpdate(this.idea);

  @override
  List<Object> get props => [idea];

  @override
  String toString() => 'Course Updated {course: $idea}';
}

class IdeaDelete extends IdeaEvent {
  final Idea idea;

  const IdeaDelete(this.idea);

  @override
  List<Object> get props => [idea];

  @override
  toString() => 'Course Deleted {course: $idea}';
}
