using System;
using System.Collections.Generic;
using Microsoft.EntityFrameworkCore;
using backend.Models;

namespace backend.Data;

public partial class AppDbContext : DbContext
{
    public AppDbContext(DbContextOptions<AppDbContext> options)
        : base(options)
    {
    }

    public virtual DbSet<Actor> Actors { get; set; }

    public virtual DbSet<Director> Directors { get; set; }

    public virtual DbSet<Genre> Genres { get; set; }

    public virtual DbSet<Movie> Movies { get; set; }

    public virtual DbSet<MovieActor> MovieActors { get; set; }

    protected override void OnModelCreating(ModelBuilder modelBuilder)
    {
        modelBuilder.Entity<Actor>(entity =>
        {
            entity.HasKey(e => e.Actorid).HasName("actor_pkey");

            entity.Property(e => e.Actorid).UseIdentityAlwaysColumn();
        });

        modelBuilder.Entity<Director>(entity =>
        {
            entity.HasKey(e => e.Directorid).HasName("director_pkey");

            entity.Property(e => e.Directorid).UseIdentityAlwaysColumn();
        });

        modelBuilder.Entity<Genre>(entity =>
        {
            entity.HasKey(e => e.Genreid).HasName("genre_pkey");

            entity.Property(e => e.Genreid).UseIdentityAlwaysColumn();
        });

        modelBuilder.Entity<Movie>(entity =>
        {
            entity.HasKey(e => e.Movieid).HasName("movie_pkey");

            entity.Property(e => e.Movieid).UseIdentityAlwaysColumn();

            entity.HasOne(d => d.Director).WithMany(p => p.Movies)
                .OnDelete(DeleteBehavior.ClientSetNull)
                .HasConstraintName("movie_directorid_fkey");

            entity.HasMany(d => d.Genres).WithMany(p => p.Movies)
                .UsingEntity<Dictionary<string, object>>(
                    "MovieGenre",
                    r => r.HasOne<Genre>().WithMany()
                        .HasForeignKey("Genreid")
                        .OnDelete(DeleteBehavior.ClientSetNull)
                        .HasConstraintName("movie_genre_genreid_fkey"),
                    l => l.HasOne<Movie>().WithMany()
                        .HasForeignKey("Movieid")
                        .OnDelete(DeleteBehavior.ClientSetNull)
                        .HasConstraintName("movie_genre_movieid_fkey"),
                    j =>
                    {
                        j.HasKey("Movieid", "Genreid").HasName("movie_genre_pkey");
                        j.ToTable("movie_genre");
                        j.IndexerProperty<int>("Movieid").HasColumnName("movieid");
                        j.IndexerProperty<int>("Genreid").HasColumnName("genreid");
                    });
        });

        modelBuilder.Entity<MovieActor>(entity =>
        {
            entity.HasKey(e => new { e.Movieid, e.Actorid }).HasName("movie_actor_pkey");

            entity.HasOne(d => d.Actor).WithMany(p => p.MovieActors)
                .OnDelete(DeleteBehavior.ClientSetNull)
                .HasConstraintName("movie_actor_actorid_fkey");

            entity.HasOne(d => d.Movie).WithMany(p => p.MovieActors)
                .OnDelete(DeleteBehavior.ClientSetNull)
                .HasConstraintName("movie_actor_movieid_fkey");
        });

        OnModelCreatingPartial(modelBuilder);
    }

    partial void OnModelCreatingPartial(ModelBuilder modelBuilder);
}
