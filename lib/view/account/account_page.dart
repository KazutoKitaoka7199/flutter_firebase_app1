import 'package:chat_firebase_practice/model/account.dart';
import 'package:chat_firebase_practice/model/post.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AccountPage extends StatefulWidget {
  const AccountPage({Key? key}) : super(key: key);

  @override
  _AccountPageState createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
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
      // resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            height: MediaQuery.of(context).size.height,
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.only(right: 10,left: 10,top: 15),
                  color: Colors.lightBlue.withOpacity(0.5),
                  height: 200,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              CircleAvatar(
                                radius: 32,
                                foregroundImage: NetworkImage(myAccount.imagePath),
                              ),
                              SizedBox(width: 10),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(myAccount.name,style:TextStyle(fontSize: 20,fontWeight:FontWeight.bold),),
                                  Text('@${myAccount.userId}',style:TextStyle(color:Colors.grey),),
                                ],
                              ),
                            ],
                          ),
                          OutlinedButton(
                              onPressed: (){

                              },
                              child: Text('編集')
                          )
                        ],
                      ),
                      SizedBox(height: 10),
                      Text(myAccount.selfIntroduction)
                    ],
                  ),
                ),
                Container(
                  alignment: Alignment.center,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    border: Border(bottom: BorderSide(
                      color: Colors.lightBlue.withOpacity(0.5),width: 3
                    ))
                  ),
                  child: Text('投稿',style: TextStyle(color: Colors.blue,fontWeight: FontWeight.bold),),
                ),
                Expanded(child: ListView.builder(
                  physics: NeverScrollableScrollPhysics(),
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
                    }),)
              ],
            ),
          ),
        ),
      ),
    );
  }
}
