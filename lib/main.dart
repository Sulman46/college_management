import 'package:flutter/material.dart';
import 'core/app/di_container.dart';
import 'core/app/multi_provider.dart';

void main()async{
  final diContainer = DiContainer();
  await diContainer.init();
  runApp(await provider());
}
