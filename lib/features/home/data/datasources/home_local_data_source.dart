import '../models/home_dashboard_model.dart';

abstract class HomeLocalDataSource {
  Future<HomeDashboardModel> getDashboard();
}

class HomeLocalDataSourceImpl implements HomeLocalDataSource {
  const HomeLocalDataSourceImpl();

  @override
  Future<HomeDashboardModel> getDashboard() async {
    return const HomeDashboardModel(
      userNameKey: 'sample_user_name',
      bannerTitleKey: 'healthcare_made_easy',
      bannerDescriptionKey: 'healthcare_made_easy_desc',
    );
  }
}
