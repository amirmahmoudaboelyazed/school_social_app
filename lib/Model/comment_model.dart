// To parse this JSON data, do
//
//     final commentModel = commentModelFromJson(jsonString);

import 'dart:convert';

List<CommentModel> commentModelFromJson(String str) => List<CommentModel>.from(json.decode(str).map((x) => CommentModel.fromJson(x)));

String commentModelToJson(List<CommentModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class CommentModel {
  CommentModel({
    this.commentcontentStr,
    this.commentId,
    this.parentcommentId,
    this.postId,
    this.commentLikesCount,
    this.commentUserImageProfileUrl,
    this.commentAttachment,
    this.userId,
    this.commentUserName,
    this.commentDate,
    this.totalReplaycommentsCount,
    this.currentUsercomment,
    this.currentUserLikeThisComment,
    this.replayenabled,
  });

  dynamic commentcontentStr;
  int? commentId;
  dynamic parentcommentId;
  int ?postId;
  int ?commentLikesCount;
  String ?commentUserImageProfileUrl;
  String ?commentAttachment;
  int ?userId;
  String ?commentUserName;
  DateTime ?commentDate;
  int ?totalReplaycommentsCount;
  bool ?currentUsercomment;
  bool ?currentUserLikeThisComment;
  bool ?replayenabled;

  factory CommentModel.fromJson(Map<String, dynamic> json) => CommentModel(
    commentcontentStr: json["commentcontentStr"],
    commentId: json["commentID"],
    parentcommentId: json["parentcommentID"],
    postId: json["postID"],
    commentLikesCount: json["commentLikesCount"],
    commentUserImageProfileUrl: json["commentUserImageProfileUrl"],
    commentAttachment: json["commentAttachment"],
    userId: json["userID"],
    commentUserName: json["commentUserName"],
    commentDate: DateTime.parse(json["commentDate"]),
    totalReplaycommentsCount: json["totalReplaycommentsCount"],
    currentUsercomment: json["currentUsercomment"],
    currentUserLikeThisComment: json["currentUserLikeThisComment"],
    replayenabled: json["replayenabled"],
  );

  Map<String, dynamic> toJson() => {
    "commentcontentStr": commentcontentStr,
    "commentID": commentId,
    "parentcommentID": parentcommentId,
    "postID": postId,
    "commentLikesCount": commentLikesCount,
    "commentUserImageProfileUrl": commentUserImageProfileUrl,
    "commentAttachment": commentAttachment,
    "userID": userId,
    "commentUserName": commentUserName,
    "commentDate": commentDate!.toIso8601String(),
    "totalReplaycommentsCount": totalReplaycommentsCount,
    "currentUsercomment": currentUsercomment,
    "currentUserLikeThisComment": currentUserLikeThisComment,
    "replayenabled": replayenabled,
  };
}
