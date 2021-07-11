enum SearchType {
  ALBUM,
  ARTIST,
  // PLAYLIST,  // add playlists later if need
  TRACK,
}

extension SearchTypeExtension on SearchType {

  String get name {
    switch (this) {
      case SearchType.ALBUM:
        return 'Album';
      case SearchType.ARTIST:
        return 'Artist';
      case SearchType.TRACK:
        return 'Track';
      default:
        return 'Unknown Category';
    }
  }

}