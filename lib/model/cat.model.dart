import 'dart:convert';

class CatImage {
  final String id;
  final String url;
  final double width;
  final double height;
  CatImage({
    required this.id,
    required this.url,
    required this.width,
    required this.height,
  });

  CatImage copyWith({
    String? id,
    String? url,
    double? width,
    double? height,
  }) {
    return CatImage(
      id: id ?? this.id,
      url: url ?? this.url,
      width: width ?? this.width,
      height: height ?? this.height,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'url': url,
      'width': width,
      'height': height,
    };
  }

  factory CatImage.fromMap(Map<String, dynamic> map) {
    return CatImage(
      id: map['id'] as String,
      url: map['url'] as String,
      width: double.parse(map['width'].toString()),
      height: double.parse(map['height'].toString()),
    );
  }

  String toJson() => json.encode(toMap());

  factory CatImage.fromJson(String source) =>
      CatImage.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'CatImage(id: $id, url: $url, width: $width, height: $height)';
  }

  @override
  bool operator ==(covariant CatImage other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.url == url &&
        other.width == width &&
        other.height == height;
  }

  @override
  int get hashCode {
    return id.hashCode ^ url.hashCode ^ width.hashCode ^ height.hashCode;
  }
}
