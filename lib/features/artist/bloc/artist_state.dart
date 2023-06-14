part of 'artist_bloc.dart';

abstract class ArtistState extends Equatable {
  const ArtistState();

  @override
  List<Object> get props => [];
}

class ArtistInitial extends ArtistState {}

class ArtistLoading extends ArtistState {}

class ArtistLoaded extends ArtistState {
  final Artist artist;

  const ArtistLoaded(this.artist);
}

class ArtistError extends ArtistState {
  final String errorMessage;

  const ArtistError(this.errorMessage);
}
