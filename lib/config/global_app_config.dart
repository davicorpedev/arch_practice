import 'package:global_configuration/global_configuration.dart';

abstract class GlobalAppConfig {
  Future<void> setupConfiguration();
  String get apiKey;
  String get serverUrl;
  String get serverVersion;
}

class GlobalAppConfigImpl implements GlobalAppConfig {
  final GlobalConfiguration _configuration;

  GlobalAppConfigImpl({
    required GlobalConfiguration configuration,
  }) : _configuration = configuration;

  @override
  Future<Map<String, dynamic>> setupConfiguration() async {
    await _configuration.loadFromPath('config/app_config.json');

    return _configuration.appConfig;
  }

  @override
  String get apiKey {
    return _configuration.getValue('api_key');
  }

  @override
  String get serverUrl {
    return _configuration.getValue('server_url');
  }

  @override
  String get serverVersion {
    return _configuration.getValue('server_version');
  }
}
