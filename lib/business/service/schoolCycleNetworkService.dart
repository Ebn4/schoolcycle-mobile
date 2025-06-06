import 'package:schoolcycle_mobile/business/models/announcement/announcement.dart';
import 'package:schoolcycle_mobile/business/models/category/category.dart';
import 'package:schoolcycle_mobile/business/models/user/authentification.dart';
import 'package:schoolcycle_mobile/business/models/user/user.dart';

abstract class SchoolcycleNetworkService {
  // Gestion d'annonces
  Future<List<Announcement>> getAnnouncements();
  Future<Announcement> getAnnouncement();

  // Gestion des categories
  Future<List<Category>> getCategories();
  Future<Category> getCategory();

  // gestion de user
  Future<User?> authenfication(Authentification data);
}
