import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';

import 'comment_cubit/bloc_event.dart';
import 'comment_cubit/bolc_state.dart';
import 'comment_cubit/comment_bloc.dart';

class CommentList extends StatelessWidget {
  CommentList(this.postId, {Key? key}) : super(key: key);
  int? postId;

  final ItemScrollController _scrollController = ItemScrollController();

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Comments"),
          backgroundColor: Colors.grey,
        ),
        body: BlocProvider(
          create: (context) =>
              CommentBloc(context)..add(CommentFetched(postId)),
          child: BlocBuilder<CommentBloc, CommentState>(
            builder: (context, state) {
              switch (state.status) {
                case CommentStatus.failure:
                  return const Center(child: Text('failed to fetch Comments'));
                case CommentStatus.success:
                  if (state.comment.isEmpty) {
                    return const Center(child: Text('no Comments'));
                  }
                  return NotificationListener<ScrollEndNotification>(
                    onNotification: (scrollEnd) {
                      final metrics = scrollEnd.metrics;
                      if (metrics.atEdge) {
                        bool isTop = metrics.pixels == 0;
                        if (isTop) {
                        } else {
                          context
                              .read<CommentBloc>()
                              .add(CommentFetched(postId));
                        }
                      }
                      return true;
                    },
                    child: ScrollablePositionedList.builder(
                        initialScrollIndex: state.comment.length <= 5
                            ? 0
                            : state.comment.length - 5,
                        itemScrollController: _scrollController,
                        physics: const BouncingScrollPhysics(),
                        itemCount: state.hasReachedMax
                            ? state.comment.length
                            : state.comment.length + 1,
                        itemBuilder: (context, index) {
                          return index >= state.comment.length
                              ? SizedBox(
                                  height: 30,
                                  child: state.comment.length % 5 == 1
                                      ? Container()
                                      : const Center(
                                          child: SizedBox(
                                            height: 24,
                                            width: 24,
                                            child: CircularProgressIndicator(
                                                strokeWidth: 1.5),
                                          ),
                                        ),
                                )
                              : Padding(
                                  padding: const EdgeInsets.only(
                                      top: 8.0, bottom: 8.0),
                                  child: Directionality(
                                    textDirection: TextDirection.rtl,
                                    child: Card(
                                      elevation: 10,
                                      child: SizedBox(
                                        height: 18.h,
                                        child: Row(
                                          children: [
                                            const SizedBox(
                                              width: 15,
                                            ),
                                            Container(
                                              height: 8.h,
                                              width: 7.h,
                                              decoration: const BoxDecoration(
                                                  shape: BoxShape.circle,
                                                  color: Colors.green),
                                              child: const Padding(
                                                padding: EdgeInsets.all(20.0),
                                                child: Icon(Icons.comment),
                                              ),
                                            ),
                                            const SizedBox(
                                              width: 15,
                                            ),
                                            SizedBox(
                                              width: 300,
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceAround,
                                                children: [
                                                  const Spacer(),
                                                  Text(
                                                      "${state.comment[index].commentcontentStr}"),
                                                  const SizedBox(
                                                    height: 8,
                                                  ),
                                                  Text(
                                                      "${state.comment[index].commentDate}"),
                                                  const SizedBox(
                                                    height: 8,
                                                  ),
                                                  const Spacer(),
                                                ],
                                              ),
                                            ),
                                            const SizedBox(
                                              width: 15,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                        }),
                  );

                default:
                  return const Center(child: CircularProgressIndicator());
              }
            },
          ),
        ),
      ),
    );
  }
}
