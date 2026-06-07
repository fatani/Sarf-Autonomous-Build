import 'package:flutter_test/flutter_test.dart';
import 'package:sarf/core/constants/app_constants.dart';
import 'package:sarf/core/domain/enums.dart';
import 'package:sarf/features/templates/data/template_seed.dart';

void main() {
  test('built-in template library has unique ids', () {
    final templates = TemplateSeedLibrary.builtInTemplates();
    final ids = templates.map((template) => template.id).toSet();
    expect(ids.length, templates.length);
  });

  test('templates count is 115 with all required categories', () {
    final templates = TemplateSeedLibrary.builtInTemplates();
    expect(templates.length, AppConstants.builtInTemplateCount);

    final categories = templates.map((template) => template.category).toSet();
    expect(categories, contains(CommitmentCategory.entertainment));
    expect(categories, contains(CommitmentCategory.work));
    expect(categories, contains(CommitmentCategory.education));
    expect(categories, contains(CommitmentCategory.telecom));
    expect(categories, contains(CommitmentCategory.utilities));
    expect(categories, contains(CommitmentCategory.storage));
    expect(categories, contains(CommitmentCategory.other));
  });
}
