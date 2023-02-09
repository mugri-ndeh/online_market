part of 'search_cubit.dart';

abstract class SearchState extends GlobalAppState {
  const SearchState();

  @override
  List<Object> get props => [];
}

class SearchInitial extends SearchState {}

class SearchLoading extends SearchState {}

class Searching extends SearchState {}

class SearchLoaded extends SearchState {
  final List<Product> products;
  const SearchLoaded({required this.products});
}

class SearchError extends SearchState {
  @override
  final GlobalErrorData error;
  const SearchError({required this.error});
}
