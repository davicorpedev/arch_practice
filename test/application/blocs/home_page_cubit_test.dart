import 'package:arch_practice/application/blocs/home_page/home_page_cubit.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:practice_repositories/entities/ai_image.dart';
import 'package:practice_repositories/entities/result.dart';
import 'package:practice_repositories/error/failures.dart';
import 'package:practice_repositories/repositories/image_repository.dart';

class MockImageRepository extends Mock implements ImageRepository {}

void main() {
  late MockImageRepository repository;

  setUp(() {
    repository = MockImageRepository();
  });

  blocTest<HomePageCubit, HomePageState>(
    'initial State should be [HomePageInitialState]',
    build: () => HomePageCubit(repository: repository),
    verify: (cubit) {
      expect(cubit.state, const HomePageInitialState());
    },
  );

  group(
    'loadImages',
    () {
      const tPrompt = "test";
      const tAiImageList = [AiImage(url: 'test')];
      final tFailure = ServerFailure();

      blocTest<HomePageCubit, HomePageState>(
        'should call loadImages from repository',
        build: () => HomePageCubit(repository: repository),
        setUp: () {
          when(() => repository.loadImages(prompt: any(named: 'prompt')))
              .thenAnswer((_) async => Result.success(tAiImageList));
        },
        act: (cubit) {
          cubit.loadImages(prompt: tPrompt);
        },
        verify: (cubit) {
          verify(() => repository.loadImages(prompt: tPrompt)).called(1);
        },
      );

      blocTest<HomePageCubit, HomePageState>(
        'should emit [HomePageLoadingState, HomePageLoadedState] if the repository return a List of AiImages',
        build: () => HomePageCubit(repository: repository),
        setUp: () {
          when(() => repository.loadImages(prompt: any(named: 'prompt')))
              .thenAnswer((_) async => Result.success(tAiImageList));
        },
        act: (cubit) {
          cubit.loadImages(prompt: tPrompt);
        },
        expect: () => const [
          HomePageLoadingState(),
          HomePageLoadedState(images: tAiImageList),
        ],
      );

      blocTest<HomePageCubit, HomePageState>(
        'should emit [HomePageLoadingState, HomePageErrorState] if the repository return a Failure',
        build: () => HomePageCubit(repository: repository),
        setUp: () {
          when(() => repository.loadImages(prompt: any(named: 'prompt')))
              .thenAnswer((_) async => Result.error(tFailure));
        },
        act: (cubit) {
          cubit.loadImages(prompt: tPrompt);
        },
        expect: () => [
          const HomePageLoadingState(),
          HomePageErrorState(failure: tFailure),
        ],
      );
    },
  );
}
