import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:carousel_slider/carousel_slider.dart';

import '../common/widgets/texts/section_heading.dart';

class TPopularBooks extends StatefulWidget {
  const TPopularBooks({super.key});

  @override
  _TPopularBooksState createState() => _TPopularBooksState();
}

class _TPopularBooksState extends State<TPopularBooks> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  List<Map<String, dynamic>> _bookmarkedBooks = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchBookmarkedBooks();
  }

  Future<void> _fetchBookmarkedBooks() async {
    try {
      final querySnapshot = await _firestore.collection('bookmarks').get();
      final Map<String, Set<String>> userBookmarks = {};

      for (var doc in querySnapshot.docs) {
        final data = doc.data();
        final userId = data['userId'];
        final bookId = data['bookId'];

        userBookmarks.putIfAbsent(userId, () => {}).add(bookId);
      }

      // Find common bookmarks among users
      List<String> commonBookmarks;
      if (userBookmarks.length == 1) {
        commonBookmarks = userBookmarks.values.first.toList();
      } else {
        final commonSet = userBookmarks.values
            .reduce((a, b) => a.intersection(b));
        commonBookmarks = commonSet.toList();
      }

      // Fetch book details concurrently
      final List<Map<String, dynamic>> bookDetails = await Future.wait(
        commonBookmarks.map((bookId) async {
          final bookDoc = await _firestore.collection('books').doc(bookId).get();
          return bookDoc.data()!;
        }),
      );

      setState(() {
        _bookmarkedBooks = bookDetails;
      });
    } catch (e) {
      print('Error fetching bookmarks: $e');
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TSectionHeading(
          title: 'Popular Books',
          onPressed: () {
            // Handle view all button press
          },
        ),
        SizedBox(height: 10),
        _isLoading
            ? const Center(child: CircularProgressIndicator())
            : _bookmarkedBooks.isEmpty
            ? Center(child: Text('No popular books found.'))
            : SizedBox(
          height: 300, // Set a fixed height for the carousel
          child: CarouselSlider.builder(
            itemCount: _bookmarkedBooks.length,
            itemBuilder: (context, index, realIndex) {
              final book = _bookmarkedBooks[index];
              final imageUrl = book['imageUrl']; // Ensure 'imageUrl' key exists
              final title = book['title'];
              final writer = book['writer'];

              return Container(
                margin: EdgeInsets.symmetric(horizontal: 5),
                child: Column(
                  mainAxisSize: MainAxisSize.min, // Make Column size flexible
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Image.network(
                        imageUrl,
                        width: 150,
                        height: 200,
                        fit: BoxFit.cover,
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      title,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 5),
                    Text(
                      writer,
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 14,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              );
            },
            options: CarouselOptions(
              height: 300,
              viewportFraction: 0.5, // Show two items side by side
              enlargeCenterPage: false, // Ensure items are not enlarged
              aspectRatio: 2.0,
              autoPlay: false, // Set to true if you want auto-slide
              enableInfiniteScroll: true, // Allow infinite scrolling
            ),
          ),
        ),
      ],
    );
  }
}
