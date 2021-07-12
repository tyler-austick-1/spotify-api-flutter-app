enum SearchType {
  ALL,
  ALBUM,
  ARTIST,
  // PLAYLIST,  // add playlists later if need
  TRACK,
}

extension SearchTypeExtension on SearchType {

  String get name {
    switch (this) {
      case SearchType.ALL:
        return 'All';
        break;
      case SearchType.ALBUM:
        return 'Album';
        break;
      case SearchType.ARTIST:
        return 'Artist';
        break;
      case SearchType.TRACK:
        return 'Track';
        break;
      default:
        return 'Unknown Category';
    }
  }

}