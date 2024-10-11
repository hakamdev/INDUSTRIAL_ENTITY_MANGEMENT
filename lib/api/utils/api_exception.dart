import 'package:oqvt_industrial_entity_management/api/utils/errors.dart';

class ApiException implements Exception {
  const ApiException(this.error);

  final XErrors<String> error;
}
