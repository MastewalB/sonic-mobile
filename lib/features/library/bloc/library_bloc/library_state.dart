part of 'library_bloc.dart';

enum LibraryStatus {
  initial,
  loading,
  loaded,
  error,
}

extension LibraryStatusX on LibraryStatus {
  bool get isInitial => this == LibraryStatus.initial;

  bool get isLoading => this == LibraryStatus.loading;

  bool get isLoaded => this == LibraryStatus.loaded;

  bool get isError => this == LibraryStatus.error;
}

class LibraryState extends Equatable {
  final LibraryStatus status;
  final List<Playlist> playlists;
  final ErrorType errorType;

  @override
  List<Object?> get props => [status, playlists];

  LibraryState({
    this.status = LibraryStatus.initial,
    this.errorType = ErrorType.NONE,
    playlists,
  }) : playlists = playlists ?? <Playlist>[];

  LibraryState copyWith({
    LibraryStatus? status,
    List<Playlist>? playlists,
    ErrorType? errorType,
  }) {
    return LibraryState(
      status: status ?? this.status,
      playlists: playlists ?? this.playlists,
      errorType: errorType ?? this.errorType,
    );
  }
}
