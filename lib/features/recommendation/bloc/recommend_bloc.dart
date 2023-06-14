import 'dart:async';
import 'package:sonic_mobile/features/recommendation/repository/http_recommend.dart';
import 'package:sonic_mobile/models/models.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'recommend_event.dart';
part 'recommend_state.dart';

class RecommendBloc extends Bloc<RecommendEvent, RecommendState> {
  final RecommendationDataProvider dataProvider;
  RecommendBloc(this.dataProvider) : super(RecommendInitial()) {
    on<LoadRecommendation>((event, emit) async{
      // TODO: implement event handler
      emit(RecommendLoading());
      final songs = await dataProvider.getRecommendation(event.songId);
      emit(RecommendLoaded(songs));

    });
  }
}
