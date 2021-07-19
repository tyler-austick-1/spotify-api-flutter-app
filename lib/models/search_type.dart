// The different search types that the user can filter search results on.
enum SearchType {
  ALL,
  ALBUM,
  ARTIST,
  // PLAYLIST,  // add playlists later if needed
  TRACK,
}

extension SearchTypeExtension on SearchType {

  // Converts the enum type into a string
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