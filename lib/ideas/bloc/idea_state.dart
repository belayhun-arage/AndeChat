import 'package:ChatUI/ideas/models/models.dart';

import 'package:equatable/equatable.dart';

class IdeaState extends Equatable {
  const IdeaState();

  @override
  List<Object> get props => [];
}

class IdeaLoading extends IdeaState {}

class IdeaLoadSuccess extends IdeaState {
  final List<Idea> ideass;

  IdeaLoadSuccess([this.ideass = const []]);

  @override
  List<Object> get props => [ideass];
}

class IdeaOperationFailure extends IdeaState {}
