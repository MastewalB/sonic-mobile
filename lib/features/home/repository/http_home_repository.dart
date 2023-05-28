import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:sonic_mobile/models/models.dart';

class HomeDataProvider {
  final _baseUrl = 'http://localhost:8000/api/v1/music/';
  final http.Client httpClient;

  HomeDataProvider({required this.httpClient});

  //get songs
  Future<List<Song>> getRecommendedSongs() async {
    final response = await httpClient.get(Uri.parse('$_baseUrl/songs/'));

    if (response.statusCode == 200) {
      final List<dynamic> songs = jsonDecode(response.body);

      // Map JSON songs to Song objects
      final List<Song> songList =
          songs.map((songData) => Song.fromJson(songData)).toList();

      // Sort songs by dateAdded in descending order
      // Need to add the dateAdded field in the serializer (not returned as of now)
      songList.sort((a, b) => b.dateAdded.compareTo(a.dateAdded));

      // Return a maximum of 15 songs
      final limitedSongs = songList.take(15).toList();

      return limitedSongs;
    } else {
      throw Exception('Failed to load songs');
    }
  }
}













// class ArtistDataProvider {
//   final _baseUrl = 'http://localhost:8000/api/v1/music/';
//   final http.Client httpClient;

//   ArtistDataProvider({required this.httpClient});

//   // get artist by id
//   Future<Artist> getArtist(String artistId) async {
//     final response =
//         await httpClient.get(Uri.parse('$_baseUrl/artists/$artistId'));

//     if (response.statusCode == 200) {
//       final artist = jsonDecode(response.body);
//       return Artist.fromJson(artist);
//     } else {
//       throw Exception('Failed to load artist');
//     }
//   }

//   // get all artists
//   Future<Artist> getAllArtists() async {
//     final response = await httpClient.get(Uri.parse('$_baseUrl/artists/'));

//     if (response.statusCode == 200) {
//       final artist = jsonDecode(response.body);
//       return Artist.fromJson(artist);
//     } else {
//       throw Exception('Failed to load aritst');
//     }
//   }
// }
