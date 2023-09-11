class Notification {
  final String notifId;
  final int isRead;
  final String title, body, category, tanggal, topic;

  Notification({
    required this.notifId,
    required this.isRead,
    required this.title,
    required this.body,
    required this.category,
    required this.tanggal,
    required this.topic
  });

  Map<String, dynamic> toMap() {
    return {
      'notifId': this.notifId,
      'isRead': this.isRead,
      'title': this.title,
      'body' : this.body,
      'category' : this.category,
      'tanggal' : this.tanggal,
      'topic' : this.topic
    };
  }
}
