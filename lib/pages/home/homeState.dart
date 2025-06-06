import 'package:schoolcycle_mobile/business/models/announcement/announcement.dart';
import 'package:schoolcycle_mobile/business/models/category/category.dart';

class Homestate {
  bool isLoading = false;
  String? errorMessage;
  List<Announcement>? announcements;
  List<Category>? categories;

  Homestate({
    this.isLoading = false,
    this.errorMessage,
    this.announcements,
    this.categories,
  });

  // la methode copyWith permet de créer une nouvelle instance de Homestate
  // en copiant les valeurs de l'instance actuelle, mais en permettant de
  // modifier certaines propriétés si nécessaire.
  // Cela est utile pour les mises à jour d'état dans les applications Flutter,
  Homestate copyWith({
    bool? isLoading,
    String? errorMessage,
    List<Announcement>? announcements,
    List<Category>? categories,
  }) {
    return Homestate(
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
      announcements: announcements ?? this.announcements,
      categories: categories ?? this.categories,
    );
  }
}