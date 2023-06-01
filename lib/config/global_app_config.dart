import 'package:global_configs/global_configs.dart';

abstract class GlobalAppConfig {
  Future<void> setupConfiguration();
  String get apiKey;
  String get serverUrl;
  String get serverVersion;
}

class GlobalAppConfigImpl implements GlobalAppConfig {
  final GlobalConfigs _configuration;

  GlobalAppConfigImpl({
    required GlobalConfigs configuration,
  }) : _configuration = configuration;

  @override
  Future<Map<String, dynamic>> setupConfiguration() async {
    await _configuration.loadJsonFromdir('config/app_config.json');

    return _configuration.configs;
  }

  @override
  String get apiKey {
    return _configuration.get('api_key');
  }

  @override
  String get serverUrl {
    return _configuration.get('server_url');
  }

  @override
  String get serverVersion {
    return _configuration.get('server_version');
  }
}
