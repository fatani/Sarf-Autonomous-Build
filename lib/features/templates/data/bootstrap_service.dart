import 'package:sarf/features/shared/data/repositories.dart';
import 'package:sarf/features/templates/data/template_seed.dart';

class BootstrapService {
  BootstrapService(this._templateRepository);

  final TemplateRepository _templateRepository;

  Future<void> ensureSeeded() async {
    final count = await _templateRepository.countTemplates();
    if (count < TemplateSeedLibrary.expectedCount) {
      await _templateRepository.upsertAll(TemplateSeedLibrary.builtInTemplates());
    }
  }
}
