
class Movie {

  String movieName;
  String imageUrl;
  bool trending;
  Movie({
    this.movieName,
    this.imageUrl,
    this.trending,
  });
 // Movie(this.movieName, this.imageUrl);

 static final List<Movie> movieData = [
    Movie(
      movieName:'Black Panther' ,
      imageUrl:'https://m.media-amazon.com/images/M/MV5BMTg1MTY2MjYzNV5BMl5BanBnXkFtZTgwMTc4NTMwNDI@._V1_UX182_CR0,0,182,268_AL_.jpg',
      trending: true,
    ),
   Movie(
       movieName:  'Ugly Dolls'  ,
       imageUrl: 'https://m.media-amazon.com/images/M/MV5BMTc0NjE2ODM2OV5BMl5BanBnXkFtZTgwMjQyNDUzNzM@._V1_UX182_CR0,0,182,268_AL_.jpg',
     trending: true,
   ),
   Movie(
       movieName:'Friend Zone' ,
       imageUrl: 'https://i.mydramalist.com/00R8kc.jpg',
     trending: true,
   ),
   Movie(
       movieName:'Advenger End Game' ,
       imageUrl:'https://upload.wikimedia.org/wikipedia/en/0/0d/Avengers_Endgame_poster.jpg',
        trending: true,
   ),
   Movie(
     movieName: 'Friend Zone',
     imageUrl: 'https://i.mydramalist.com/00R8kc.jpg',
     trending: false,
   ),
   Movie(
     movieName: 'Mr. Hurt',
     imageUrl: 'https://i.mydramalist.com/bO5yjc.jpg',
     trending: false,
   ),
   Movie(
     movieName: 'Hotel Transylvania 3',
     imageUrl: 'https://m.media-amazon.com/images/M/MV5BNjA1MzU5MTY3OF5BMl5BanBnXkFtZTgwNTU5MDA3NTM@._V1_UX182_CR0,0,182,268_AL_.jpg',
     trending: false,
   ),
   Movie(
     movieName: 'Crime of Grand',
     imageUrl: 'https://m.media-amazon.com/images/M/MV5BZjFiMGUzMTAtNDAwMC00ZjRhLTk0OTUtMmJiMzM5ZmVjODQxXkEyXkFqcGdeQXVyMDM2NDM2MQ@@._V1_UX182_CR0,0,182,268_AL_.jpg',
     trending: false,
   ),
   Movie(
       movieName:'Toy Story 4' ,
       imageUrl:'https://upload.wikimedia.org/wikipedia/en/4/4c/Toy_Story_4_poster.jpg',
      trending: true,
   ),
   Movie(
     movieName:'Maze Runner',
     imageUrl:  'https://m.media-amazon.com/images/M/MV5BMTYyNzk3MDc2NF5BMl5BanBnXkFtZTgwMDk3OTM1NDM@._V1_UX182_CR0,0,182,268_AL_.jpg',
     trending: true,
   ),
 ];

  static final List<Movie> KoreaMovies = [
    Movie(
      movieName:'Welcome To Life' ,
      imageUrl: 'http://asianwiki.com/images/2/24/Welcome_2_Life-tp1.jpg',
      trending: true,
    ),
    Movie(
     movieName:'Class of Lie',
     imageUrl:  'http://asianwiki.com/images/2/26/Class_of_Lies-P1.jpg',
      trending: true,
    ),
    Movie(
      movieName:'Doctor John' ,
      imageUrl: 'http://asianwiki.com/images/a/ab/Doctor_John-P1.jpg',
      trending: true,
    ),
    Movie(
        movieName:'Justic' ,
        imageUrl:'http://asianwiki.com/images/7/75/Justice-KD-p01.jpg' ,
      trending: true,
    ),
    Movie(
      movieName: "The Untamed",
      imageUrl: 'https://wiki.d-addicts.com/images/thumb/1/15/Theuntamed.jpeg/300px-Theuntamed.jpeg',
      trending: true,
    ),
    Movie(
      movieName:'Hwarang' ,
      imageUrl: 'http://asianwiki.com/images/3/38/Hwarang-sp.jpg',
      trending: false,
    ),
    Movie(
      movieName: 'Hotel Deluna',
      imageUrl: 'http://asianwiki.com/images/4/4c/Hotel_Del_Luna-GP.jpg',
      trending: true,
    ),
    Movie(
      movieName: 'Voice 3',
      imageUrl: 'http://asianwiki.com/images/2/29/Voice_3-p003.jpg',
      trending: false,
    ),
    Movie(
      movieName: 'Abyss',
      imageUrl: 'http://asianwiki.com/images/5/5a/Abyss_%28Korean_Drama%29-p01.jpg',
      trending: false,
    ),
    Movie(
      movieName: 'Search: WWW',
      imageUrl: 'http://asianwiki.com/images/a/ad/Search-_WWW-TP.jpg',
      trending: false,
    ),
    Movie(
      movieName: 'Arthel Chronicles',
      imageUrl: 'http://asianwiki.com/images/9/90/Arthdal_Chronicles-P01.jpg',
      trending: false,
    ),
    Movie(
      movieName: 'The Crowned Clown',
      imageUrl: 'http://asianwiki.com/images/4/4f/The_Crowned_Clown-p001.jpg',
      trending: false,
    ),


  ];
}