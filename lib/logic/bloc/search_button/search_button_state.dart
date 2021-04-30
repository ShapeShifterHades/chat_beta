part of 'search_button_bloc.dart';

enum SearchButtonStatus { initial, loading, hasResult, hasError }

class SearchButtonState {
  final bool? isExpanded; // Wether the result of search is shown.
  final bool? isLoading; // Wether the state of search query is loading.
  final bool? hasError; // Wether the result of search query contains an error.
  final SearchButtonStatus? status;

  SearchButtonState({
    this.isExpanded,
    this.isLoading,
    this.hasError,
    this.status,
  });

  factory SearchButtonState.initial() {
    return SearchButtonState(
      isExpanded: false,
      isLoading: false,
      hasError: false,
      status: SearchButtonStatus.initial,
    );
  }

  factory SearchButtonState.loading() {
    return SearchButtonState(
      isLoading: true,
      isExpanded: false,
      hasError: false,
      status: SearchButtonStatus.loading,
    );
  }

  factory SearchButtonState.hasResult() {
    return SearchButtonState(
      isLoading: false,
      isExpanded: true,
      hasError: false,
      status: SearchButtonStatus.hasResult,
    );
  }

  factory SearchButtonState.hasError() {
    return SearchButtonState(
      isLoading: false,
      isExpanded: false,
      hasError: true,
      status: SearchButtonStatus.hasError,
    );
  }
}
