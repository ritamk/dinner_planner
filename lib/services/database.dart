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

  Future setUserData(ExtendedUserData data) async {
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
      "orderHistory": <OrderData>[],
    });
  }

  Future updateUserData(ExtendedUserData data) async {
    try {
      return await userCollectionReference.doc(uid).update({
        "name": data.name,
        "phone": data.phone,
        "address": {
          "landmark": data.landmark,
          "adLine": data.adLine,
          "city": data.city,
          "pin": data.pin,
          "state": data.state,
        },
      });
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future updateUserOrders(OrderData data) async {
    return await userCollectionReference.doc(uid).update({
      "order": FieldValue.arrayUnion([
        {
          "name": data.food.name,
          "price": data.food.price,
          "item": menuCollectionReference.doc(data.food.foodId),
          "qty": data.qty,
          "time": Timestamp.now(),
        }
      ])
    });
  }

  Future removeUserOrders(OrderData data) async {
    return await userCollectionReference.doc(uid).update({
      "order": FieldValue.arrayRemove([
        {
          "name": data.food.name,
          "price": data.food.price,
          "item": menuCollectionReference.doc(data.food.foodId),
          "qty": data.qty,
          "time": Timestamp.now(),
        }
      ])
    });
  }

  Future updateUserOrderHistory(OrderData data) async {
    return await userCollectionReference.doc(uid).update({
      "orderHistory": FieldValue.arrayUnion([
        {
          "name": data.food.name,
          "price": data.food.price,
          "item": menuCollectionReference.doc(data.food.foodId),
          "qty": data.qty,
          "time": Timestamp.now(),
        }
      ])
    });
  }

  Future removeUserOrderHistory(OrderData data) async {
    return await userCollectionReference.doc(uid).update({
      "orderHistory": FieldValue.arrayRemove([
        {
          "name": data.food.name,
          "price": data.food.price,
          "item": menuCollectionReference.doc(data.food.foodId),
          "qty": data.qty,
          "time": Timestamp.now()
        }
      ])
    });
  }

  List _userActiveOrderHistory(DocumentSnapshot snapshot) {
    return snapshot.get("order");
  }

  UserData _userDataFromSnapshot(DocumentSnapshot snapshot) {
    return UserData(
        uid: uid!, name: snapshot["name"], userPic: snapshot["userPic"]);
  }

  ExtendedUserData? _extendedUserDataFromSnapshot(DocumentSnapshot snapshot) {
    try {
      return ExtendedUserData(
        uid: uid!,
        name: snapshot["name"],
        userPic: snapshot["userPic"],
        email: snapshot["email"],
        phone: snapshot["phone"],
        address: snapshot["address"],
      );
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  List<Food> _foodListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((dynamic e) {
      return Food(
          name: e.data()["name"],
          price: e.data()["price"],
          veg: e.data()["veg"],
          type: e.data()["type"],
          foodId: e.data()["uid"],
          about: e.data()["about"]);
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
        .orderBy("name")
        .snapshots()
        .map((QuerySnapshot snapshot) => _foodListFromSnapshot(snapshot));
  }

  Stream<UserData> get userData {
    return userCollectionReference
        .doc(uid)
        .snapshots()
        .map((DocumentSnapshot snapshot) => _userDataFromSnapshot(snapshot));
  }

  Stream<ExtendedUserData?> get extendedUserData {
    return userCollectionReference.doc(uid).snapshots().map(
        (DocumentSnapshot snapshot) => _extendedUserDataFromSnapshot(snapshot));
  }

  Stream get userActiveOrder {
    return userCollectionReference
        .doc(uid)
        .snapshots()
        .map((DocumentSnapshot snapshot) => _userActiveOrderHistory(snapshot));
  }
}
