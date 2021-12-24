import 'dart:io';

import 'package:chat_firebase_practice/model/account.dart';
import 'package:chat_firebase_practice/utils/authentication.dart';
import 'package:chat_firebase_practice/utils/firestore/users.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class CreateAccountPage extends StatefulWidget {
  const CreateAccountPage({Key? key}) : super(key: key);

  @override
  _CreateAccountPageState createState() => _CreateAccountPageState();
}

class _CreateAccountPageState extends State<CreateAccountPage>{
  TextEditingController nameController = TextEditingController();
  TextEditingController userIDController = TextEditingController();
  TextEditingController selfIntroductionController = TextEditingController();
  TextEditingController passController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  File? image;
  ImagePicker picker = ImagePicker();

  Future<void>getImageFromGallery() async{
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if(pickedFile != null){
      setState(() {
        image = File(pickedFile.path);
      });
    }
  }

  Future<String>uploadImage(String uid)async{
    final FirebaseStorage storageInstance = FirebaseStorage.instance;
    final Reference ref = storageInstance.ref();
    await ref.child(uid).putFile(image!);
    String downloadUrl = await storageInstance.ref(uid).getDownloadURL();
    print('image_path: $downloadUrl');
    return downloadUrl;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.blue),
        title:Text('新規登録',style: TextStyle(color: Colors.blue,fontWeight: FontWeight.bold),),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Container(
          width: double.infinity,
          child: Column(
            children: [
              SizedBox(height: 30),
              GestureDetector(
                onTap: () {
                  getImageFromGallery();
                },
                child: CircleAvatar(
                  foregroundImage: image == null ? null:FileImage(image!),
                  radius: 30,
                  child: Icon(Icons.add),
                ),
              ),
              Container(
                width: 300,
                child: TextField(
                  controller: nameController,
                  decoration: InputDecoration(
                    hintText: '名前'
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10.0),
                child: Container(
                  width: 300,
                  child: TextField(
                    controller: userIDController,
                    decoration: InputDecoration(
                        hintText: 'ユーザーID'
                    ),
                  ),
                ),
              ),
              Container(
                width: 300,
                child: TextField(
                  controller: passController,
                  decoration: InputDecoration(
                      hintText: 'パスワード'
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10.0),
                child: Container(
                  width: 300,
                  child: TextField(
                    controller: emailController,
                    decoration: InputDecoration(
                        hintText: 'メールアドレス'
                    ),
                  ),
                ),
              ),
              Container(
                width: 300,
                child: TextField(
                  controller: selfIntroductionController,
                  decoration: InputDecoration(
                      hintText: '自己紹介'
                  ),
                ),
              ),
              SizedBox(height: 30),
              ElevatedButton(onPressed: () async{
                if(nameController.text.isNotEmpty
                    && userIDController.text.isNotEmpty
                    && passController.text.isNotEmpty
                    && emailController.text.isNotEmpty
                    && selfIntroductionController.text.isNotEmpty){
                  var result = await Authentication.signUp(email: emailController.text, pass: passController.text);
                  Navigator.pop(context);
                  if(result == UserCredential){
                    String imagePath = await uploadImage(result.user!.uid);
                    Account newAccount = Account(
                      id: result.user!.uid,
                      name: nameController.text,
                      userId: userIDController.text,
                      selfIntroduction: selfIntroductionController.text,
                      imagePath: imagePath,
                    );
                    var _result = await UserFireStore.setUser(newAccount);
                    if(_result ==true){
                      Navigator.pop(context);
                    }
                  }
                }
              }, child: Text('アカウントを作成'))
            ],
          ),
        ),
      )
    );
  }
}
