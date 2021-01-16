class MProduct {
  String imgUrl;
  String name;
  String price;

  MProduct({this.imgUrl, this.name, this.price});
  factory MProduct.fromJson(Map<String, dynamic> json) {
    return MProduct(
      imgUrl: json["imgUrl"],
      name: json["name"],
      price: json["price"],
    );
  }
}