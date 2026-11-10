
using backend.Data;
using backend.Mappers;
using backend.Models;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;

namespace backend.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class MoviesController : ControllerBase
    {
        private readonly AppDbContext ctx;

        public MoviesController(AppDbContext ctx)
        {
            this.ctx = ctx;
        }

        [HttpGet]
        public async Task<IActionResult> GetMovies(
            [FromQuery] string? search,
            [FromQuery] string? attribute)
        {
            IQueryable<Movie> query = ctx.Movies;

            if (!string.IsNullOrWhiteSpace(search))
            {
                string pattern = $"%{search}%";

                if (string.IsNullOrWhiteSpace(attribute))
                {
                    query = query.Where(m =>
                        EF.Functions.ILike(m.Title, pattern) ||
                        EF.Functions.ILike(m.Country, pattern) ||
                        EF.Functions.ILike(m.Originallanguage, pattern) ||
                        m.Genres.Any(g => EF.Functions.ILike(g.Genrename, pattern)) ||
                        EF.Functions.ILike(m.Director.Firstname, pattern) ||
                        EF.Functions.ILike(m.Director.Lastname, pattern) ||
                        m.MovieActors.Any(ma =>
                            EF.Functions.ILike(ma.Actor.Firstname, pattern) ||
                            EF.Functions.ILike(ma.Actor.Lastname, pattern) ||
                            EF.Functions.ILike(ma.Actor.Country, pattern) ||
                            EF.Functions.ILike(ma.Charactername, pattern))
                    );

                    if (decimal.TryParse(search, out decimal rating))
                        query = query.Union(ctx.Movies.Where(m => m.Rating == rating));

                    if (int.TryParse(search, out int number))
                    {
                        query = query.Union(ctx.Movies.Where(m =>
                            m.Durationminutes == number ||
                            m.Agerestriction == number));
                    }

                    if (DateOnly.TryParse(search, out DateOnly date))
                        query = query.Union(ctx.Movies.Where(m => m.Releasedate == date));
                }
                else
                {
                    query = attribute switch
                    {
                        "Title" => query.Where(m =>
                            EF.Functions.ILike(m.Title, pattern)),

                        "Country" => query.Where(m =>
                            EF.Functions.ILike(m.Country, pattern)),

                        "Rating" => decimal.TryParse(search, out decimal rating)
                            ? query.Where(m => m.Rating == rating)
                            : query.Where(m => false),

                        "ReleaseDate" => DateOnly.TryParse(search, out DateOnly date)
                            ? query.Where(m => m.Releasedate == date)
                            : query.Where(m => false),

                        "DurationMinutes" => int.TryParse(search, out int duration)
                            ? query.Where(m => m.Durationminutes == duration)
                            : query.Where(m => false),

                        "AgeRestriction" => int.TryParse(search, out int age)
                            ? query.Where(m => m.Agerestriction == age)
                            : query.Where(m => false),

                        "OriginalLanguage" => query.Where(m =>
                            EF.Functions.ILike(m.Originallanguage, pattern)),

                        "Genre" => query.Where(m =>
                            m.Genres.Any(g => EF.Functions.ILike(g.Genrename, pattern))),

                        "DirectorFirstName" => query.Where(m =>
                            EF.Functions.ILike(m.Director.Firstname, pattern)),

                        "DirectorLastName" => query.Where(m =>
                            EF.Functions.ILike(m.Director.Lastname, pattern)),

                        "ActorFirstName" => query.Where(m =>
                            m.MovieActors.Any(ma =>
                                EF.Functions.ILike(ma.Actor.Firstname, pattern))),

                        "ActorLastName" => query.Where(m =>
                            m.MovieActors.Any(ma =>
                                EF.Functions.ILike(ma.Actor.Lastname, pattern))),

                        "ActorCountry" => query.Where(m =>
                            m.MovieActors.Any(ma =>
                                EF.Functions.ILike(ma.Actor.Country, pattern))),

                        "CharacterName" => query.Where(m =>
                            m.MovieActors.Any(ma =>
                                EF.Functions.ILike(ma.Charactername, pattern))),

                        _ => query.Where(m => false)
                    };
                }
            }

            var movies = await query
                .Include(m => m.Director)
                .Include(m => m.Genres)
                .Include(m => m.MovieActors)
                    .ThenInclude(ma => ma.Actor)
                .Select(m => m.ToMovieDto())
                .ToListAsync();

            return Ok(movies);
        }
    }
}
