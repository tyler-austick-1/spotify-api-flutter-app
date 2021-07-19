/* 
  Defines the proporties for an Image.

  To see what the Spotify API's Image Object returns see https://developer.spotify.com/documentation/web-api/reference/#objects-index
*/

class Image {
  int width;
  int height;
  String url;

  Image(this.width, this.height, this.url);
  
  /*
    Initialises the fields of an Image object from the json data that
    is retrieved from the Spotify API.
  */
  Image.fromJson(Map<String, dynamic> jsonMap) {
    this.width = jsonMap['width'];
    this.height = jsonMap['height'];
    this.url = jsonMap['url'];
  }

  @override 
  String toString() {
    return "------------------------------------------------------------------\nImage:\nwidth: $width\nheight: $height\nurl: $url\n";
  }
}