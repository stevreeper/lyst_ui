import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lystui/models/category.model.dart';
import 'package:lystui/models/screenRoute.model.dart';
import 'package:lystui/providers/category.provider.dart';
import 'package:lystui/widgets/backgroundImage.dart';
import 'package:provider/provider.dart';

class SettingsScreen extends ScreenRoute {
  SettingsScreen() : super('/');

  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  final refreshKey = GlobalKey<RefreshIndicatorState>();

  @override
  void initState() {
    super.initState();
    refreshCategories();
  }

  @override
  void dispose() {
    refreshKey.currentState?.dispose();
    super.dispose();
  }

  Future<void> refreshCategories() async {
    refreshKey.currentState?.show(atTop: false);

    await Provider.of<CategoryProvider>(context, listen: false)
        .doUpdateCategories();
  }

  void _onManagePress() {}

  void _onAboutUsTap() {}

  Future<void> _onLogoutTap() {}

  Widget _buildCategories(List<Category> categories) {
    return RefreshIndicator(
      backgroundColor: Theme.of(context).primaryColor,
      color: Colors.white,
      key: refreshKey,
      onRefresh: refreshCategories,
      child: ListView.builder(
        padding: EdgeInsets.symmetric(horizontal: 4, vertical: 16),
        itemCount: categories.length,
        itemBuilder: (context, i) {
          if (i.isOdd) return Divider(color: Colors.transparent);

          final index = i ~/ 2;
          return _buildRow(categories[index]);
        },
      ),
    );
  }

  Widget _buildRow(Category category) {
    return ListTile(
      leading: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          height: 15,
          width: 15,
          decoration: BoxDecoration(
            color: Color(category.color),
            shape: BoxShape.circle,
          ),
        ),
      ),
      title: Text(
        category.title,
        style: TextStyle(
          color: Colors.white,
          fontSize: 20,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final categoriesProvider = Provider.of<CategoryProvider>(context);

    return BackgroundImage(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          title: Image.asset(
            'lib/assets/logo.png',
            width: 100,
          ),
          centerTitle: true,
          backgroundColor: Color(0xFF848484).withOpacity(0.1),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              SizedBox(
                height: 320,
                child: _buildCategories(categoriesProvider.categories),
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: 250,
                child: RaisedButton(
                  child: Text(
                    'MANAGE CATEGORIES',
                  ),
                  onPressed: _onManagePress,
                ),
              ),
              const SizedBox(height: 10),
              SizedBox(
                width: 320,
                child: Divider(color: Theme.of(context).primaryColor),
              ),
              const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: Column(
                  children: <Widget>[
                    InkWell(
                      splashColor: Theme.of(context).primaryColor,
                      highlightColor: Theme.of(context).primaryColorLight,
                      onTap: _onAboutUsTap,
                      child: Row(
                        children: <Widget>[
                          Icon(
                            Icons.info_outline,
                            color: Theme.of(context).primaryColor,
                          ),
                          const SizedBox(width: 10),
                          Text(
                            'About us',
                            style: TextStyle(color: Colors.white, fontSize: 20),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                    InkWell(
                      splashColor: Colors.red,
                      highlightColor: Colors.redAccent,
                      onTap: _onLogoutTap,
                      child: Row(
                        children: <Widget>[
                          Icon(
                            Icons.exit_to_app,
                            color: Colors.red,
                          ),
                          const SizedBox(width: 10),
                          Text(
                            'Logout',
                            style: TextStyle(color: Colors.white, fontSize: 20),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
