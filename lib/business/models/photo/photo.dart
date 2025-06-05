class Photo {
  final int id;
  final String url;
  final int AnnouncementId;

  Photo({
    required this.id,
    required this.url,
    required this.AnnouncementId,
  });

  factory Photo.fromJson(Map<String, dynamic> json) {
    return Photo(
      id: json['id'] ?? 0,
      url: json['url'] ?? '',
      AnnouncementId: json['AnnouncementId'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'url': url,
      'AnnouncementId': AnnouncementId,
    };
  }
}