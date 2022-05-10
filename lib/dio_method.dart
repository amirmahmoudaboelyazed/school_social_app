import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import 'Helper/network_helper.dart';

class DioMethods {
  static Future<Response?> getPosts(
      {required int currentPage, required int pageSize}) async {
    log('$currentPage',name: "My CurrentPage");
    Dio dio = Dio();

    return await dio.get(
        "${NetowrkHelper.domain}RenderPosts?CurrentPage=0&PageSize=10&createdPostsCount=0",
        options: Options(headers: {
          "Cookie":
              "token=eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJuYW1lIjoi2YrYp9iz2YrZhiDZhdin2LLZhiDZhdit2YXZiNivIiwiQWN0aXZhdGlvbktleSI6Ijc1MDJjZWMxLTc2N2QtNDg3MS1iYWI3LTBlYmYzZTczZmU4YyIsIm5hbWVpZCI6IjE1MTIiLCJVc2VyVHlwZSI6IjIiLCJuYmYiOjE2NTE5OTYzMzksImV4cCI6MTY1MjAzOTUzOSwiaWF0IjoxNjUxOTk2MzM5fQ.CCPfqGaDVo4fk_mQWRIEkhvXZieiWVqJOmsNdhcp26Q",
          "Schoolid": 1,
          "Authorization":
              'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJuYW1lIjoi2YrYp9iz2YrZhiDZhdin2LLZhiDZhdit2YXZiNivIiwiQWN0aXZhdGlvbktleSI6Ijc1MDJjZWMxLTc2N2QtNDg3MS1iYWI3LTBlYmYzZTczZmU4YyIsIm5hbWVpZCI6IjE1MTIiLCJVc2VyVHlwZSI6IjIiLCJuYmYiOjE2NTEwNTE5NDUsImV4cCI6M TY1MTA5NTE0NSwiaWF0IjoxNjUxMDUxOTQ1fQ.Hqo2vzlFJkiV_PnBa5F_MJAlXYXhUuY1KavCiMD8gs',
        }));
  }

  static Future<Response?> getComment(
      {required int currentPage,
      required int pageSize,
      required int postId}) async {
    Dio dio = Dio();

    return await dio.get(
        "${NetowrkHelper.domain}RenderComments?CurrentPage=0&PageSize=5&CreatedCommentsCount=0&PostID=${postId}",
        options: Options(headers: {
          "Cookie":
              "token=eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJuYW1lIjoi2YrYp9iz2YrZhiDZhdin2LLZhiDZhdit2YXZiNivIiwiQWN0aXZhdGlvbktleSI6Ijc1MDJjZWMxLTc2N2QtNDg3MS1iYWI3LTBlYmYzZTczZmU4YyIsIm5hbWVpZCI6IjE1MTIiLCJVc2VyVHlwZSI6IjIiLCJuYmYiOjE2NTE5OTYzMzksImV4cCI6MTY1MjAzOTUzOSwiaWF0IjoxNjUxOTk2MzM5fQ.CCPfqGaDVo4fk_mQWRIEkhvXZieiWVqJOmsNdhcp26Q",
          "Schoolid": 1,
          "Authorization":
              'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJuYW1lIjoi2YrYp9iz2YrZhiDZhdin2LLZhiDZhdit2YXZiNivIiwiQWN0aXZhdGlvbktleSI6Ijc1MDJjZWMxLTc2N2QtNDg3MS1iYWI3LTBlYmYzZTczZmU4YyIsIm5hbWVpZCI6IjE1MTIiLCJVc2VyVHlwZSI6IjIiLCJuYmYiOjE2NTEwNTE5NDUsImV4cCI6M TY1MTA5NTE0NSwiaWF0IjoxNjUxMDUxOTQ1fQ.Hqo2vzlFJkiV_PnBa5F_MJAlXYXhUuY1KavCiMD8gs',
        }));
  }
}
