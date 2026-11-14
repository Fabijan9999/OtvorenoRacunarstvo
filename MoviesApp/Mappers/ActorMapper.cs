using backend.Dtos;
using backend.Models;

namespace backend.Mappers
{
    public static class ActorMapper
    {
        public static ActorDTO ToActorDto(this MovieActor movieActor)
        {
            return new ActorDTO
            {
                ActorFirstName = movieActor.Actor.Firstname,
                ActorLastName = movieActor.Actor.Lastname,
                ActorCountry = movieActor.Actor.Country,
                CharacterName = movieActor.Charactername
            };
        }
    }
}
