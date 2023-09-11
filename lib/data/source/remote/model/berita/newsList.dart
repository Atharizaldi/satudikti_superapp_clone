class NewsList {
  NewsList({
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

  NewsList.fromJson(Map<String, dynamic> json) {
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
    required this.creator,
    required this.description,
    required this.insertedDate,
    required this.link,
    required this.newsId,
    required this.publisher,
    required this.publisherDate,
    required this.publisherStatus,
    required this.thumbnailImage,
    required this.title,
  });
  late final String creator;
  late final String description;
  late final String insertedDate;
  late final String link;
  late final int newsId;
  late final String publisher;
  late final String publisherDate;
  late final String publisherStatus;
  late final String thumbnailImage;
  late final String title;

  Data.fromJson(Map<String, dynamic> json) {
    creator = json['creator'];
    description = json['description'];
    insertedDate = json['inserted_date'];
    link = json['link'];
    newsId = json['news_id'];
    publisher = json['publisher'];
    publisherDate = json['publisher_date'];
    publisherStatus = json['publisher_status'];
    thumbnailImage = json['thumbnail_image'];
    title = json['title'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['creator'] = creator;
    _data['description'] = description;
    _data['inserted_date'] = insertedDate;
    _data['link'] = link;
    _data['news_id'] = newsId;
    _data['publisher'] = publisher;
    _data['publisher_date'] = publisherDate;
    _data['publisher_status'] = publisherStatus;
    _data['thumbnail_image'] = thumbnailImage;
    _data['title'] = title;
    return _data;
  }
}
