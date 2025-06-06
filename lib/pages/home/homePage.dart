import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:schoolcycle_mobile/business/models/announcement/announcement.dart';

class HomePage extends ConsumerStatefulWidget {
  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> with TickerProviderStateMixin {
  var imageUrl = "http://192.168.35.71:8000/storage";
  int _selectedIndex = 0;
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  late PageController _pageController;
  Timer? _sliderTimer;
  int _currentSliderPage = 0;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: Duration(milliseconds: 1000),
      vsync: this,
    );
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );
    _animationController.forward();
    
    // Initialiser le PageController pour le slider
    _pageController = PageController(initialPage: 0);
    
    // Configurer le timer pour le défilement automatique du slider
    _startSliderTimer();
  }
  
  void _startSliderTimer() {
    _sliderTimer?.cancel();
    _sliderTimer = Timer.periodic(Duration(seconds: 5), (timer) {
      if (_currentSliderPage < _promoSlides.length - 1) {
        _currentSliderPage++;
      } else {
        _currentSliderPage = 0;
      }
      
      if (_pageController.hasClients) {
        _pageController.animateToPage(
          _currentSliderPage,
          duration: Duration(milliseconds: 800),
          curve: Curves.easeInOut,
        );
      }
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    _pageController.dispose();
    _sliderTimer?.cancel();
    super.dispose();
  }

  final List<Map<String, dynamic>> _items = [
    {'icon': Icons.home_outlined, 'label': 'Accueil'},
    {'icon': Icons.search_outlined, 'label': 'Recherche'},
    {'icon': Icons.chat_bubble_outline, 'label': 'Messages'},
    {'icon': Icons.person_outlined, 'label': 'Profil'},
  ];

  final List<Map<String, dynamic>> _categories = [
    {'icon': Icons.menu_book_rounded, 'label': 'Livres', 'gradient': [Color(0xFF667eea), Color(0xFF764ba2)]},
    {'icon': Icons.edit_rounded, 'label': 'Stylos', 'gradient': [Color(0xFF11998e), Color(0xFF38ef7d)]},
    {'icon': Icons.school_rounded, 'label': 'Cartables', 'gradient': [Color(0xFFf093fb), Color(0xFFf5576c)]},
    {'icon': Icons.straighten_rounded, 'label': 'Règles', 'gradient': [Color(0xFF4facfe), Color(0xFF00f2fe)]},
    {'icon': Icons.palette_rounded, 'label': 'Crayons', 'gradient': [Color(0xFFfa709a), Color(0xFFfee140)]},
    {'icon': Icons.backpack_rounded, 'label': "Sac à dos", 'gradient': [Color(0xFFa8edea), Color(0xFFfed6e3)]},
  ];

  final List<Map<String, dynamic>> _promoSlides = [
    {
      'title': 'Rentrée Scolaire',
      'subtitle': 'Jusqu\'à -50% sur les fournitures',
      'gradient': [Color(0xFF667eea), Color(0xFF764ba2)],
      'icon': Icons.school_rounded,
    },
    {
      'title': 'Échange Gratuit',
      'subtitle': 'Trouvez ce dont vous avez besoin',
      'gradient': [Color(0xFF11998e), Color(0xFF38ef7d)],
      'icon': Icons.swap_horiz_rounded,
    },
    {
      'title': 'Dons Solidaires',
      'subtitle': 'Aidez la communauté étudiante',
      'gradient': [Color(0xFFf093fb), Color(0xFFf5576c)],
      'icon': Icons.favorite_rounded,
    },
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  Widget _buildNavItem(int index) {
    final isSelected = index == _selectedIndex;
    final item = _items[index];

    return Expanded(
      child: GestureDetector(
        onTap: () => _onItemTapped(index),
        child: Container(
          height: double.infinity,
          color: Colors.transparent,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: EdgeInsets.all(5),
                decoration: BoxDecoration(
                  color: isSelected ? Color(0xFFFF6B35).withOpacity(0.1) : Colors.transparent,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  item['icon'],
                  color: isSelected ? Color(0xFFFF6B35) : Colors.grey[600],
                  size: 24,
                ),
              ),
              SizedBox(height: 4),
              Text(
                item['label'],
                style: TextStyle(
                  color: isSelected ? Color(0xFFFF6B35) : Colors.grey[600],
                  fontSize: 11,
                  fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeroSection() {
    return Container(
      height: 200,
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: PageView.builder(
        controller: _pageController,
        itemCount: _promoSlides.length,
        onPageChanged: (index) {
          setState(() {
            _currentSliderPage = index;
          });
        },
        itemBuilder: (context, index) {
          final slide = _promoSlides[index];
          return Container(
            margin: EdgeInsets.symmetric(horizontal: 4),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: slide['gradient'],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: slide['gradient'][0].withOpacity(0.3),
                  blurRadius: 15,
                  offset: Offset(0, 8),
                ),
              ],
            ),
            child: Stack(
              children: [
                Positioned(
                  right: -20,
                  top: -20,
                  child: Container(
                    width: 120,
                    height: 120,
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.1),
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        slide['icon'],
                        color: Colors.white,
                        size: 40,
                      ),
                      SizedBox(height: 16),
                      Text(
                        slide['title'],
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 8),
                      Text(
                        slide['subtitle'],
                        style: TextStyle(
                          color: Colors.white.withOpacity(0.9),
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildSliderIndicator() {
    return Container(
      margin: EdgeInsets.only(top: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: List.generate(
          _promoSlides.length,
          (index) => Container(
            width: 8,
            height: 8,
            margin: EdgeInsets.symmetric(horizontal: 4),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: _currentSliderPage == index
                  ? Color(0xFFFF6B35)
                  : Color(0xFFFF6B35).withOpacity(0.3),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSearchBar() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 4),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(25),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 10,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Icon(Icons.search_rounded, color: Color(0xFFFF6B35), size: 24),
          SizedBox(width: 12),
          Expanded(
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Rechercher des fournitures...',
                hintStyle: TextStyle(color: Colors.grey[500], fontSize: 16),
                border: InputBorder.none,
                contentPadding: EdgeInsets.symmetric(vertical: 12),
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Color(0xFFFF6B35).withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(Icons.tune_rounded, color: Color(0xFFFF6B35), size: 20),
          ),
        ],
      ),
    );
  }

  Widget categoryCard(Map<String, dynamic> category) {
    return GestureDetector(
      onTap: () {
        print("Categorie cliqué: ${category['label']}");
      },
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 8),
        child: Column(
          children: [
            Container(
              width: 75,
              height: 75,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: category['gradient'],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: category['gradient'][0].withOpacity(0.3),
                    blurRadius: 8,
                    offset: Offset(0, 4),
                  ),
                ],
              ),
              child: Icon(
                category['icon'],
                color: Colors.white,
                size: 32,
              ),
            ),
            SizedBox(height: 8),
            Text(
              category['label'],
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: Colors.grey[700],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget announcementCard(Announcement announcement) {
    return GestureDetector(
      onTap: () {
      },
      child: Container(
        margin: EdgeInsets.all(8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.15),
              spreadRadius: 0,
              blurRadius: 10,
              offset: Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 3,
              child: Stack(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                    child: Container(
                      width: double.infinity,
                      height: double.infinity,
                      child: Image.network(
                        "${imageUrl}/${announcement.photos?.first.url}",
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return Container(
                            color: Color(0xFFFF6B35).withOpacity(0.1),
                            child: Center(
                              child: Icon(
                                Icons.image_not_supported_rounded,
                                color: Color(0xFFFF6B35),
                                size: 40,
                              ),
                            ),
                          );
                        },
                        loadingBuilder: (context, child, loadingProgress) {
                          if (loadingProgress == null) return child;
                          return Container(
                            color: Colors.grey[100],
                            child: Center(
                              child: CircularProgressIndicator(
                                color: Color(0xFFFF6B35),
                                strokeWidth: 2,
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                  Positioned(
                    top: 12,
                    right: 12,
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                      decoration: BoxDecoration(
                        color: _getTypeColor(announcement.operation_type),
                        borderRadius: BorderRadius.circular(15),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            blurRadius: 4,
                            offset: Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Text(
                        announcement.operation_type == "sale"
                            ? "Vente"
                            : announcement.operation_type == "exchange"
                                ? "Échange"
                                : announcement.operation_type == "don"
                                    ? "Don"
                                    : "Autre",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 11,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 12,
                    right: 12,
                    child: GestureDetector(
                      onTap: () {
                        print('Produit ajouté aux favoris');
                      },
                      child: Container(
                        padding: EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.1),
                              blurRadius: 4,
                              offset: Offset(0, 2),
                            ),
                          ],
                        ),
                        child: Icon(
                          Icons.favorite_border_rounded,
                          color: Colors.red[400],
                          size: 18,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 2,
              child: Padding(
                padding: EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      announcement.title != null 
                      ? (announcement.title!.length > 17 
                          ? '${announcement.title!.substring(0, 15)}...'
                          : announcement.title!)
                      : "Titre indisponible",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        color: Colors.grey[800],
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(height: 8),
                    Row(
                      children: [
                        Icon(Icons.location_on_rounded, 
                             color: Colors.grey[500], size: 14),
                        SizedBox(width: 4),
                        Expanded(
                          child: Text(
                            "Rue de l'école",
                            style: TextStyle(
                              color: Colors.grey[600],
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 4),
                    Text(
                      announcement.price != null ? "${announcement.price}Fc" : "Gratuit",
                      style: TextStyle(
                        color: Color(0xFFFF6B35),
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Color _getTypeColor(String? type) {
    switch (type) {
      case "sale":
        return Color(0xFF4CAF50);
      case "exchange":
        return Color(0xFF2196F3);
      case "donation":
        return Color(0xFFFF9800);
      default:
        return Color(0xFF9E9E9E);
    }
  }


  Widget titreSection(String title, String subtitle, {VoidCallback? onSeeAll}) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w700,
                  color: Colors.grey[800],
                ),
              ),
              if (onSeeAll != null)
                TextButton(
                  onPressed: onSeeAll,
                  child: Text(
                    'Voir tout',
                    style: TextStyle(
                      color: Color(0xFFFF6B35),
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
            ],
          ),
          if (subtitle.isNotEmpty)
            Text(
              subtitle,
              style: TextStyle(
                color: Colors.grey[600],
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(HomeControllerProvider);
    final ctrl = ref.read(HomeControllerProvider.notifier);

    return Scaffold(
      backgroundColor: Color(0xFFFAFAFA),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: Icon(Icons.menu_book_outlined,color: const Color(0xFFFF7F07),),
        title: Text(
          'SchoolCycle',
          style: TextStyle(
            fontWeight: FontWeight.w800,
            color: Color(0xFFFF9000),
            fontSize: 24,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.brightness_4, color: Color(0xFFFF6B35)),
          ),
        ],
      ),
      body: FadeTransition(
        opacity: _fadeAnimation,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 8),
              _buildSearchBar(),
              SizedBox(height: 16),
              _buildHeroSection(),
              _buildSliderIndicator(),
              SizedBox(height: 24),
              
              // Section catégories
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Text(
                  'Catégories',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w700,
                    color: Colors.grey[800],
                  ),
                ),
              ),
              SizedBox(height: 16),
              Container(
                height: 110,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  padding: EdgeInsets.symmetric(horizontal: 8),
                  itemCount: _categories.length,
                  itemBuilder: (context, index) {
                    return categoryCard(_categories[index]);
                  },
                ),
              ),
              
              SizedBox(height: 32),
              
              // Annonces récentes
              titreSection(
                'Annonces Récentes',
                'Découvrez les dernières offres de la communauté',
                onSeeAll: () {
                },
              ),
              SizedBox(height: 16),
              Container(
                height: 320,
                child: GridView.builder(
                  scrollDirection: Axis.horizontal,
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 1,
                    mainAxisSpacing: 16,
                    childAspectRatio: 1.4,
                    mainAxisExtent: 200,
                  ),
                  itemCount: (state.announcements?.length ?? 0).clamp(0, 6),
                  itemBuilder: (context, index) {
                    return announcementCard(state.announcements![index]);
                  },
                ),
              ),
              
              SizedBox(height: 32),
              
              // Suggestions
              titreSection(
                'Suggestions pour vous',
                'Basées sur vos préférences et recherches',
              ),
              SizedBox(height: 16),
              Container(
                height: 320,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  itemCount: state.announcements?.length ?? 0,
                  itemBuilder: (context, index) {
                    return Container(
                      width: 200,
                      margin: EdgeInsets.only(right: 16),
                      child: announcementCard(state.announcements![index]),
                    );
                  },
                ),
              ),
              
              SizedBox(height: 32),
              
              // Ventes
              titreSection(
                'Ventes de Fournitures',
                'Les meilleures offres à petits prix',
                onSeeAll: () {},
              ),
              SizedBox(height: 16),
              Container(
                height: 320,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  itemCount: state.announcements?.length ?? 0,
                  itemBuilder: (context, index) {
                    return Container(
                      width: 200,
                      margin: EdgeInsets.only(right: 16),
                      child: announcementCard(state.announcements![index]),
                    );
                  },
                ),
              ),
              
              SizedBox(height: 32),
              
              // Échanges
              titreSection(
                'Échanges Possibles',
                'Trouvez des personnes pour échanger sans argent',
                onSeeAll: () {},
              ),
              SizedBox(height: 16),
              Container(
                height: 320,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  itemCount: state.announcements?.length ?? 0,
                  itemBuilder: (context, index) {
                    return Container(
                      width: 200,
                      margin: EdgeInsets.only(right: 16),
                      child: announcementCard(state.announcements![index]),
                    );
                  },
                ),
              ),
              
              SizedBox(height: 32),
              
              // Dons
              titreSection(
                'Dons Possibles',
                'Des fournitures offertes par la communauté',
                onSeeAll: () {},
              ),
              SizedBox(height: 16),
              Container(
                height: 320,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  itemCount: state.announcements?.length ?? 0,
                  itemBuilder: (context, index) {
                    return Container(
                      width: 200,
                      margin: EdgeInsets.only(right: 16),
                      child: announcementCard(state.announcements![index]),
                    );
                  },
                ),
              ),
              
              SizedBox(height: 100),
            ],
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFFFF6B35), Color(0xFFFF8E53)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: Color(0xFFFF6B35).withOpacity(0.4),
              blurRadius: 15,
              offset: Offset(0, 8),
            ),
          ],
        ),
        child: FloatingActionButton(
          onPressed: () {
          },
          backgroundColor: Colors.transparent,
          elevation: 0,
          child: Icon(Icons.add_rounded, color: Colors.white, size: 28),
        ),
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(25),
            topRight: Radius.circular(25),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              blurRadius: 20,
              offset: Offset(0, -5),
            ),
          ],
        ),
        child: BottomAppBar(
          shape: CircularNotchedRectangle(),
          color: Colors.transparent,
          elevation: 0,
          child: Container(
            height: 70,
            padding: EdgeInsets.symmetric(horizontal: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildNavItem(0),
                _buildNavItem(1),
                SizedBox(width: 40),
                _buildNavItem(2),
                _buildNavItem(3),
              ],
            ),
          ),
        ),
      ),
    );
  }
}