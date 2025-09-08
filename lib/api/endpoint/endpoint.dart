class Endpoint {
  static const String baseUrl = "https://appbioskop.mobileprojp.com/api";

  // Auth endpoints
  static const String register = "$baseUrl/register";
  static const String login = "$baseUrl/login";
  static const String profile = "$baseUrl/profile";
  static const String logout = "$baseUrl/logout";

  // Movie endpoints (dari Postman)
  static const String movies = "$baseUrl/films"; // List Film
  static const String movieDetail = "$baseUrl/films/"; // Detail Film + ID
  static const String addMovie = "$baseUrl/films"; // Tambah Film (POST)
  static const String updateMovie = "$baseUrl/films/"; // Update Film + ID (PUT)
  static const String deleteMovie =
      "$baseUrl/films/"; // Delete Film + ID (DELETE)

  // Cinema endpoints
  static const String cinemas = "$baseUrl/cinemas"; // GET Cinemas
  static const String addCinema = "$baseUrl/cinemas"; // Tambah Cinemas (POST)
  static const String updateCinema =
      "$baseUrl/cinemas/"; // Update Cinemas + ID (PUT)
  static const String deleteCinema =
      "$baseUrl/cinemas/"; // Delete Cinemas + ID (DELETE)

  // Schedule endpoints
  static const String schedules = "$baseUrl/schedules"; // List Jadwal Film
  static const String addSchedule =
      "$baseUrl/schedules"; // Tambah Jadwal Film (POST)

  // Booking endpoints
  static const String bookTicket = "$baseUrl/bookings"; // Pesan Tiket (POST)
  static const String myTickets = "$baseUrl/bookings"; // Tiket Saya (GET)
}
