
import 'dart:async';
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:stream_transform/stream_transform.dart';

import '../../../Model/post_model.dart';
import '../../../dio_method.dart';
import 'bloc_event.dart';
import 'bolc_state.dart';


const throttleDuration = Duration(milliseconds: 100);

EventTransformer<E> throttleDroppable<E>(Duration duration) {
  return (events, mapper) {
    return droppable<E>().call(events.throttle(duration), mapper);
  };
}

class PostBloc extends Bloc<PostEvent, PostState> {
  PostBloc(BuildContext context) : super(const PostState()) {
    on<PostFetched>(
      _onPostFetched,
      transformer: throttleDroppable(throttleDuration),
    );
  }

  int currentPage =0;

  Future<void> _onPostFetched(
      PostFetched event,
      Emitter<PostState> emit,
      ) async {
    if (state.hasReachedMax) return;
    try {
      if (state.status == PostStatus.initial) {
        final posts = await _fetchPosts(currentPage: 0,pageSize: 10);
        return emit(state.copyWith(
          status: PostStatus.success,
          posts: posts,
          hasReachedMax: false,
        ));
      }
      currentPage = currentPage+1;
      final posts = await _fetchPosts(currentPage: currentPage,pageSize: 10);
      posts.isEmpty
          ? emit(state.copyWith(hasReachedMax: true))
          : emit(
        state.copyWith(
          status: PostStatus.success,
          posts: List.of(state.posts)..addAll(posts),
          hasReachedMax: false,
        ),
      );
    } catch (_) {
      emit(state.copyWith(status: PostStatus.failure));
    }
  }


  Future<List<PostModel>> _fetchPosts({int? currentPage,int? pageSize}) async {
    List<PostModel> posts =[];
    Response? response = await DioMethods.getPosts(currentPage: currentPage!, pageSize: pageSize!);
    if (response!.statusCode == 200) {
      posts=  postModelChipDataFromJson(jsonEncode(response.data)) ;
      print(postModelChipDataFromJson(jsonEncode(response.data)).length);

    return   posts;
    }
    throw Exception('error fetching posts');
  }
}
