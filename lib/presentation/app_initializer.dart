import 'package:arch_practice/application/blocs/app_initializer/app_initializer_cubit.dart';
import 'package:arch_practice/l10n/app_localizations.dart';
import 'package:arch_practice/presentation/app_splash.dart';
import 'package:arch_practice/presentation/widgets/app_error.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppInitializer extends StatefulWidget {
  final Future<void> Function() initializeTasks;
  final WidgetBuilder initalizedBuilder;

  const AppInitializer({
    Key? key,
    required this.initializeTasks,
    required this.initalizedBuilder,
  }) : super(key: key);

  @override
  State<AppInitializer> createState() => _AppInitializerState();
}

class _AppInitializerState extends State<AppInitializer> {
  late final AppInitializerCubit _cubit;

  @override
  void initState() {
    _cubit = AppInitializerCubit();
    _cubit.initializeTasks(widget.initializeTasks);

    super.initState();
  }

  @override
  void dispose() {
    super.dispose();

    _cubit.close();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppInitializerCubit, AppInitializerState>(
      bloc: _cubit,
      builder: (context, state) {
        if (state is AppInitializerLoadedState) {
          return widget.initalizedBuilder(context);
        } else if (state is AppInitializerErrorState) {
          return AppSplash(
            child: AppError(
              description:
                  AppLocalizations.of(context).appInitializerErrorLabel,
              refresh: () => _cubit.initializeTasks(widget.initializeTasks),
            ),
          );
        }

        return const AppSplash();
      },
    );
  }
}
