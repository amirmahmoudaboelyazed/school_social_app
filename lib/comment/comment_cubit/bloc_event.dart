


import 'package:equatable/equatable.dart';

abstract class CommentEvent extends Equatable {
  @override
  List<Object> get props => [];

}

class CommentFetched extends CommentEvent {
  int ? id;
  CommentFetched(this.id);


}