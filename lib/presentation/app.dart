import 'package:arch_practice/config/global_app_config.dart';
import 'package:arch_practice/presentation/app_initializer.dart';
import 'package:arch_practice/presentation/pages/home/home_page.dart';
import 'package:arch_practice/presentation/repository_builder.dart';
import 'package:arch_practice/presentation/styles/app_themes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:global_configs/global_configs.dart';
import 'package:http/http.dart' as http;
import 'package:practice_api/client/api_client.dart';
import 'package:practice_api/client/api_requester.dart';
import 'package:provider/provider.dart';

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  late final ApiClient _apiClient;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Accenture Practice',
      home: const HomePage(),
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('en', ''),
        Locale('es', ''),
      ],
      theme: AppThemes.material,
      builder: (context, child) {
        return AppInitializer(
          initializeTasks: () async {
            await _setupConfiguration();
          },
          initalizedBuilder: (context) => Provider.value(
            value: _apiClient,
            child: RepositoryBuilder(
              apiClient: _apiClient,
              child: child!,
            ),
          ),
        );
      },
    );
  }

  Future<void> _setupConfiguration() async {
    final GlobalAppConfig config = GlobalAppConfigImpl(
      configuration: GlobalConfigs(),
    );

    await config.setupConfiguration();

    _apiClient = HttpApiClient(
      requester: HttpApiRequester(
        client: http.Client(),
        serverUrl: config.serverUrl,
        apiKey: config.apiKey,
        serverVersion: config.serverVersion,
      ),
    );
  }
}
