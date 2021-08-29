import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dinner_planner/models/food.dart';
import 'package:dinner_planner/models/order.dart';
import 'package:dinner_planner/models/user.dart';

class DatabaseService {
  DatabaseService({this.uid, this.foodId});
  final String? uid;
  final String? foodId;

  final CollectionReference menuCollectionReference =
      FirebaseFirestore.instance.collection("Menu");

  final CollectionReference userCollectionReference =
      FirebaseFirestore.instance.collection("User");

  final DocumentReference menuDocumentReference =
      FirebaseFirestore.instance.collection("Menu").doc();

  Future updateUserData(ExtendedUserData data) async {
    return await userCollectionReference.doc(uid).set({
      "name": data.name,
      "phone": data.phone,
      "email": data.email,
      "userPic": data.userPic,
      "address": {
        "landmark": data.landmark,
        "adLine": data.adLine,
        "city": data.city,
        "pin": data.pin,
        "state": data.state,
      },
      "order": <OrderData>[],
    });
  }

  UserData _userDataFromSnapshot(DocumentSnapshot snapshot) {
    return UserData(
        uid: uid!, name: snapshot["name"], userPic: snapshot["userPic"]);
  }

  List<Food> _foodListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((dynamic e) {
      return Food(
          name: e.data()["name"],
          price: e.data()["price"],
          veg: e.data()["veg"],
          type: e.data()["type"],
          foodId: e.data()["uid"]);
    }).toList();
  }

  FoodID _foodIDFromSnapshot(DocumentSnapshot snapshot) {
    return FoodID(uid: foodId!);
  }

  Stream<FoodID> get foodID {
    return menuCollectionReference
        .doc(foodId)
        .snapshots()
        .map((DocumentSnapshot snapshot) => _foodIDFromSnapshot(snapshot));
  }

  Stream<List<Food>> get food {
    return menuCollectionReference
        .snapshots()
        .map((QuerySnapshot snapshot) => _foodListFromSnapshot(snapshot));
  }

  Stream<UserData> get userData {
    return userCollectionReference
        .doc(uid)
        .snapshots()
        .map((DocumentSnapshot snapshot) => _userDataFromSnapshot(snapshot));
  }
}
