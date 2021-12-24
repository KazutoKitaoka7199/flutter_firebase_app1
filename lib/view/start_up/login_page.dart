import 'package:chat_firebase_practice/utils/authentication.dart';
import 'package:chat_firebase_practice/view/screen.dart';
import 'package:chat_firebase_practice/view/start_up/create_account_page.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          width: double.infinity,
          child: Column(
            children: [
              SizedBox(height:20),
              Text('Dev22期　プライベートSNS',style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold,color: Colors.lightBlue),),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 20.0),
                child: Container(
                  width: 350,
                  child: TextField(
                    controller: emailController,
                    decoration: InputDecoration(
                      hintText: 'メールアドレス',
                    ),
                  ),
                ),
              ),
              Container(
                width: 350,
                child: TextField(
                  controller: passController,
                  decoration: InputDecoration(
                    hintText: 'パスワード',
                  ),
                ),
              ),
              SizedBox(height: 10),
              RichText(
                  text: TextSpan(
                    style: TextStyle(color: Colors.grey),
                    children: [
                      TextSpan(text: 'アカウントを作成していない方は'),
                      TextSpan(text: 'こちら',
                      style: TextStyle(color:Colors.blue,fontWeight: FontWeight.bold),
                      recognizer: TapGestureRecognizer()..onTap = (){
                        Navigator.push(context,MaterialPageRoute(builder: (context) => CreateAccountPage()));

                      }
                      ),
                    ]
                  ),
              ),
              SizedBox(height: 30),
              ElevatedButton(
                  onPressed: () async{
                    var result = await Authentication.emailSignIn(email: emailController.text, pass: passController.text);
                    if(result == true){
                      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Screen()));
                    }
                  }, child: Text('emailでログイン'))
            ],
          ),
        ),
      ),
    );
  }
}
