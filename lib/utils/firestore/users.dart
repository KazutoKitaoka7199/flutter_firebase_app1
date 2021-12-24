import 'package:chat_firebase_practice/model/account.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UserFireStore {
  static final _firestoreInstance = FirebaseFirestore.instance;
  static final CollectionReference users = _firestoreInstance.collection('users');

  static Future<dynamic> setUser(Account newAccount) async{
    try{
      await users.doc(newAccount.id).set({
        'name':newAccount.name,
        'user_id':newAccount.userId,
        'self_introduction':newAccount.selfIntroduction,
        'created_time':Timestamp.now(),
        'update_time':Timestamp.now(),
      });
      print('新規ユーザー作成完了') ;
      return true;
    } on FirebaseException catch(e) {
        print('新規ユーザー作成エラー:$e');
        return false;

    }
  }
}