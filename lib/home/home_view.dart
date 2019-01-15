// Created by Tau on 2019/1/1
import 'package:flutter/material.dart';
import 'package:uestc/course/course_view.dart';
import 'package:uestc/theme.dart';
import 'package:flutter/services.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light.copyWith(
      statusBarColor: Colors.transparent,
    ));
    return HomeView();
  }
}

class HomeView extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => HomeViewState();
}

class _Item {
  final String title;
  final IconData icon;
  final int id;

  _Item(this.title, this.id, this.icon);
}

class HomeViewState extends State<HomeView> {
  String _title = 'Course';
  int _seletedId = 0;

  final items = <_Item>[
    _Item('Course', 0, Icons.date_range),
    _Item('Exam', 1, Icons.local_library),
    _Item('Grade', 2, Icons.description)
  ];

//  final GlobalKey<Drawer> drawerKey = GlobalKey<Drawer>();

  @override
  Widget build(BuildContext context) {
    final statusBarHeight = MediaQuery.of(context).padding.top;
    return Scaffold(
      appBar: _buildAppBar(statusBarHeight),
      drawer: Drawer(
        child: _buildDrawer(),
      ),
      body: CourseTable(),
    );
  }

  ListView _buildDrawer() {
    return ListView(
      children: <Widget>[
        _buildHeader(),
        _buildItem(items[0]),
        _buildItem(items[1]),
        _buildItem(items[2]),
      ],
    );
  }

  Padding _buildItem(_Item item) {
    return Padding(
      padding: const EdgeInsets.only(right: 20.0, top: 4, bottom: 4),
      child: Material(
        child: Ink(
          height: 50,
          child: InkWell(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(left: 20, right: 8),
                  child: Icon(
                    item.icon,
                    size: 20,
                    color: _seletedId == item.id
                        ? Colors.black87
                        : Colors.black54,
                  ),
                ),
                Text(
                  item.title,
                  style:  TextStyle(
                      color: _seletedId == item.id
                          ? Colors.black87
                          : Colors.black54,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 1),
                ),
              ],
            ),
            onTap: () {
              setState(() => _seletedId = item.id);
              Navigator.of(context).pop();
            },
            borderRadius: BorderRadius.horizontal(right: Radius.circular(50.0)),
          ),
          decoration: BoxDecoration(
              border: Border.all(
                color: _seletedId == item.id
                    ? Colors.grey[400]
                    : Colors.transparent,
                width: 1.2,
              ),
              borderRadius:
                  BorderRadius.horizontal(right: Radius.circular(50.0))),
        ),
      ),
    );
  }

  Padding _buildHeader() {
    return Padding(
      padding: const EdgeInsets.only(right: 20.0, top: 20, bottom: 20),
      child: Container(
        height: 100,
        padding: const EdgeInsets.only(left: 20),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey[500]),
          borderRadius: BorderRadius.horizontal(right: Radius.circular(5.0)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Text('杨韬', style: TextStyles.HeaderTitle), //TODO:
            Text('2017020902022', style: TextStyles.HeaderInfo),
          ],
        ),
      ),
    );
  }

  AppBar _buildAppBar(double statusBarHeight) {
    return AppBar(
      backgroundColor: Colors.transparent,
      title: Text('$_title', style: TextStyles.AppbarTitle),
      centerTitle: true,
      brightness: Brightness.light,
      iconTheme: IconThemeData(color: Colors.black87),
      elevation: 0,
      flexibleSpace: Padding(
        padding: EdgeInsets.only(left: 8.0, right: 8.0, top: statusBarHeight),
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey[500]),
            borderRadius: BorderRadius.all(Radius.circular(5.0)),
          ),
        ),
      ),
    );
  }
}
