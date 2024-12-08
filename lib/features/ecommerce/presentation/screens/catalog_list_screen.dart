import 'package:flutter/material.dart';

class CatalogListScreen extends StatelessWidget {
  CatalogListScreen({super.key});
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {

    // Lista de productos hardcodeada
    final List<Map<String, String>> products = [
      {'name': 'Producto 1', 'image': 'https://via.placeholder.com/150'},
      {'name': 'Producto 2', 'image': 'https://via.placeholder.com/150'},
      {'name': 'Producto 3', 'image': 'https://via.placeholder.com/150'},
      {'name': 'Producto 4', 'image': 'https://via.placeholder.com/150'},
      {'name': 'Producto 5', 'image': 'https://via.placeholder.com/150'},
      {'name': 'Producto 6', 'image': 'https://via.placeholder.com/150'},
    ];

    return DefaultTabController(
      length: 20,
      child: Scaffold(
        key: _scaffoldKey,
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(170),
          child: AppBar(
            backgroundColor: Theme.of(context).colorScheme.primaryContainer,
            automaticallyImplyLeading: false,
            bottom: TabBar(
                isScrollable: true,
                tabs: [
                  Tab(text: "Smartphone"),
                  Tab(text: "Tablets"),
                  Tab(text: "Laptos"),
                  Tab(text: "Laptos"),
                  Tab(text: "Laptos"),
                  Tab(text: "Laptos"),
                  Tab(text: "Laptos"),
                  Tab(text: "Laptos"),
                  Tab(text: "Laptos"),
                  Tab(text: "Laptos"),
                ]
            ),
            flexibleSpace: Column(
              children: [
                SizedBox(height: 16),
                _widgetMenuDrawer(),
                SizedBox(height: 16),
                _widgetTextfieldSearch()
              ],
            ),
          ),
        ),
        drawer: _widgetDrawer(context),
        body: TabBarView(
              children: [
                // Primer Tab: Grid de productos
                GridView.builder(
                  padding: const EdgeInsets.all(16),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2, // Número de columnas
                    crossAxisSpacing: 16, // Espaciado horizontal
                    mainAxisSpacing: 16, // Espaciado vertical
                    childAspectRatio: 0.8, // Relación de aspecto para cada celda
                  ),
                  itemCount: products.length,
                  itemBuilder: (context, index) {
                    final product = products[index];
                    return _widgetItemProduct(product);
                  },
                ),
              ]),
      ),
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

  Widget _widgetMenuDrawer() {
    return GestureDetector(
      //onTap: _con.openDrawer,
      child: Container(
        //margin: EdgeInsets.only(left: 16),
        alignment: Alignment.centerLeft,
        child: IconButton(onPressed: _openDrawer, icon: Icon(Icons.menu)),
        //child: Image.asset('assets/img/menu.png', width: 20, height: 20),
      ),
    );
  }

  Widget _widgetTextfieldSearch() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20),
      child: TextField(
        //onChanged: _con.onChangeText,
        decoration: InputDecoration(
            hintText: 'Buscar',
            suffixIcon: Icon(
                Icons.search,
                color: Colors.grey[400]
            ),
            hintStyle: TextStyle(
                fontSize: 17,
                color: Colors.grey[500]
            ),
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(25),
                borderSide: BorderSide(
                    //color: Colors.grey[300]
                )
            ),
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(25),
                borderSide: BorderSide(
                   // color: Colors.grey[300]
                )
            ),
            contentPadding: EdgeInsets.all(15)
        ),
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
                    CircleAvatar(
                      radius: 30,
                      backgroundImage: AssetImage('assets/images/profile.jpg'),
                    ),
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
              //Navigator.pushReplacementNamed(context, '/login');
            },
            child: Text('Cerrar sesión'),
          ),
        ],
      ),
    );
  }
}
