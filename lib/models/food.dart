class FoodID {
  final String uid;

  FoodID({required this.uid});
}

class Food {
  final String name;
  final int price;
  final bool veg;
  final String type;
  final String foodId;
  final String about;
  final String image;

  Food(
      {required this.name,
      required this.price,
      required this.veg,
      required this.type,
      required this.foodId,
      required this.about,
      required this.image});
}
