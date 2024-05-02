import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:taskassignment/project/my_profile/userdetails.dart';

class FireBaseServices {
  final CollectionReference userProfile =
      FirebaseFirestore.instance.collection("users");
  // DocumentReference doc_ref=FirebaseFirestore.instance.collection("users");

  Future addUserInfo(Map<String, dynamic> userInfo, String id) async {
    return userProfile.doc(id).set(userInfo);
  }

  Future<Stream<QuerySnapshot>> getUserDetail() async {
    return userProfile.snapshots();
  }

  Future<void> addUser(String email, String number, String name) {
    return userProfile.add({'email': email, 'number': number, 'name': name});
  }

  Future get_Data() async {
    var collection = FirebaseFirestore.instance.collection('users');
    var querySnapshot = await collection.get();
    for (var queryDocumentSnapshot in querySnapshot.docs) {
      Map<String, dynamic> data = queryDocumentSnapshot.data();
      var name = data['name'];
      var phone = data['contactNumber'];
      print(name);
      print(phone);
    }
  }

  Future<List<UsrDetails>> getData() async {
    var collection = FirebaseFirestore.instance.collection('users');
    var querySnapshot = await collection.get();

    List<UsrDetails> userDataList = [];

    for (var queryDocumentSnapshot in querySnapshot.docs) {
      Map<String, dynamic> data = queryDocumentSnapshot.data();
      UsrDetails userData = UsrDetails.fromSnapshot(data);
      userDataList.add(userData);
    }

    return userDataList;
  }

  Future<List<UsrDetails>> getDataForId(String userId) async {
    var collection = FirebaseFirestore.instance.collection('users');
    var querySnapshot = await collection.where('id', isEqualTo: userId).get();

    List<UsrDetails> userDataList = [];

    for (var queryDocumentSnapshot in querySnapshot.docs) {
      Map<String, dynamic> data = queryDocumentSnapshot.data();
      UsrDetails userData = UsrDetails.fromSnapshot(data);
      userDataList.add(userData);
    }

    return userDataList;
  }
}
