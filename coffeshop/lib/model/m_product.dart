class MProduct{
  MProduct({
    this.id,
    this.categoryId,
    this.name,
    this.fileImage,
    this.description,
    this.price,
    this.quantity,
  });

  int id;
  int categoryId;
  String name;
  String fileImage;
  String description;
  int price;
  int quantity;

  factory MProduct.fromJson(Map<String, dynamic> json) {
    return MProduct(
      id: json["id"] == null ? null : json["id"],
      categoryId: json["category_id"] == null ? null : json["category_id"],
      name: json["name"] == null ? null : json["name"],
      fileImage: json["file_image"] == null ? null : json["file_image"],
      description: json["description"] == null ? null : json["description"],
      price: json["price"] == null ? null : json["price"],
      quantity: json["quantity"] == null ? null : json["quantity"],
    );
  }
}
