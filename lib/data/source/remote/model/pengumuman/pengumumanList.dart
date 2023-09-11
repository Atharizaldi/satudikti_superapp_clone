class PengumumanList {
  PengumumanList({
    required this.currentPage,
    required this.data,
    required this.lastPage,
    required this.totalItem,
    required this.totalItemPerPage,
  });
  late final int currentPage;
  late final List<Data> data;
  late final int lastPage;
  late final int totalItem;
  late final int totalItemPerPage;

  PengumumanList.fromJson(Map<String, dynamic> json) {
    currentPage = json['current_page'];
    data = List.from(json['data']).map((e) => Data.fromJson(e)).toList();
    lastPage = json['last_page'];
    totalItem = json['total_item'];
    totalItemPerPage = json['total_item_per_page'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['current_page'] = currentPage;
    _data['data'] = data.map((e) => e.toJson()).toList();
    _data['last_page'] = lastPage;
    _data['total_item'] = totalItem;
    _data['total_item_per_page'] = totalItemPerPage;
    return _data;
  }
}

class Data {
  Data({
    required this.id,
    required this.title,
    required this.link,
    required this.description,
    required this.publisher,
    required this.publisherDate,
    required this.publisherStatus,
    required this.creator,
    required this.thumbnailImage,
    required this.insertedDate,
    required this.categories,
  });
  late final int id;
  late final String title;
  late final String link;
  late final String description;
  late final String publisher;
  late final String publisherDate;
  late final String publisherStatus;
  late final String creator;
  late final String thumbnailImage;
  late final String insertedDate;
  late final List<Categories> categories;

  Data.fromJson(Map<String, dynamic> json) {
    id = json['news_id'];
    title = json['title'];
    link = json['link'];
    description = json['description'];
    publisher = json['publisher'];
    publisherDate = json['publisher_date'];
    publisherStatus = json['publisher_status'];
    creator = json['creator'];
    thumbnailImage = json['thumbnail_image'];
    insertedDate = json['inserted_date'];
    categories = json['categories'] == null
        ? []
        : List.from(json['categories'])
            .map((e) => Categories.fromJson(e))
            .toList();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['title'] = title;
    _data['link'] = link;
    _data['description'] = description;
    _data['publisher'] = publisher;
    _data['publisher_date'] = publisherDate;
    _data['publisher_status'] = publisherStatus;
    _data['creator'] = creator;
    _data['thumbnail_image'] = thumbnailImage;
    _data['inserted_date'] = insertedDate;
    _data['categories'] = categories.map((e) => e.toJson()).toList();
    return _data;
  }
}

class Categories {
  Categories({
    required this.categoryId,
    required this.categoryName,
  });
  late final int categoryId;
  late final String categoryName;

  Categories.fromJson(Map<String, dynamic> json) {
    categoryId = json['category_id'];
    categoryName = json['category_name'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['category_id'] = categoryId;
    _data['category_name'] = categoryName;
    return _data;
  }
}
