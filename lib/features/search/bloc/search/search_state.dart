import 'package:equatable/equatable.dart';

// Import other necessary libraries
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

abstract class SearchState extends Equatable {
  const SearchState();

  @override
  List<Object?> get props => [];
}

class SearchInitial extends SearchState {}

class SearchLoadingState extends SearchState {}

class SearchLoadedState extends SearchState {
  final List<dynamic> searchData;

  const SearchLoadedState(this.searchData);

  @override
  List<Object?> get props => [searchData];
}

class SearchErrorState extends SearchState {
  final String errorMessage;

  const SearchErrorState(this.errorMessage);

  @override
  List<Object?> get props => [errorMessage];
}

class SearchEmptyState extends SearchState {
  const SearchEmptyState();

  @override
  List<Object?> get props => [];
}
