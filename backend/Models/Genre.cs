using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using Microsoft.EntityFrameworkCore;

namespace backend.Models;

[Table("genre")]
public partial class Genre
{
    [Key]
    [Column("genreid")]
    public int Genreid { get; set; }

    [Column("genrename")]
    [StringLength(100)]
    public string Genrename { get; set; } = null!;

    [ForeignKey("Genreid")]
    [InverseProperty("Genres")]
    public virtual ICollection<Movie> Movies { get; set; } = new List<Movie>();
}
