part of 'studio_bloc.dart';

enum StudioStatus {
  initial,
  loading,
  loaded,
  error,
}

extension StudioStatusX on StudioStatus {
  bool get isInitial => this == StudioStatus.initial;

  bool get isLoading => this == StudioStatus.loading;

  bool get isLoaded => this == StudioStatus.loaded;

  bool get isError => this == StudioStatus.error;
}

class StudioState extends Equatable {
  final StudioStatus status;
  final List<StudioPodcast> podcasts;
  final ErrorType errorType;

  @override
  List<Object?> get props => [status, podcasts];

  StudioState({
    this.status = StudioStatus.initial,
    this.errorType = ErrorType.NONE,
    podcasts,
  }) : podcasts = podcasts ?? <StudioPodcast>[];

  StudioState copyWith({
    StudioStatus? status,
    List<StudioPodcast>? podcasts,
    ErrorType? errorType,
  }) {
    return StudioState(
      status: status ?? this.status,
      podcasts: podcasts ?? this.podcasts,
      errorType: errorType ?? this.errorType,
    );
  }
}
