import 'package:flutter/material.dart';
import 'package:tixclick/models/movie_model.dart';
import 'package:tixclick/services/api_service.dart';
import 'package:tixclick/widgets/movie_card.dart';
import 'package:tixclick/screens/movie_detail_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Future<List<Movie>> futureMovies;
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    futureMovies = ApiService.getMovies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('TixClick'),
        backgroundColor: const Color(0xFF0F1B2B),
        elevation: 0,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Search movies...',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
              onChanged: (value) {
                setState(() {});
              },
            ),
          ),
          Expanded(
            child: FutureBuilder<List<Movie>>(
              future: futureMovies,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else if (snapshot.hasData) {
                  final movies = snapshot.data!;
                  final filteredMovies = movies.where((movie) {
                    final query = _searchController.text.toLowerCase();
                    return movie.title.toLowerCase().contains(query) ||
                        movie.genre.toLowerCase().contains(query);
                  }).toList();

                  if (filteredMovies.isEmpty) {
                    return const Center(child: Text('No movies found'));
                  }

                  return GridView.builder(
                    padding: const EdgeInsets.all(8.0),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 10,
                          mainAxisSpacing: 10,
                          childAspectRatio: 0.7,
                        ),
                    itemCount: filteredMovies.length,
                    itemBuilder: (context, index) {
                      return MovieCard(
                        movie: filteredMovies[index],
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => MovieDetailScreen(
                                movie: filteredMovies[index],
                              ),
                            ),
                          );
                        },
                      );
                    },
                  );
                } else {
                  return const Center(child: Text('No movies available'));
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
