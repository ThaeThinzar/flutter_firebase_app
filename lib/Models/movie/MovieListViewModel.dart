

import 'Movie.dart';
import 'MovieViewModel.dart';

class MovieListViewModel {


  List<Movie> movieLists ;
  List<MovieViewModel> movieViewModels = new List();
  List<MovieViewModel> TrendingViewModels = new List();

  MovieListViewModel(String title){

    this.movieViewModels = movieViewModels;
    if(title.toString() == "Korea"){
      this.movieLists = Movie.KoreaMovies;
    } else {
      this.movieLists = Movie.movieData;
    }

    if(movieLists!=null) {
      for(int index =0 ; index < movieLists.length; index++) {
        if(movieLists[index].trending == true){
          TrendingViewModels.add(new MovieViewModel(movie: movieLists[index]));
        }
        else{
          movieViewModels.add(new MovieViewModel(movie: movieLists[index]));
        }
      }
    }
  }
}