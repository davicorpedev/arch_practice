import 'package:arch_practice/application/blocs/home_page/home_page_cubit.dart';
import 'package:arch_practice/l10n/app_localizations.dart';
import 'package:arch_practice/presentation/utils/map_failure_to_message.dart';
import 'package:arch_practice/presentation/widgets/app_error.dart';
import 'package:arch_practice/presentation/widgets/custom_masonry_grid_view.dart';
import 'package:arch_practice/presentation/widgets/search_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:practice_repositories/repositories/image_repository.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late final HomePageCubit _cubit;

  @override
  void initState() {
    super.initState();

    _cubit = HomePageCubit(
      repository: RepositoryProvider.of<ImageRepository>(context),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<HomePageCubit>(
      create: (context) => _cubit,
      child: const HomePageBody(),
    );
  }
}

class HomePageBody extends StatefulWidget {
  const HomePageBody({super.key});

  @override
  State<HomePageBody> createState() => _HomePageBodyState();
}

class _HomePageBodyState extends State<HomePageBody> {
  late final TextEditingController _promptController;

  @override
  void initState() {
    super.initState();

    _promptController = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();

    _promptController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context).homePageTitle),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 32),
            child: SearchTextField(
              controller: _promptController,
              onSubmitted: (value) {
                context
                    .read<HomePageCubit>()
                    .loadImages(prompt: _promptController.text);
              },
            ),
          ),
          Expanded(
            child: BlocBuilder<HomePageCubit, HomePageState>(
              builder: (context, state) {
                if (state is HomePageLoadedState) {
                  return CustomMasonryGridView(images: state.images);
                } else if (state is HomePageErrorState) {
                  return Center(
                    child: AppError(
                      description: state.failure.mapFailureToMessage,
                      refresh: () {
                        context
                            .read<HomePageCubit>()
                            .loadImages(prompt: _promptController.text);
                      },
                    ),
                  );
                } else if (state is HomePageInitialState) {
                  return Center(
                    child: Text(
                      AppLocalizations.of(context).homePageErrorLabel,
                      style: Theme.of(context).textTheme.titleMedium,
                      textAlign: TextAlign.center,
                    ),
                  );
                }

                return const Center(child: CircularProgressIndicator());
              },
            ),
          ),
        ],
      ),
    );
  }
}
