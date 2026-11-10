using backend.Data;
using backend.Mappers;
using Microsoft.AspNetCore.Http;
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
        public async Task<ActionResult> GetMovies()
        {
            var movies = await ctx.Movies.Include(m => m.Director)
                .Include(m => m.Director)
                .Include(m => m.Genres)
                .Include(m => m.MovieActors)
                    .ThenInclude(ma => ma.Actor)
                .Select(m => m.ToMovieDto()).ToListAsync();

            return Ok(movies);
        }
    }
}
