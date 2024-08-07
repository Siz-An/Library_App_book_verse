// import 'package:flutter/material.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import '../../../../../../utils/constants/sizes.dart';
// import '../../features/home/screens/user/home/widget/bookList_Screen.dart';
//
// class CourseGradesScreen extends StatelessWidget {
//   final String course;
//
//   const CourseGradesScreen({Key? key, required this.course}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text('Grades for $course')),
//       body: StreamBuilder<QuerySnapshot>(
//         stream: FirebaseFirestore.instance
//             .collection('books')
//             .where('isCourseBook', isEqualTo: true)
//             .where('course', isEqualTo: course)
//             .snapshots(),
//         builder: (context, snapshot) {
//           if (!snapshot.hasData) {
//             return const Center(child: CircularProgressIndicator());
//           }
//
//           final books = snapshot.data!.docs;
//
//           // Debugging print statements
//           print('Course filter: $course');
//           print('Books found: ${books.length}');
//
//           if (books.isEmpty) {
//             return Center(child: Text('No books found for this course.'));
//           }
//
//           final grades = books.map((book) => book['grade']).toSet().toList();
//
//           return ListView.separated(
//             itemCount: grades.length,
//             separatorBuilder: (context, index) => Divider(),
//             itemBuilder: (context, index) {
//               final grade = grades[index];
//               return GestureDetector(
//                 onTap: () {
//                   Navigator.push(
//                     context,
//                     MaterialPageRoute(
//                       builder: (context) => BookListScreen(
//                         isCourseBook: true,
//                         filter: grade,
//                       ),
//                     ),
//                   );
//                 },
//                 child: ListTile(
//                   contentPadding: EdgeInsets.all(TSizes.sm),
//                   tileColor: Colors.grey[200],
//                   shape: RoundedRectangleBorder(
//                     side: BorderSide(color: Colors.black, width: 2),
//                     borderRadius: BorderRadius.circular(8),
//                   ),
//                   title: Center(
//                     child: Text(
//                       grade,
//                       style: TextStyle(
//                         fontWeight: FontWeight.bold,
//                       ),
//                       textAlign: TextAlign.center,
//                     ),
//                   ),
//                 ),
//               );
//             },
//           );
//         },
//       ),
//     );
//   }
// }
