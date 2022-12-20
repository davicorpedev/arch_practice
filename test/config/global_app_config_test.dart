import 'dart:convert';

import 'package:arch_practice/config/global_app_config.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:global_configuration/global_configuration.dart';
import 'package:mocktail/mocktail.dart';

import '../fixtures/fixture_reader.dart';

class MockGlobalConfiguration extends Mock implements GlobalConfiguration {}

void main() {
  late final MockGlobalConfiguration mockGlobalConfiguration;
  late final GlobalAppConfigImpl globalAppConfig;

  late final Map<String, dynamic> tConfigMap;

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
      when((() => mockGlobalConfiguration.loadFromPath(any()))).thenAnswer(
        (_) async => mockGlobalConfiguration,
      );

      tConfigMap = jsonDecode(fixture('../../config/app_config_template.json'));

      when((() => mockGlobalConfiguration.appConfig)).thenReturn(tConfigMap);

      final result = await globalAppConfig.setupConfiguration();

      verify(
        () => mockGlobalConfiguration.loadFromPath('config/app_config.json'),
      ).called(1);
      expect(result, tConfigMap);
    },
  );

  test(
    'apiKey getter should return a valid String',
    () async {
      when((() => mockGlobalConfiguration.loadFromPath(any()))).thenAnswer(
        (_) async => mockGlobalConfiguration,
      );

      tConfigMap = jsonDecode(fixture('../../config/app_config_template.json'));

      final tApiKey = tConfigMap['api_key'];

      when((() => mockGlobalConfiguration.getValue(any()))).thenReturn(tApiKey);

      final result = globalAppConfig.apiKey;

      verify(() => mockGlobalConfiguration.getValue('api_key')).called(1);
      expect(result, tApiKey);
    },
  );
}
