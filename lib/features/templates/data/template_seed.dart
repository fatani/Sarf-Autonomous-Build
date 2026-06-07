import 'package:sarf/core/constants/app_constants.dart';
import 'package:sarf/core/domain/models.dart';
import 'package:sarf/features/templates/data/template_seed_entries.dart';

abstract final class TemplateSeedLibrary {
  static List<ServiceTemplateModel> builtInTemplates() {
    return buildTemplateEntries();
  }

  static int get expectedCount => AppConstants.builtInTemplateCount;
}
