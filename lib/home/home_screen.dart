import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import 'package:social_app/home/components/post_item.dart';
import 'package:social_app/home/components/post_part.dart';
import '../constants/colors.dart';
import 'home_cubit/bloc_event.dart';
import 'home_cubit/bolc_state.dart';
import 'home_cubit/post_bloc.dart';

class PostsList extends StatefulWidget {
  PostsList({Key? key}) : super(key: key);

  @override
  State<PostsList> createState() => _PostsListState();
}

class _PostsListState extends State<PostsList> {
  final ItemScrollController _scrollController = ItemScrollController();

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Scaffold(
        appBar: AppBar(
          title: const Center(
              child: Text(
            "Social Media",
            style:
                TextStyle(color: MyColors.myTeal, fontStyle: FontStyle.italic),
          )),
          backgroundColor: Colors.white,
          actions: const [
            Padding(
              padding: EdgeInsets.only(right: 10),
              child: Icon(
                Icons.account_circle,
                color: MyColors.myBlack,
                size: 30,
              ),
            ),
          ],
        ),
        body: BlocProvider(
          create: (context) => PostBloc(context)..add(PostFetched()),
          child: BlocBuilder<PostBloc, PostState>(
            builder: (context, state) {
              switch (state.status) {
                case PostStatus.failure:
                  return const Center(child: Text('failed to fetch posts'));
                case PostStatus.success:
                  if (state.posts.isEmpty) {
                    return const Center(child: Text('no posts'));
                  }
                  return Column(
                    children: [
                      postPart(),
                      Expanded(
                        child: NotificationListener<ScrollEndNotification>(
                          onNotification: (scrollEnd) {
                            final metrics = scrollEnd.metrics;
                            if (metrics.atEdge) {
                              bool isTop = metrics.pixels == 0;
                              if (isTop) {
                              } else {
                                if (state.hasReachedMax == false) {
                                  context.read<PostBloc>().add(PostFetched());
                                }
                              }
                            }
                            return true;
                          },
                          child: ScrollablePositionedList.builder(
                              initialScrollIndex: state.posts.length - 10,
                              itemScrollController: _scrollController,
                              physics: const BouncingScrollPhysics(),
                              itemCount: state.hasReachedMax
                                  ? state.posts.length
                                  : state.posts.length + 1,
                              itemBuilder: (context, index) {
                                return index >= state.posts.length
                                    ? const Center(
                                        child: SizedBox(
                                          height: 24,
                                          width: 24,
                                          child: CircularProgressIndicator(
                                              strokeWidth: 1.5),
                                        ),
                                      )
                                    : Padding(
                                        padding: const EdgeInsets.only(
                                            top: 8.0, bottom: 8.0),
                                        child: postItem(
                                            context,
                                            state.posts[index].postUserName,
                                            state.posts[index].dateOfPost,
                                            state.posts[index].postcontentStr,
                                            state.posts[index].postId,
                                            state.posts[index]
                                                .totalcommentsCount),
                                      );
                              }),
                        ),
                      ),
                    ],
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
