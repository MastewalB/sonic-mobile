part of 'artist_bloc.dart';

abstract class ArtistEvent extends Equatable {
  const ArtistEvent();

  @override
  List<Object> get props => [];
}

class LoadArtist extends ArtistEvent {
  final String artistId;
  const LoadArtist(this.artistId);
}
