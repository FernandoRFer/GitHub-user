class SearchHistoryModel {
  int? id;
  String searchWord;
  int dateTime;
  SearchHistoryModel({
    this.id,
    required this.searchWord,
    required this.dateTime,
  });

  Map<String, dynamic> toJson() {
    return {
      // 'id': id,
      'searchWord': searchWord,
      'dateTime': dateTime,
    };
  }

  factory SearchHistoryModel.fromJson(Map<String, dynamic> json) {
    return SearchHistoryModel(
      id: json['id'] ?? 0,
      searchWord: json['searchWord'] ?? "",
      dateTime: json['dateTime'] ?? "",
    );
  }
}
