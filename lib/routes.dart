import 'package:get/get.dart';
import 'package:pills_guardian_v2_rebuild_complete/ui/pages/alerts_page.dart';
import 'package:pills_guardian_v2_rebuild_complete/ui/pages/create_formula_page.dart';
import 'package:pills_guardian_v2_rebuild_complete/ui/pages/formula_detail_page.dart';
import 'package:pills_guardian_v2_rebuild_complete/ui/pages/formula_summary_page.dart';
import 'package:pills_guardian_v2_rebuild_complete/ui/pages/history_page.dart';
import 'package:pills_guardian_v2_rebuild_complete/ui/pages/home_page.dart';
import 'package:pills_guardian_v2_rebuild_complete/ui/pages/login_page.dart';
import 'package:pills_guardian_v2_rebuild_complete/ui/pages/profile_page.dart';
import 'package:pills_guardian_v2_rebuild_complete/ui/pages/register_page.dart';
import 'package:pills_guardian_v2_rebuild_complete/ui/pages/reminders_page.dart';
import 'package:pills_guardian_v2_rebuild_complete/ui/pages/splash_page.dart';
import 'package:pills_guardian_v2_rebuild_complete/ui/pages/statistics_page.dart';

abstract class AppRoutes {
  static const splash = '/splash';
  static const login = '/login';
  static const register = '/register';
  static const home = '/home';
  static const profile = '/profile';
  static const createFormula = '/create-formula';
  static const formulaSummary = '/formula-summary';
  static const formulaDetail = '/formula-detail';
  static const reminders = '/reminders';
  static const history = '/history';
  static const alerts = '/alerts';
  static const statistics = '/statistics';

  static final pages = [
    GetPage(name: splash, page: () => const SplashPage()),
    GetPage(name: login, page: () => LoginPage()),
    GetPage(name: register, page: () => RegisterPage()),
    GetPage(name: home, page: () => HomePage()),
    GetPage(name: profile, page: () => ProfilePage()),
    GetPage(name: createFormula, page: () => CreateFormulaPage()),
    GetPage(name: formulaSummary, page: () => const FormulaSummaryPage()),
    GetPage(name: formulaDetail, page: () => FormulaDetailPage()),
    GetPage(name: reminders, page: () => RemindersPage()),
    GetPage(name: history, page: () => const HistoryPage()),
    GetPage(name: alerts, page: () => AlertsPage()),
    GetPage(name: statistics, page: () => StatisticsPage()),
  ];
}
