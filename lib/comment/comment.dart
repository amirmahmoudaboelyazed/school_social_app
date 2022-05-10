import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:sizer/sizer.dart';

import 'comment_cubit/bloc_event.dart';
import 'comment_cubit/bolc_state.dart';
import 'comment_cubit/comment_bloc.dart';

class CommentList extends StatelessWidget {
  CommentList(this.postId, {Key? key}) : super(key: key);
  int? postId;
  final RefreshController _refreshCommentsController =
      RefreshController(initialRefresh: false);

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
                  return SmartRefresher(
                    physics: const BouncingScrollPhysics(),
                    enablePullDown: true,
                    enablePullUp: true,
                    header: const WaterDropHeader(),
                    footer: CustomFooter(
                      builder: (context, mode) {
                        Widget body;
                        if (mode == LoadStatus.idle) {
                          body = state.hasReachedMax == true
                              ? Container()
                              : const Center(
                                  child: CircularProgressIndicator(
                                      strokeWidth: 1.5));
                        } else if (mode == LoadStatus.loading) {
                          body = const Center(
                              child:
                                  CircularProgressIndicator(strokeWidth: 1.5));
                        } else if (mode == LoadStatus.failed) {
                          body = const Text("Load Failed!Click retry!");
                        } else {
                          body = const Text("No more Data");
                        }
                        return SizedBox(
                          height: 55.0,
                          child: Center(child: body),
                        );
                      },
                    ),
                    controller: _refreshCommentsController,
                    onRefresh: () async {
                      _refreshCommentsController.refreshCompleted();
                    },
                    onLoading: () async {
                      await Future.delayed(const Duration(seconds: 0));
                      //context.read<CommentBloc>().add(CommentFetched(postId));

                      _refreshCommentsController.loadComplete();
                    },
                    child: ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: state.comment.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding:
                                const EdgeInsets.only(top: 8.0, bottom: 8.0),
                            child: Directionality(
                              textDirection: TextDirection.rtl,
                              child: Card(
                                elevation: 10,
                                child: SizedBox(
                                  height: 15.h,
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
                                              MainAxisAlignment.spaceAround,
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
