import 'dart:convert';

import 'package:arch_practice/config/global_app_config.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:global_configs/global_configs.dart';
import 'package:mocktail/mocktail.dart';

import '../fixtures/fixture_reader.dart';

class MockGlobalConfiguration extends Mock implements GlobalConfigs {}

void main() {
  late MockGlobalConfiguration mockGlobalConfiguration;
  late GlobalAppConfigImpl globalAppConfig;

  late Map<String, dynamic> tConfigMap;

  setUp(
    () {
      mockGlobalConfiguration = MockGlobalConfiguration();
      globalAppConfig = GlobalAppConfigImpl(
        configuration: mockGlobalConfiguration,
      );
    },
  );

  test(
    'setupConfiguration should return a valid Config Map',
    () async {
      when((() => mockGlobalConfiguration.loadJsonFromdir(any()))).thenAnswer(
        (_) async => mockGlobalConfiguration,
      );

      tConfigMap = jsonDecode(fixture('../../config/app_config_template.json'));

      when((() => mockGlobalConfiguration.configs)).thenReturn(tConfigMap);

      final result = await globalAppConfig.setupConfiguration();

      verify(
        () => mockGlobalConfiguration.loadJsonFromdir('config/app_config.json'),
      ).called(1);
      expect(result, tConfigMap);
    },
  );

  test(
    'apiKey getter should return a valid String',
    () async {
      when((() => mockGlobalConfiguration.loadJsonFromdir(any()))).thenAnswer(
        (_) async => mockGlobalConfiguration,
      );

      tConfigMap = jsonDecode(fixture('../../config/app_config_template.json'));

      final tApiKey = tConfigMap['api_key'];

      when((() => mockGlobalConfiguration.get(any()))).thenReturn(tApiKey);

      final result = globalAppConfig.apiKey;

      verify(() => mockGlobalConfiguration.get('api_key')).called(1);
      expect(result, tApiKey);
    },
  );
}
