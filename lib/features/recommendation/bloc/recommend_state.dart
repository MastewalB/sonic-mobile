part of 'recommend_bloc.dart';

abstract class RecommendState extends Equatable {
  const RecommendState();
  @override
  List<Object> get props => [];
}

class RecommendInitial extends RecommendState {

}

class RecommendLoading extends RecommendState{}

class RecommendLoaded extends RecommendState{
  final List<Song> songs;
  RecommendLoaded(this.songs);

}

class RecommendError extends RecommendState{
  final String errorMessage;
  RecommendError(this.errorMessage);
}


