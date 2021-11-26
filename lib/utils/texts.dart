import 'package:cinema_fe/models/actor.dart';
import 'package:cinema_fe/models/character.dart';
import 'package:cinema_fe/models/director.dart';
import 'package:cinema_fe/models/movie.dart';

String errorLoginStr =
    "Wrong username or password. Please try again or create an account.";

String moviesTabStr = "Our movies";

String addToastStr(Object object, int? id, bool succeed) {
  String type = id == null ? "added" : "edited";
  if (succeed) {
    return "The ${getCategoryName(object)} has been $type.";
  }
  type = id == null ? "add" : "edit";
  return "We could not $type the ${getCategoryName(object)}.";
}

String deleteToastStr(Object object, bool succeed) {
  if (succeed) {
    return "The ${getCategoryName(object)} has been deleted.";
  }
  return "We could not delete the ${getCategoryName(object)}.";
}

String getCategoryName(Object object) {
  if (object is Movie) {
    return "movie";
  } else if (object is Actor) {
    return "actor";
  } else if (object is Character) {
    return "character";
  } else if (object is Director) {
    return "director";
  }
  return "";
}
