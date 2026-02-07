import 'package:mobile_app_skeleton/pages/page1/page1_datasource.dart';
import 'package:mobile_app_skeleton/pages/page1/page1_repository.dart';
import 'package:mobile_app_skeleton/pages/page1/page1_usecases.dart';
import 'package:mobile_app_skeleton/pages/page2/page2_datasource.dart';
import 'package:mobile_app_skeleton/pages/page2/page2_repository.dart';
import 'package:mobile_app_skeleton/pages/page2/page2_usecases.dart';
import 'package:mobile_app_skeleton/pages/page3/page3_datasource.dart';
import 'package:mobile_app_skeleton/pages/page3/page3_repository.dart';
import 'package:mobile_app_skeleton/pages/page3/page3_usecases.dart';
import 'package:mobile_app_skeleton/pages/page4/page4_datasource.dart';
import 'package:mobile_app_skeleton/pages/page4/page4_repository.dart';
import 'package:mobile_app_skeleton/pages/page4/page4_usecases.dart';
import 'package:mobile_app_skeleton/pages/page5/page5_datasource.dart';
import 'package:mobile_app_skeleton/pages/page5/page5_repository.dart';
import 'package:mobile_app_skeleton/pages/page5/page5_usecases.dart';
import 'package:mobile_app_skeleton/pages/page6/page6_datasource.dart';
import 'package:mobile_app_skeleton/pages/page6/page6_repository.dart';
import 'package:mobile_app_skeleton/pages/page6/page6_usecases.dart';

/// Central place to wire up repositories/use-cases without relying on DI plugins.
///
/// Pages can access this via [AppScope] to keep UI code free of external packages.
class AppServices {
  final Page1Usecases page1;
  final Page2Usecases page2;
  final Page3Usecases page3;
  final Page4Usecases page4;
  final Page5Usecases page5;
  final Page6Usecases page6;

  const AppServices({
    required this.page1,
    required this.page2,
    required this.page3,
    required this.page4,
    required this.page5,
    required this.page6,
  });

  factory AppServices.create() {
    return AppServices(
      page1: Page1Usecases(repository: Page1Repository(dataSource: Page1DataSource())),
      page2: Page2Usecases(repository: Page2Repository(dataSource: Page2DataSource())),
      page3: Page3Usecases(repository: Page3Repository(dataSource: Page3DataSource())),
      page4: Page4Usecases(repository: Page4Repository(dataSource: Page4DataSource())),
      page5: Page5Usecases(repository: Page5Repository(dataSource: Page5DataSource())),
      page6: Page6Usecases(repository: Page6Repository(dataSource: Page6DataSource())),
    );
  }
}

