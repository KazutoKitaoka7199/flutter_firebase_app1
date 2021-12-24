
import 'package:chat_firebase_practice/model/account.dart';
import 'package:chat_firebase_practice/model/post.dart';
import 'package:chat_firebase_practice/view/time_line/post_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TimeLinePage extends StatefulWidget {
  const TimeLinePage({Key? key}) : super(key: key);

  @override
  _TimeLinePageState createState() => _TimeLinePageState();
}

class _TimeLinePageState extends State<TimeLinePage> {
  Account myAccount = Account(
    id: '0719',
    name: 'kitaoka kazuto',
    selfIntroduction: 'プログラミング初心者北岡です。エンジニア希望です',
    userId: 'kitaoka0719',
    imagePath: 'https://twitter.com/googlejapan/photo',
      createdTime: Timestamp.now(),
      updatedTime: Timestamp.now()

  );

  List<Post>postList = [
    Post(
      id:'1',
      content:'はじめまして',
      postAccountId: '1',
      createdTime: DateTime.now(),
    ),
    Post(
      id: '2',
      content:'はじめまして2回目',
      postAccountId: '1',
      createdTime: DateTime.now()
    )

  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Dev22期　プライベートチャット',style:TextStyle(color:Colors.blue)),
        backgroundColor: Theme.of(context).canvasColor,
        elevation: 2,
      ),
      body:ListView.builder(
        itemCount: postList.length,
        itemBuilder: (context,index){
          return Container(
            decoration: BoxDecoration(
              border: index == 0 ? Border(
                top: BorderSide(color: Colors.grey, width: 0),
                bottom: BorderSide(color: Colors.grey, width: 0),
              ) :Border(bottom: BorderSide(color: Colors.grey, width: 0),)
            ),
            padding: EdgeInsets.symmetric(horizontal: 10,vertical:15),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 22,
                  foregroundImage: NetworkImage(myAccount.imagePath),
                ),
                Expanded(
                  child: Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Text(myAccount.name ,style: TextStyle(fontWeight: FontWeight.bold),),
                                Text('@${myAccount.userId}',style:TextStyle(color:Colors.grey),),
                              ],
                            ),
                            Text(DateFormat('M/d/yy').format(postList[index].createdTime!))
                          ],
                        ),
                        Text(postList[index].content)
                      ],
                    ),
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
