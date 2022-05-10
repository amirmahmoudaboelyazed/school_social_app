import 'package:flutter/material.dart';
import 'package:social_app/home/components/my_space.dart';

import '../../comment/comment.dart';

Widget postItem(context,name,date,post,id,commentsNumbers){
  return  Directionality(
    textDirection: TextDirection.rtl,
    child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Card(
        elevation: 5,
        child: Column(
          children: [
            Row(children: [
              const CircleAvatar(
                radius: 30,
                backgroundImage: AssetImage("assets/person.png"),
              ),
              Column(
                children:  [
                   Text(name==null?"":name,style:  const TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
                   Text(date.toString()==null?"":date.toString())
                ],
              ),
              const Expanded(
                  child: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Align(
                        alignment: Alignment.centerLeft,
                        child: Icon(Icons.more_horiz)),
                  ))

            ],),
            const SizedBox(height: 18,),
             Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Align( alignment: Alignment.centerRight,child: Text(post==null?"null":post,style: const TextStyle(fontSize: 22),)),
            ),
            const SizedBox(height: 18,),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Row(children: [
                Row(children: [
                  Image.asset("assets/like.png"),
                  const Text(" 0 ",style:  TextStyle(fontSize: 18),)
                ],),
                const Spacer(),
                Row(children: [
                   Text(commentsNumbers.toString(),style:  const TextStyle(fontSize: 18)),
                   const Text("Comments",style:  TextStyle(fontSize: 18),)
                ],)
              ],),
            ),
            const SizedBox(height: 18,),
            Container(
              color: Colors.grey,
              height: 1,width: MediaQuery.of(context).size.width-50,),
            const SizedBox(height: 10,),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Row(children: [
                Row(children: [
                  Image.asset("assets/like1.png"),
                  const Text(" Like ",style:  TextStyle(fontSize: 18),)
                ],),
                const Spacer(),
                Row(children: [
                  Image.asset("assets/chat.png"),
                   Text(commentsNumbers.toString(),style:  TextStyle(fontSize: 18),),
                  const Text(" Comments ",style:  TextStyle(fontSize: 18),)
                ],),
                const Spacer(),
                Row(children: [
                  Image.asset("assets/heart.png"),
                  const Text(" 0 ",style:  TextStyle(fontSize: 18),),
                  const Text(" Saved ",style:  TextStyle(fontSize: 18),)
                ],),
              ],),
            ),
            const SizedBox(height: 10,),
            Container(
              color: Colors.grey,
              height: 1,width: MediaQuery.of(context).size.width-50,),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Align(alignment:Alignment.centerRight,child: TextButton(onPressed: (){

                Navigator.push(
                          context,
                        MaterialPageRoute(builder: (context) =>
                      CommentList(id)));




              }, child: const Text("عرض مزيد من التعليقات"))),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Row(children: [
                const CircleAvatar(
                  radius: 25,
                  backgroundImage:  AssetImage("assets/photo.jpg"),
                ),
                const SizedBox(width: 10,),
                Expanded(
                  child: TextFormField(
                    decoration: InputDecoration(
                      hintText: "Write Comment...",
                      suffixIcon: const Icon(Icons.attachment),
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(22.0),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 10,),
                const Icon(Icons.send_rounded,color: Colors.lightGreen,)
              ],),
            ),
            mySpace(height: 30.0)
          ],
        ),
      ),
    ),
  );

}


