import 'package:sonic_mobile/models/models.dart';

abstract class LibraryRepository{

  Future<void> createPlaylist(String playlistTitle);

  Future<List<Playlist>> getPlaylistsByUser(String userId);

  Future<Playlist> getPlaylistDetail(String playlistId);

  Future<void> addItemToPlaylist(String playlistId, String songId);

  Future<void> removeItemFromPlaylist(String playlistId, String songId);

  Future<void> deletePlaylist(String playlistId);

}