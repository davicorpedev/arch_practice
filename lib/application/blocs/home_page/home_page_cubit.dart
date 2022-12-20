import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:practice_repositories/entities/ai_image.dart';
import 'package:practice_repositories/error/failures.dart';
import 'package:practice_repositories/repositories/image_repository.dart';

part 'home_page_state.dart';

class HomePageCubit extends Cubit<HomePageState> {
  late final ImageRepository _repository;

  HomePageCubit({
    required ImageRepository repository,
  })  : _repository = repository,
        super(
          const HomePageInitialState(),
        );

  Future<void> loadImages({required String prompt}) async {
    emit(const HomePageLoadingState());

    final result = await _repository.loadImages(prompt: prompt);

    result.when(
      success: (images) {
        emit(
          HomePageLoadedState(images: images),
        );
      },
      error: (failure) {
        emit(
          HomePageErrorState(failure: failure),
        );
      },
    );
  }
}
