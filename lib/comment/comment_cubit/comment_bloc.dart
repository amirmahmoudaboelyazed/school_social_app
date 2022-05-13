import 'dart:async';
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:stream_transform/stream_transform.dart';

import '../../../dio_method.dart';
import '../../Model/comment_model.dart';
import 'bloc_event.dart';
import 'bolc_state.dart';

const throttleDuration = Duration(milliseconds: 100);

EventTransformer<E> throttleDroppable<E>(Duration duration) {
  return (events, mapper) {
    return droppable<E>().call(events.throttle(duration), mapper);
  };
}

class CommentBloc extends Bloc<CommentEvent, CommentState> {
  CommentBloc(BuildContext context) : super(const CommentState()) {
    on<CommentFetched>(
      _onCommentFetched,
      transformer: throttleDroppable(throttleDuration),
    );
  }

  int currentPage = 0;
  int currentIndex = 0;

  Future<void> _onCommentFetched(
    CommentFetched event,
    Emitter<CommentState> emit,
  ) async {
    if (state.hasReachedMax) return;
    try {
      if (state.status == CommentStatus.initial) {
        final comment =
            await _fetchComment(currentPage: 0, pageSize: 5, id: event.id);
        return emit(state.copyWith(
          status: CommentStatus.success,
          comment: comment,
          hasReachedMax: false,
        ));
      }
      currentPage = currentPage + 1;
      currentIndex = currentIndex + 5;
      final comment = await _fetchComment(
          currentPage: currentPage, pageSize: 5, id: event.id);
      comment.isEmpty
          ? emit(state.copyWith(hasReachedMax: true))
          : emit(
              state.copyWith(
                status: CommentStatus.success,
                comment: List.of(state.comment)..addAll(comment),
                hasReachedMax: false,
              ),
            );
    } catch (_) {
      emit(state.copyWith(status: CommentStatus.failure));
    }
  }

  Future<List<CommentModel>> _fetchComment(
      {int? currentPage, int? pageSize, int? id}) async {
    List<CommentModel> comment = [];
    Response? response = await DioMethods.getComment(
        currentPage: currentPage!, pageSize: pageSize!, postId: id!);
    if (response!.statusCode == 200) {
      comment = commentModelFromJson(jsonEncode(response.data));

      return comment;
    }
    throw Exception('error fetching Comments');
  }
}
