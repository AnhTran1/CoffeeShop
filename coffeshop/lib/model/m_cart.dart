class MCart {
  MCart({
    this.currentPage,
    this.data,
    this.firstPageUrl,
    this.from,
    this.lastPage,
    this.lastPageUrl,
    this.nextPageUrl,
    this.path,
    this.perPage,
    this.prevPageUrl,
    this.to,
    this.total,
  });

  int currentPage;
  List<MCartData> data;
  String firstPageUrl;
  int from;
  int lastPage;
  String lastPageUrl;
  dynamic nextPageUrl;
  String path;
  int perPage;
  dynamic prevPageUrl;
  int to;
  int total;

  factory MCart.fromJson(Map<String, dynamic> json) => MCart(
    currentPage: json["current_page"] == null ? null : json["current_page"],
    data: json["data"] == null ? null : List<MCartData>.from(json["data"].map((x) => MCartData.fromJson(x))),
    firstPageUrl: json["first_page_url"] == null ? null : json["first_page_url"],
    from: json["from"] == null ? null : json["from"],
    lastPage: json["last_page"] == null ? null : json["last_page"],
    lastPageUrl: json["last_page_url"] == null ? null : json["last_page_url"],
    nextPageUrl: json["next_page_url"],
    path: json["path"] == null ? null : json["path"],
    perPage: json["per_page"] == null ? null : json["per_page"],
    prevPageUrl: json["prev_page_url"],
    to: json["to"] == null ? null : json["to"],
    total: json["total"] == null ? null : json["total"],
  );
}

class MCartData {
  MCartData({
    this.id,
    this.itemId,
    this.userId,
    this.price,
    this.quantity,
    this.name,
    this.fileImage,
    this.isCheck = false,
    this.priceQuantity ,
  });

  int id;
  int itemId;
  int userId;
  int price;
  int quantity;
  String name;
  String fileImage;
  bool isCheck;
  int priceQuantity;

  factory MCartData.fromJson(Map<String, dynamic> json) => MCartData(
    id: json["id"] == null ? null : json["id"],
    itemId: json["item_id"] == null ? null : json["item_id"],
    userId: json["user_id"] == null ? null : json["user_id"],
    price: json["price"] == null ? null : json["price"],
    quantity: json["quantity"] == null ? null : json["quantity"],
    name: json["name"] == null ? null : json["name"],
    fileImage: json["file_image"] == null ? null : json["file_image"],
  );
}