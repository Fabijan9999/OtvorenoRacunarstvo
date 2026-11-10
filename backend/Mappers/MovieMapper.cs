using backend.Dtos;
using backend.Models;

namespace backend.Mappers
{
    public static class MovieMapper
    {
        public static MovieDTO ToMovieDto(this Movie movie)
        {
            return new MovieDTO
            {
                Title = movie.Title,
                Country = movie.Country,
                Rating = movie.Rating,
                ReleaseDate = movie.Releasedate,
                DurationMinutes = movie.Durationminutes,
                AgeRestriction = movie.Agerestriction,
                OriginalLanguage = movie.Originallanguage,

                Genre = movie.Genres
                    .Select(g => g.Genrename)
                    .ToList(),

                director = movie.Director.ToDirectorDto(),

                Actors = movie.MovieActors
                    .Select(ma => ma.ToActorDto())
                    .ToList()
            };
        }
    }
}
