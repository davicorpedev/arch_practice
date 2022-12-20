/*
import 'package:arch_practice/application/flows/image_detail_flow.dart';
import 'package:arch_practice/domain/entities/ai_image.dart';
import 'package:arch_practice/presentation/pages/image_detail/image_detail_page.dart';
import 'package:flow_builder/flow_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../presentation/pump_app.dart';
*/
void main() {
  /*/*group(
    "onGenerateImageDetailPages",
    () {
      test(
        "should create a new ImageDetailPage",
        () {
          const imageDetail = ImageDetail(image: AiImage(url: 'test'));

          final pages = onGenerateImageDetailPages(imageDetail, []);

          expect(
            pages,
            [
              MaterialPage<void>(
                child: ImageDetailPage(image: imageDetail.image),
              ),
            ],
          );
        },
      );
    },
  );*/

  testWidgets(
    '',
    (tester) async {
      await tester.pumpApp(
        ImageDetailFlow(
          image: AiImage(url: 'test'),
        ),
      );

      final FlowBuilder<ImageDetail> flow =
          tester.state(find.byType(FlowBuilder<ImageDetail>));

      print(test);

      /*Navigator.of(context).push(
        ImageDetailFlow.route(image: image),
      );*/
    },
  );*/
}
