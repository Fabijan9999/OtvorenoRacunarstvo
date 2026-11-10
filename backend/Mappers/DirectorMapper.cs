using backend.Dtos;
using backend.Models;

namespace backend.Mappers
{
    public static class DirectorMapper
    {
        public static DirectorDTO ToDirectorDto(this Director director)
        {
            return new DirectorDTO
            {
                FirstName = director.Firstname,
                LastName = director.Lastname
            };
        }
    }
}
