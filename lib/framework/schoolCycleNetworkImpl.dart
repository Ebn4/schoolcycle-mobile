import 'package:schoolcycle_mobile/business/models/announcement/announcement.dart';
import 'package:schoolcycle_mobile/business/models/category/category.dart';
import 'package:schoolcycle_mobile/business/service/schoolCycleNetworkService.dart';

class Schoolcyclenetworkimpl implements SchoolcycleNetworkService{
  @override
  Future<Announcement> getAnnouncement() {
    // TODO: implement getAnnouncement
    throw UnimplementedError();
  }

  @override
  Future<List<Announcement>> getAnnouncements() {
    // TODO: implement getAnnouncements
    throw UnimplementedError();
  }

  @override
  Future<List<Category>> getCategories() {
    // TODO: implement getCategories
    throw UnimplementedError();
  }

  @override
  Future<Category> getCategory() {
    // TODO: implement getCategory
    throw UnimplementedError();
  }
}