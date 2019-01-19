// Created by Tau on 2019/1/19
import 'profile.dart';

//typedef Semesters  List<List<String>>;

Future<List<Semester>> fetchSemesters() async {
  final user = await fetchProfile();
  if (user == null) return [];
  final enrollDate = DateTime.parse(user.enrollDate);
  //8-1 fall
  //2-7 spring
  final now = DateTime.now();
  final semesters = <Semester>[];
  int year = enrollDate.year;
  if (enrollDate.month < 8) semesters.add(Semester(year - 1, 2));
  semesters.add(Semester(year, 1));
  year++;
  while (year < now.year) {
    semesters.add(Semester(year - 1, 2));
    semesters.add(Semester(year, 1));
    year++;
  }
  if (now.month > 1) semesters.add(Semester(year - 1, 2));
  if (now.month > 7) semesters.add(Semester(year, 1));
  print(semesters);
  return semesters;
}

class Semester {
  Semester(int year, int semester)
      : this.year = year,
        this.semester = semester;

  get json => {'year': year.toString(), 'semester': semester.toString()};
  final int year;
  final int semester;

  static Semester get now {
    final now = DateTime.now();
    if (now.month <= 1) return Semester(now.year - 1, 1);
    if (now.month < 8)
      return Semester(now.year - 1, 2);
    else
      return Semester(now.year, 1);
  }

  @override
  String toString() {
    if (semester == 1)
      return '$year fall';
    else
      return '${year - 1} spring';
  }

  @override
  bool operator ==(other) {
    return year == other.year && semester == other.semester;
  }
}
