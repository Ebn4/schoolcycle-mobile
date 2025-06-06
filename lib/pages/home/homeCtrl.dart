import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:schoolcycle_mobile/business/models/announcement/announcement.dart';
import 'package:schoolcycle_mobile/business/models/category/category.dart';
import 'package:schoolcycle_mobile/business/service/schoolCycleNetworkService.dart';
import 'package:schoolcycle_mobile/main.dart';
import 'package:schoolcycle_mobile/pages/home/homeState.dart';
class HomeController extends StateNotifier<Homestate> {
  var service = getIt.get<SchoolcycleNetworkService>();

  HomeController() : super(Homestate()) {
    getAnnouncements();
    getCategories();
  }

  Future<List<Announcement>> getAnnouncements() async {
    state = state.copyWith(isLoading: true);
    try {
      var announcements = await service.getAnnouncements();
      state = state.copyWith(announcements: announcements, isLoading: false);
      print("valeur : ${announcements}");
      return announcements;
    } catch (e) {
      state = state.copyWith(errorMessage: e.toString(), isLoading: false);
      print("Erreur : ${e.toString()}");
      return [];
    }
  }

  Future<List<Category>> getCategories() async {
    state = state.copyWith(isLoading: true);
    try {
      var categories = await service.getCategories();
      state = state.copyWith(categories: categories, isLoading: false);
      print(categories);
      return categories;
    } catch (e) {
      state = state.copyWith(errorMessage: e.toString(), isLoading: false);
      print("Erreur : ${e.toString()}");
      return [];
    }
  }

  
}

final HomeControllerProvider = StateNotifierProvider<HomeController, Homestate>(
  (ref) => HomeController(),
);
