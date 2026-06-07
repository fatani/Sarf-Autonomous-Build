import 'package:go_router/go_router.dart';
import 'package:sarf/features/commitments/presentation/commitment_detail_screen.dart';
import 'package:sarf/features/commitments/presentation/commitments_screen.dart';
import 'package:sarf/features/insights/presentation/insights_screen.dart';
import 'package:sarf/features/reports/presentation/reports_screen.dart';
import 'package:sarf/features/settings/presentation/legal_screen.dart';
import 'package:sarf/features/settings/presentation/settings_screen.dart';
import 'package:sarf/features/templates/presentation/templates_screen.dart';
import 'package:sarf/app/shell_scaffold.dart';

enum AppRoute {
  commitments('/'),
  commitmentDetail('/commitments/:id'),
  templates('/templates'),
  insights('/insights'),
  reports('/insights/report'),
  settings('/settings'),
  privacy('/settings/privacy'),
  terms('/settings/terms');

  const AppRoute(this.path);

  final String path;
}

final appRouter = GoRouter(
  initialLocation: AppRoute.commitments.path,
  routes: [
    GoRoute(
      path: AppRoute.commitmentDetail.path,
      builder: (context, state) => CommitmentDetailScreen(
        commitmentId: state.pathParameters['id']!,
      ),
    ),
    GoRoute(
      path: AppRoute.reports.path,
      builder: (context, state) => const ReportsScreen(),
    ),
    StatefulShellRoute.indexedStack(
      builder: (context, state, navigationShell) {
        return ShellScaffold(navigationShell: navigationShell);
      },
      branches: [
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: AppRoute.commitments.path,
              builder: (context, state) => const CommitmentsScreen(),
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: AppRoute.templates.path,
              builder: (context, state) => const TemplatesScreen(),
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: AppRoute.insights.path,
              builder: (context, state) => const InsightsScreen(),
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: AppRoute.settings.path,
              builder: (context, state) => const SettingsScreen(),
              routes: [
                GoRoute(
                  path: 'privacy',
                  builder: (context, state) => const LegalScreen.privacy(),
                ),
                GoRoute(
                  path: 'terms',
                  builder: (context, state) => const LegalScreen.terms(),
                ),
              ],
            ),
          ],
        ),
      ],
    ),
  ],
);
