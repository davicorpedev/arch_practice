part of 'home_page_cubit.dart';

abstract class HomePageState extends Equatable {
  const HomePageState();

  @override
  List<Object> get props => [];
}

class HomePageInitialState extends HomePageState {
  const HomePageInitialState();
}

class HomePageLoadingState extends HomePageState {
  const HomePageLoadingState();
}

class HomePageLoadedState extends HomePageState {
  final List<AiImage> images;

  const HomePageLoadedState({required this.images});

  @override
  List<Object> get props => [images];
}

class HomePageErrorState extends HomePageState {
  final Failure failure;

  const HomePageErrorState({required this.failure});

  @override
  List<Object> get props => [failure];
}
