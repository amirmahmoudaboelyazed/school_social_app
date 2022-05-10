import 'package:equatable/equatable.dart';

import '../../../Model/post_model.dart';
import '../../Model/comment_model.dart';


enum CommentStatus { initial, success, failure }

class CommentState extends Equatable {
  const CommentState({
    this.status = CommentStatus.initial,
    this.comment = const <CommentModel>[],
    this.hasReachedMax = false,
  });

  final CommentStatus status;
  final List<CommentModel> comment;
  final bool hasReachedMax;

  CommentState copyWith({
    CommentStatus? status,
    List<CommentModel>? comment,
    bool? hasReachedMax,
  }) {
    return CommentState(
      status: status ?? this.status,
      comment: comment ?? this.comment,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
    );
  }

  @override
  String toString() {
    return '''CommentState { status: $status, hasReachedMax: $hasReachedMax, Comment: ${comment.length} }''';
  }

  @override
  List<Object> get props => [status, comment, hasReachedMax];
}