import 'package:complex_api_parsing/Modals/image_links.dart';

class VolumeInfo {
  String? title;
  List<String>? author;
  ImageLinks? imageLinks;

  VolumeInfo({this.title, this.author, this.imageLinks});

  factory VolumeInfo.fromJson(Map<String, dynamic> json) {
    var volumeInfoParsed = VolumeInfo();
    volumeInfoParsed.title = json['title'];
    volumeInfoParsed.author = [];
    for (var authorStr in json['authors']) {
      volumeInfoParsed.author?.add(authorStr);
    }
    volumeInfoParsed.imageLinks = ImageLinks.fromJson(json['imageLinks']);
    return volumeInfoParsed;
  }
}
