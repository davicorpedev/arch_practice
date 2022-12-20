import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:practice_api/datasources/image_data_source.dart';
import 'package:practice_repositories/repositories/image_repository.dart';
import 'package:practice_repositories/utils/network_info.dart';

class RepositoryBuilder extends StatelessWidget {
  final Widget child;

  const RepositoryBuilder({
    Key? key,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<ImageRepository>(
          create: (context) => ImageRepositoryImpl(
            dataSource: RepositoryProvider.of<ImageDataSource>(context),
            networkInfo: NetworkInfoImpl(
              connectionChecker: InternetConnectionChecker(),
            ),
          ),
        ),
      ],
      child: child,
    );
  }
}
