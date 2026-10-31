# Filmovi – otvoreni skup podataka za predmet *Otvoreno računarstvo*

Skup podataka sadrži informacije o 17 poznatih filmova s navedenim najvažnijim podacima o tim filmovima. Za svaki film navedeni su naziv, zemlja produkcije, ocjena, datum izlaska, dobna granica, izvorni jezik, žanrovi kojima pripadaju, redatelj i nekoliko odabranih glumaca i filmskih likova koje glume.

## Metapodaci
- **Naziv skupa:** Filmovi
- **Autor:** Fabijan Radat 
- **Verzija:** 1.0
- **Licencija:** Creative Commons Zero v1.0 Universal (CC0 1.0 Universal)
- **Jezik podataka:** engleski
- **Formati:** CSV, JSON
- **Kodiranje:** UTF-8
- **Datum izrade:** 31.10.2026.
- **Sadržaj baze podataka:** 
  - 17 filmova
  - 16 redatelja
  - 9 žanrova
  - 40 glumaca
- **Izvor podataka:** [TMDb](https://www.themoviedb.org/)
- **Vrsta skupa:** kataloški
- **Ključne riječi:** film, glumci, redatelji, žanrovi

## Atributi
Skup podataka sadrži 14 atributa:
| Atribut | Opis |
|---|---|
| Title | Naslov filma |
| Country | Zemlja produkcije |
| Rating | Ocjena (0–10) |
| ReleaseDate | Datum izlaska (YYYY-MM-DD) |
| DurationMinutes | Trajanje u minutama |
| AgeRestriction | Preporučena dobna granica |
| OriginalLanguage | Izvorni jezik filma |
| Genre | Žanrovi filma |
| DirectorFirstName | Ime redatelja |
| DirectorLastName | Prezime redatelja |
| ActorFirstName | Ime glumca |
| ActorLastName | Prezime glumca |
| ActorCountry | Zemlja podrijetla glumca |
| CharacterName | Ime filmskog lika kojeg navedeni glumac glumi |

**Napomena o formatima:**

Zbog razlika u strukturi CSV i JSON formata, pojedini atributi prikazani su na različite načine.

- **CSV:** Podaci o redatelju i glumcima prikazani su zasebnim atributima (`DirectorFirstName`, `DirectorLastName`, `ActorFirstName`, `ActorLastName`, `ActorCountry`, `CharacterName`), a žanrovi su prikazani kao vrijednost atributa
- **JSON:** Podaci o redatelju i glumcima organizirani su kao ugniježđeni objekti (`Director` i `Actors`), a žanrovi su prikazani kao polje
