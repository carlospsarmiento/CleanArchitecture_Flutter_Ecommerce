import 'package:app_flutter/core/routes/app_routes.dart';
import 'package:app_flutter/features/ecommerce/presentation/screens/client/home/widgets/categories_list_widget.dart';
import 'package:app_flutter/features/ecommerce/presentation/screens/client/home/widgets/featured_products_list_widget.dart';
import 'package:app_flutter/features/ecommerce/presentation/screens/client/home/widgets/special_offers_list_widget.dart';
import 'package:app_flutter/features/ecommerce/presentation/screens/client/home/widgets/user_avatar_widget.dart';
import 'package:app_flutter/shared/presentation/bloc/auth_cubit.dart';
import 'package:app_flutter/shared/presentation/bloc/auth_state.dart';
import 'package:app_flutter/shared/presentation/widgets/custom_progress_dialog.dart';
import 'package:app_flutter/shared/presentation/widgets/custom_snackbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ClientHomeScreen extends StatefulWidget {
  const ClientHomeScreen({super.key});

  @override
  State<ClientHomeScreen> createState() => _ClientHomeScreenState();
}

class _ClientHomeScreenState extends State<ClientHomeScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      drawer: _widgetDrawer(context),
      body: BlocListener<AuthCubit, AuthState>(
        listener: (context, state) => _listenAuthCubit(context, state),
        child: SafeArea(
          child: IndexedStack(
            index: _selectedIndex,
            children: [
              // Home Page
              SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 16),
                      _headerSection(context),
                      SizedBox(height: 16),
                      _searchSection(context),
                      SizedBox(height: 16),
                      CategoriesListWidget(),
                      SizedBox(height: 16),
                      SpecialOffersListWidget(),
                      SizedBox(height: 16),
                      //_featuredProductsSection(context),
                      FeaturedProductsListWidget(),
                      SizedBox(height: 16),
                      _popularProductsSection(context),
                      SizedBox(height: 16),
                    ],
                  ),
                ),
              ),
              // Categories Page
              Center(child: Text('Categorías')),
              // Cart Page
              Center(child: Text('Carrito')),
              // Profile Page
              Center(child: Text('Perfil')),
            ],
          ),
        ),
      ),
      bottomNavigationBar: NavigationBar(
        onDestinationSelected: (int index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        selectedIndex: _selectedIndex,
        destinations: const <NavigationDestination>[
          NavigationDestination(
            selectedIcon: Icon(Icons.home),
            icon: Icon(Icons.home_outlined),
            label: 'Inicio',
          ),
          NavigationDestination(
            selectedIcon: Icon(Icons.category),
            icon: Icon(Icons.category_outlined),
            label: 'Categorías',
          ),
          NavigationDestination(
            selectedIcon: Icon(Icons.shopping_cart),
            icon: Icon(Icons.shopping_cart_outlined),
            label: 'Carrito',
          ),
          NavigationDestination(
            selectedIcon: Icon(Icons.person),
            icon: Icon(Icons.person_outline),
            label: 'Perfil',
          ),
        ],
      ),
    );
  }

  Widget _searchSection(BuildContext context){
    return TextField(
        decoration: InputDecoration(
          filled: true,
          fillColor: Theme.of(context).colorScheme.surfaceContainer,
          hintText: 'Buscar productos...',
          hintStyle: TextStyle(
            color: Theme.of(context).colorScheme.onSurfaceVariant,
          ),
          prefixIcon: Icon(
            Icons.search,
            color: Theme.of(context).colorScheme.onSurfaceVariant,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
          contentPadding: const EdgeInsets.symmetric(vertical: 12),
        ),
        onChanged: (value) {
          print('Buscando: $value');
        },
    );
  }

  Widget _headerSection(BuildContext context){
    return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          UserAvatarWidget(
            onTap: _openDrawer,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'Ubicación actual',
                  style: Theme.of(context).textTheme.labelMedium?.copyWith(
                    color: Theme.of(context).colorScheme.onSurface,
                  ),
                ),
                Text(
                  'Lima, Perú',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
              ],
            ),
          ),
          IconButton(
            onPressed: () {
            },
            icon: Icon(
              Icons.shopping_cart_outlined,
              color: Theme.of(context).colorScheme.onSurface,
            ),
          ),
        ],
    );
  }

  void _listenAuthCubit(BuildContext context, AuthState state){
    if(state is AuthLogoutLoadingState){
      showDialog(
          context: context,
          barrierDismissible: false,
          builder: (BuildContext context) => CustomProgressDialog(message: "Cerrando sesión...")
      );
    }

    if (state is AuthLogoutSuccessState) {
      Navigator.of(context).pop();
      Navigator.pushNamedAndRemoveUntil(context, AppRoutes.login, (route) => false);
    }

    if (state is AuthLogoutFailState) {
      Navigator.of(context).pop();
      CustomSnackBar.show(context, message: state.message);
    }
  }

  Widget _featuredProductsSection(BuildContext context) {
    final List<Map<String, dynamic>> featuredProducts = [
      {
        'name': 'Samsung Galaxy S23',
        'price': 999.99,
        'image': 'https://images.samsung.com/is/image/samsung/p6pim/latin/2302/gallery/latin-galaxy-s23-s911-sm-s911bzgcgto-534848032'
      },
      {
        'name': 'MacBook Air M2',
        'price': 1299.99,
        'image': 'https://store.storeimages.cdn-apple.com/4982/as-images.apple.com/is/macbook-air-midnight-select-20220606?wid=452&hei=420&fmt=jpeg&qlt=95'
      },
      {
        'name': 'PlayStation 5',
        'price': 499.99,
        'image': 'https://gmedia.playstation.com/is/image/SIEPDC/ps5-product-thumbnail-01-en-14sep21'
      },
      {
        'name': 'AirPods Pro',
        'price': 249.99,
        'image': 'https://store.storeimages.cdn-apple.com/4982/as-images.apple.com/is/MQD83?wid=572&hei=572&fmt=jpeg'
      },
      {
        'name': 'iPad Air',
        'price': 599.99,
        'image': 'https://store.storeimages.cdn-apple.com/4982/as-images.apple.com/is/ipad-air-select-wifi-blue-202203'
      },
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Productos Destacados',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            TextButton(
              onPressed: () {},
              child: Text('Ver todo'),
            ),
          ],
        ),
        SizedBox(height: 12),
        Container(
          height: 220,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: featuredProducts.length,
            itemBuilder: (context, index) {
              final product = featuredProducts[index];
              return Container(
                width: 160,
                margin: EdgeInsets.only(right: 16),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: Theme.of(context).colorScheme.surface,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 8,
                      offset: Offset(0, 2),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
                      child: Image.network(
                        product['image'],
                        height: 120,
                        width: double.infinity,
                        fit: BoxFit.cover,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            product['name'],
                            style: Theme.of(context).textTheme.titleMedium,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                          SizedBox(height: 4),
                          Text(
                            '\$${product['price']}',
                            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                              color: Theme.of(context).colorScheme.primary,
                              fontWeight: FontWeight.bold,
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
        ),
      ],
    );
  }

  Widget _popularProductsSection(BuildContext context) {
    final List<Map<String, dynamic>> popularProducts = [
      {
        'name': 'Nike Air Max 270',
        'price': 149.99,
        'image': 'https://static.nike.com/a/images/t_PDP_1280_v1/f_auto,q_auto:eco/skwgyqrbfzhu6uyeh0gg/air-max-270-shoes-2V5C4p.png'
      },
      {
        'name': 'Apple Watch Series 8',
        'price': 399.99,
        'image': 'https://store.storeimages.cdn-apple.com/4982/as-images.apple.com/is/MKUQ3_VW_34FR+watch-45-alum-midnight-nc-8s_VW_34FR_WF_CO'
      },
      {
        'name': 'Sony WH-1000XM4',
        'price': 349.99,
        'image': 'https://www.sony.com/image/5d02da5df552836db894cead8a68f5f3'
      },
      {
        'name': 'Nintendo Switch OLED',
        'price': 349.99,
        'image': 'https://assets.nintendo.com/content/dam/ncom/en_US/switch/site-design-update/hardware/switch/nintendo-switch-oled-model-white-set/gallery/image01'
      },
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Más Populares',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            TextButton(
              onPressed: () {},
              child: Text('Ver todo'),
            ),
          ],
        ),
        SizedBox(height: 12),
        GridView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 0.75,
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
          ),
          itemCount: popularProducts.length,
          itemBuilder: (context, index) {
            final product = popularProducts[index];
            return Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: Theme.of(context).colorScheme.surface,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 8,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
                    child: Image.network(
                      product['image'],
                      height: 160,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          product['name'],
                          style: Theme.of(context).textTheme.titleMedium,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        SizedBox(height: 4),
                        Text(
                          '\$${product['price']}',
                          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            color: Theme.of(context).colorScheme.primary,
                            fontWeight: FontWeight.bold,
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
      ],
    );
  }

  Widget _widgetItemProduct(Map<String, String> product){
    return Card(
      //elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: ClipRRect(
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(10),
              ),
              child: Image.network(
                product['image']!,
                fit: BoxFit.cover,
                width: double.infinity,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              product['name']!,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }

  Widget _widgetDrawer(BuildContext context){
    return Drawer(
      child: Column(
        children: [
          DrawerHeader(
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primaryContainer,
              ),
              child: SizedBox.expand(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    /*
                    CircleAvatar(
                      radius: 30,
                      backgroundImage: AssetImage('assets/images/profile.jpg'),
                    ),
                     */
                    SizedBox(height: 10),
                    Text(
                      'Usuario Demo',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        color: Theme.of(context).colorScheme.onPrimaryContainer,
                      ),
                    ),
                    Text(
                      'demo@correo.com',
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: Theme.of(context).colorScheme.onPrimaryContainer,
                      ),
                    ),
                  ],
                ),
              )
          ),
          ListTile(
            leading: Icon(
              Icons.logout_outlined,
              //color: Theme.of(context).colorScheme.error,
            ),
            title: Text(
              'Cerrar sesión',
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
               // color: Theme.of(context).colorScheme.error,
              ),
            ),
            onTap: () {
              Navigator.pop(context);
              _showLogoutDialog(context);
            },
          ),
        ],
      ),
    );
  }

  void _openDrawer() {
    _scaffoldKey.currentState?.openDrawer();
  }

  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(
          'Cerrar sesión',
          style: Theme.of(context).textTheme.titleLarge,
        ),
        content: Text(
          '¿Estás seguro de que deseas cerrar sesión?',
          style: Theme.of(context).textTheme.bodyMedium,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Cancelar'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              context.read<AuthCubit>().logout();
            },
            child: Text('Cerrar sesión'),
          ),
        ],
      ),
    );
  }
}
