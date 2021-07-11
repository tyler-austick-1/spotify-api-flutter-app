class Image {
  int width;
  int height;
  String url;

  Image(this.width, this.height, this.url);
  
  Image.fromJson(Map<String, dynamic> jsonMap) {
    this.width = jsonMap['width'];
    this.height = jsonMap['height'];
    // this.url = Uri.parse(jsonMap['url'] as String);
    this.url = jsonMap['url'];
  }

  @override 
  String toString() {
    return "------------------------------------------------------------------\nImage:\nwidth: $width\nheight: $height\nurl: $url\n";
  }
}