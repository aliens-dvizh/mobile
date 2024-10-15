import 'model.dart';

abstract class DTO<M extends ModelItem> {
  M toModel();
}
