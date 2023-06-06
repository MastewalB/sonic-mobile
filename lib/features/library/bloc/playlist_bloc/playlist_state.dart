part of 'playlist_bloc.dart';

enum PlaylistStatus { initial, loading, loaded, error }

extension PlaylistStatusX on PlaylistStatus {
  bool get isInitial => this == PlaylistStatus.initial;

  bool get isLoading => this == PlaylistStatus.loading;

  bool get isLoaded => this == PlaylistStatus.loaded;

  bool get isError => this == PlaylistStatus.error;
}

class PlaylistState extends Equatable {
  final PlaylistStatus status;
  final Playlist? playlist;
  final ErrorType errorType;

  @override
  List<Object?> get props => [status, playlist, errorType];

  const PlaylistState({
    this.status = PlaylistStatus.initial,
    this.errorType = ErrorType.NONE,
    this.playlist,
  });

  PlaylistState copyWith({
    PlaylistStatus? status,
    Playlist? playlist,
    ErrorType? errorType,
  }) {
    return PlaylistState(
      status: status ?? this.status,
      playlist: playlist ?? this.playlist,
      errorType: errorType ?? this.errorType,
    );
  }
}
