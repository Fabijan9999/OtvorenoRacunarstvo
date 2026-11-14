using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using Microsoft.EntityFrameworkCore;

namespace backend.Models;

[Table("director")]
public partial class Director
{
    [Key]
    [Column("directorid")]
    public int Directorid { get; set; }

    [Column("firstname")]
    [StringLength(100)]
    public string Firstname { get; set; } = null!;

    [Column("lastname")]
    [StringLength(100)]
    public string Lastname { get; set; } = null!;

    [InverseProperty("Director")]
    public virtual ICollection<Movie> Movies { get; set; } = new List<Movie>();
}
