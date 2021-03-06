class News {
  News({
    required this.status,
    required this.message,
    required this.data,
  });
  late final int status;
  late final String message;
  late final List<DataNews> data;

  News.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = List.from(json['data']).map((e) => DataNews.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['status'] = status;
    _data['message'] = message;
    _data['data'] = data.map((e) => e.toJson()).toList();
    return _data;
  }
}

class DataNews {
  DataNews({
    required this.Id,
    required this.Created,
    required this.Title,
    required this.Excerpt,
    required this.BannerImage,
  });
  late final String Id;
  late final String Created;
  late final String Title;
  late final String Excerpt;
  late final String BannerImage;

  DataNews.fromJson(Map<String, dynamic> json) {
    Id = json['Id'];
    Created = json['Created'];
    Title = json['Title'];
    Excerpt = json['Excerpt'];
    BannerImage = json['BannerImage'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['Id'] = Id;
    _data['Created'] = Created;
    _data['Title'] = Title;
    _data['Excerpt'] = Excerpt;
    _data['BannerImage'] = BannerImage;
    return _data;
  }
}
