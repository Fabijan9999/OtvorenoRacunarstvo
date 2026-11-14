using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using Microsoft.EntityFrameworkCore;

namespace backend.Models;

[Table("movie")]
public partial class Movie
{
    [Key]
    [Column("movieid")]
    public int Movieid { get; set; }

    [Column("title")]
    [StringLength(255)]
    public string Title { get; set; } = null!;

    [Column("releasedate")]
    public DateOnly Releasedate { get; set; }

    [Column("durationminutes")]
    public int Durationminutes { get; set; }

    [Column("agerestriction")]
    public int Agerestriction { get; set; }

    [Column("rating")]
    [Precision(3, 1)]
    public decimal Rating { get; set; }

    [Column("originallanguage")]
    [StringLength(100)]
    public string Originallanguage { get; set; } = null!;

    [Column("country")]
    [StringLength(100)]
    public string Country { get; set; } = null!;

    [Column("directorid")]
    public int Directorid { get; set; }

    [ForeignKey("Directorid")]
    [InverseProperty("Movies")]
    public virtual Director Director { get; set; } = null!;

    [InverseProperty("Movie")]
    public virtual ICollection<MovieActor> MovieActors { get; set; } = new List<MovieActor>();

    [ForeignKey("Movieid")]
    [InverseProperty("Movies")]
    public virtual ICollection<Genre> Genres { get; set; } = new List<Genre>();
}
