import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:practice_api/client/api_client.dart';
import 'package:practice_api/datasources/image_data_source.dart';
import 'package:provider/provider.dart';

class DataSourceBuilder extends StatelessWidget {
  final ApiClient apiClient;
  final Widget child;

  const DataSourceBuilder({
    Key? key,
    required this.child,
    required this.apiClient,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        RepositoryProvider<ImageDataSource>(
          create: (context) => ImageDataSourceImpl(client: apiClient),
        ),
      ],
      child: child,
    );
  }
}
