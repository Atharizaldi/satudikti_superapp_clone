class SearchTrackingUsulan {
  SearchTrackingUsulan({
    required this.data,
    required this.message,
  });
  late final List<SearchTracking> data;
  late final String message;

  SearchTrackingUsulan.fromJson(Map<String, dynamic> json) {
    data = List.from(json['data']).map((e) => SearchTracking.fromJson(e)).toList();
    message = json['message'];
  }
}

class SearchTracking{
  SearchTracking({
    required this.label,
    required this.ticket,
    required this.selectable,
  });
  late final String label;
  late final String ticket;
  late final bool selectable;

  SearchTracking.fromJson(Map<String, dynamic> json) {
    label = json['label'];
    ticket = json['ticket'];
    selectable = json['selectable'];
  }
}
