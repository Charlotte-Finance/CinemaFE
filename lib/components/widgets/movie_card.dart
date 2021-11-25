import 'package:cinema_fe/blocs/movie/movie_bloc.dart';
import 'package:cinema_fe/components/widgets/error_message.dart';
import 'package:cinema_fe/models/movie.dart';
import 'package:cinema_fe/models/user.dart';
import 'package:cinema_fe/utils/route_arguments.dart';
import 'package:cinema_fe/utils/routing_constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MovieCard extends StatefulWidget {
  final Movie movie;
  final User user;
  final bool enableClick;

  final Icon unlikedIcon = const Icon(
    Icons.favorite_border,
    color: Colors.red,
    size: 40,
  );
  final Icon likedIcon = const Icon(
    Icons.favorite,
    color: Colors.red,
    size: 40,
  );

  const MovieCard({
    Key? key,
    required this.user,
    required this.movie,
    this.enableClick = true,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _MovieCardState();
  }
}

class _MovieCardState extends State<MovieCard> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MovieBloc, MovieState>(
      builder: (context, state) {
        if (state is MovieEmpty) {
          context.watch<MovieBloc>().add(
                FetchLike(
                  user: widget.user,
                  movie: widget.movie,
                ),
              );
        } else if (state is MovieLoaded) {
          return Stack(
            children: [
              GestureDetector(
                onTap: () {
                  if (widget.enableClick) {
                    Navigator.pushNamed(
                      context,
                      MovieRoute,
                      arguments: MovieArgument(
                        user: widget.user,
                        movie: widget.movie,
                      ),
                    );
                  }
                },
                child: Image(
                  image:
                      AssetImage('lib/assets/movies/${widget.movie.title}.jpg'),
                ),
              ),
              GestureDetector(
                onTap: () {
                  setState(() {
                    widget.movie.isLiked = !(widget.movie.isLiked!);
                    BlocProvider.of<MovieBloc>(context).add(
                      LikeMovie(
                        user: widget.user,
                        movie: widget.movie,
                        isLiked: (widget.movie.isLiked!),
                      ),
                    );
                  });
                },
                child: Container(
                  padding: const EdgeInsets.all(10.0),
                  color: Colors.white.withOpacity(0.2),
                  child: widget.movie.isLiked!
                      ? widget.likedIcon
                      : widget.unlikedIcon,
                ),
              ),
            ],
          );
        } else if (state is MovieError) {
          return ErrorMessage(
            error: state.error,
            bloc: BlocProvider.of<MovieBloc>(context),
            event: state.event,
          );
        }
        return const CircularProgressIndicator();
      },
    );
  }
}
