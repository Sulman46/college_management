import 'package:college_management/core/app/di_container.dart';
import 'package:college_management/core/app/myapp.dart';
import 'package:flutter/cupertino.dart';

Future<Widget> provider() async {

  WidgetsFlutterBinding.ensureInitialized();
  final diContainer = DiContainer();
  await diContainer.init();
  return MyApp();

}
