class NewsDetail {
  NewsDetail({
    required this.content,
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
  late final String content;
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
  
  NewsDetail.fromJson(Map<String, dynamic> json){
    content = json['content'];
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
    _data['content'] = content;
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