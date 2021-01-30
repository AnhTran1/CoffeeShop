class MCategory {
  MCategory({
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
  List<MCategoryData> data;
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

  factory MCategory.fromJson(Map<String, dynamic> json) {
    return MCategory(
      currentPage: json["current_page"] == null ? null : json["current_page"],
      data: json["data"] == null ? null : List<MCategoryData>.from(json["data"].map((x) => MCategoryData.fromJson(x))),
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
}

class MCategoryData {
  MCategoryData({
    this.id,
    this.name,
    this.description,
  });

  int id;
  String name;
  String description;

  factory MCategoryData.fromJson(Map<String, dynamic> json) => MCategoryData(
    id: json["id"] == null ? null : json["id"],
    name: json["name"] == null ? null : json["name"],
    description: json["description"] == null ? null : json["description"],
  );
}
