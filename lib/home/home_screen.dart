import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:social_app/comment/comment.dart';
import 'package:social_app/home/components/post_item.dart';
import 'package:social_app/home/components/post_part.dart';
import '../constants/colors.dart';
import 'home_cubit/bloc_event.dart';
import 'home_cubit/bolc_state.dart';
import 'home_cubit/post_bloc.dart';

class PostsList extends StatelessWidget {
  PostsList({Key? key}) : super(key: key);
  final RefreshController _refreshController =
  RefreshController(initialRefresh: false);

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
                        child: SmartRefresher(
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
                                    child: CircularProgressIndicator(
                                        strokeWidth: 1.5));
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
                          controller: _refreshController,
                          onRefresh: () async {
                            _refreshController.refreshCompleted();
                          },
                          onLoading: () async {
                            await Future.delayed(const Duration(seconds: 0));
                            context.read<PostBloc>().add(PostFetched());

                            _refreshController.loadComplete();
                          },
                          child: ListView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: state.posts.length,
                              itemBuilder: (context, index) {
                                return Padding(
                                  padding: const EdgeInsets.only(
                                      top: 8.0, bottom: 8.0),
                                  child: postItem(
                                      context,
                                      state.posts[index].postUserName,
                                      state.posts[index].dateOfPost,
                                      state.posts[index].postcontentStr,
                                      state.posts[index].postId,
                                      state.posts[index].totalcommentsCount),
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
