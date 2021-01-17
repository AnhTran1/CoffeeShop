class MCart {
  String imgUrl;
  String name;
  String price;
  int quantity;
  double priceQuantity;
  bool isCheck;

  MCart({this.imgUrl, this.name, this.price,this.quantity = 1,this.isCheck = false});
  factory MCart.fromJson(Map<String, dynamic> json) {
    return MCart(
      imgUrl: json["imgUrl"],
      name: json["name"],
      price: json["price"],
    );
  }
}