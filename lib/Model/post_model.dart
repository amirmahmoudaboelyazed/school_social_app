// To parse this JSON data, do
//
//     final filterChipData = filterChipDataFromJson(jsonString);

import 'dart:convert';

import 'package:equatable/equatable.dart';

 List<PostModel> postModelChipDataFromJson(String str) => List<PostModel>.from(json.decode(str).map((x) => PostModel.fromJson(x)));

String postModelChipDataToJson(List<PostModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class PostModel extends Equatable{
  PostModel({
    this.postId,
    this.userPostProfileImageUrl,
    this.postcontentStr,
    this.userId,
    this.totalcommentsCount,
    this.totalLikesCount,
    this.currentUserLikePost,
    this.postUserName,
    this.postHaveFiles,
    this.dateOfPost,
    this.currentUserPost,
    this.currentUserFollowPost,
    this.commentable,
    this.listOfCommentsVm,
    this.postAttachmentImagesVideos,
    this.postAttachmentsFilesUrl,
    this.postFollowers,
  });

  int? postId;
  String? userPostProfileImageUrl;
  String? postcontentStr;
  int? userId;
  int? totalcommentsCount;
  int ?totalLikesCount;
  bool? currentUserLikePost;
  String? postUserName;
  bool? postHaveFiles;
  DateTime? dateOfPost;
  bool? currentUserPost;
  bool? currentUserFollowPost;
  bool? commentable;
  List<dynamic>? listOfCommentsVm;
  List<PostAttachmentImagesVideo>? postAttachmentImagesVideos;
  List<dynamic>? postAttachmentsFilesUrl;
  List<int>? postFollowers;

  factory PostModel.fromJson(Map<String, dynamic> json) => PostModel(
    postId: json["postID"],
    userPostProfileImageUrl: json["userPostProfileImageUrl"],
    postcontentStr: json["postcontentStr"],
    userId: json["userID"],
    totalcommentsCount: json["totalcommentsCount"],
    totalLikesCount: json["totalLikesCount"],
    currentUserLikePost: json["currentUserLikePost"],
    postUserName: json["postUserName"],
    postHaveFiles: json["postHaveFiles"],
    dateOfPost: json["dateOfPost"] == null ? null : DateTime.parse(json["dateOfPost"]),
    currentUserPost: json["currentUserPost"],
    currentUserFollowPost: json["currentUserFollowPost"],
    commentable: json["commentable"],
    listOfCommentsVm: json["listOfCommentsVM"] == null ? null : List<dynamic>.from(json["listOfCommentsVM"].map((x) => x)),
    postAttachmentImagesVideos: json["postAttachmentImages_Videos"] == null ? null : List<PostAttachmentImagesVideo>.from(json["postAttachmentImages_Videos"].map((x) => PostAttachmentImagesVideo.fromJson(x))),
    postAttachmentsFilesUrl: json["postAttachmentsFilesUrl"] == null ? null : List<dynamic>.from(json["postAttachmentsFilesUrl"].map((x) => x)),
    postFollowers: json["postFollowers"] == null ? null : List<int>.from(json["postFollowers"].map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "postID": postId,
    "userPostProfileImageUrl": userPostProfileImageUrl,
    "postcontentStr": postcontentStr,
    "userID": userId,
    "totalcommentsCount": totalcommentsCount,
    "totalLikesCount": totalLikesCount,
    "currentUserLikePost": currentUserLikePost,
    "postUserName": postUserName == null ? null : [postUserName],
    "postHaveFiles": postHaveFiles,
    "dateOfPost": dateOfPost == null ? null : dateOfPost!.toIso8601String(),
    "currentUserPost": currentUserPost,
    "currentUserFollowPost": currentUserFollowPost,
    "commentable": commentable,
    "listOfCommentsVM": listOfCommentsVm == null ? null : List<dynamic>.from(listOfCommentsVm!.map((x) => x)),
    "postAttachmentImages_Videos": postAttachmentImagesVideos == null ? null : List<dynamic>.from(postAttachmentImagesVideos!.map((x) => x.toJson())),
    "postAttachmentsFilesUrl": postAttachmentsFilesUrl == null ? null : List<dynamic>.from(postAttachmentsFilesUrl!.map((x) => x)),
    "postFollowers": postFollowers == null ? null : List<dynamic>.from(postFollowers!.map((x) => x)),
  };

  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}

class PostAttachmentImagesVideo {
  PostAttachmentImagesVideo({
    this.extention,
    this.url,
  });

  String? extention;
  String? url;

  factory PostAttachmentImagesVideo.fromJson(Map<String, dynamic> json) => PostAttachmentImagesVideo(
    extention: json["extention"],
    url: json["url"],
  );

  Map<String, dynamic> toJson() => {
    "extention": extention,
    "url": url,
  };
}



