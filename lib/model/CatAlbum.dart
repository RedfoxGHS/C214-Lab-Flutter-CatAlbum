class CatAlbum {
  final String id;
  final String url;
  final int width;
  final int height;

  const CatAlbum({
    required this.id,
    required this.url,
    required this.width,
    required this.height,
  });

  factory CatAlbum.fromJson(List<dynamic> json) {
    return CatAlbum(
      id: json[0]['id'],
      url: json[0]['url'],
      width: json[0]['width'],
      height: json[0]['height'],
    );
  }
}