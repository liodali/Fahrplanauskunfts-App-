import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:search_repository/search_repository.dart';
import 'package:timetabl_app/src/commons/commons.dart';

final appModeProvider = StateProvider<AppMode>((ref) => AppMode.light);
final repositoryProvider = Provider((ref) => SearchRepository());