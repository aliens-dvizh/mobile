import 'package:depend/depend.dart';
import 'package:talker/talker.dart';

class TalkerService extends Dependency {
  final Talker talker;

  TalkerService(this.talker);
}
