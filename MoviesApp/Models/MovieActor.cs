using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using Microsoft.EntityFrameworkCore;

namespace backend.Models;

[PrimaryKey("Movieid", "Actorid")]
[Table("movie_actor")]
public partial class MovieActor
{
    [Column("charactername")]
    [StringLength(100)]
    public string Charactername { get; set; } = null!;

    [Key]
    [Column("movieid")]
    public int Movieid { get; set; }

    [Key]
    [Column("actorid")]
    public int Actorid { get; set; }

    [ForeignKey("Actorid")]
    [InverseProperty("MovieActors")]
    public virtual Actor Actor { get; set; } = null!;

    [ForeignKey("Movieid")]
    [InverseProperty("MovieActors")]
    public virtual Movie Movie { get; set; } = null!;
}
