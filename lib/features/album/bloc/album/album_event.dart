abstract class AlbumEvent {}

class LoadAlbumSongs extends AlbumEvent {
  // final Album album;
  final String albumID;

  LoadAlbumSongs(this.albumID);

  @override
  List<Object?> get props => [albumID];
}
