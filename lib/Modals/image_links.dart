class ImageLinks {
  String? thumbnail;
  String? extraLarge;

  ImageLinks({this.thumbnail, this.extraLarge});

  factory ImageLinks.fromJson(Map<String, dynamic> json) {
    var imageLinks = ImageLinks();
    imageLinks.thumbnail = json['thumbnail'];
    imageLinks.thumbnail = json['extraLarge'];
    return imageLinks;
  }
}
