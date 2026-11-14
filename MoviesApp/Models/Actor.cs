using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using Microsoft.EntityFrameworkCore;

namespace backend.Models;

[Table("actor")]
public partial class Actor
{
    [Key]
    [Column("actorid")]
    public int Actorid { get; set; }

    [Column("firstname")]
    [StringLength(100)]
    public string Firstname { get; set; } = null!;

    [Column("lastname")]
    [StringLength(100)]
    public string Lastname { get; set; } = null!;

    [Column("country")]
    [StringLength(100)]
    public string Country { get; set; } = null!;

    [InverseProperty("Actor")]
    public virtual ICollection<MovieActor> MovieActors { get; set; } = new List<MovieActor>();
}
