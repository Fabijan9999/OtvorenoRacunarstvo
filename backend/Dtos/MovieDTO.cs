namespace backend.Dtos
{
    public class MovieDTO
    {
        public string Title { get; set; } = null!;
        public string? Country { get; set; }
        public decimal? Rating { get; set; }
        public DateOnly? ReleaseDate { get; set; }
        public int? DurationMinutes { get; set; }
        public int? AgeRestriction { get; set; }
        public string? OriginalLanguage { get; set; }

        public List<string> Genre { get; set; } = [];

        public string? DirectorFirstName { get; set; }
        public string? DirectorLastName { get; set; }

        public List<ActorDTO> Actors { get; set; } = [];
    }
}
