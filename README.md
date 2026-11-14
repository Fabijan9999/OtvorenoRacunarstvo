# Filmovi – otvoreni skup podataka za predmet *Otvoreno računarstvo*

Skup podataka sadrži informacije o 17 poznatih filmova s navedenim najvažnijim podacima o tim filmovima. Za svaki film navedeni su naziv, zemlja produkcije, ocjena, datum izlaska, dobna granica, izvorni jezik, žanrovi kojima pripadaju, redatelj i nekoliko odabranih glumaca i filmskih likova koje glume.

## Metapodaci
- **Naziv skupa:** Filmovi
- **Autor:** Fabijan Radat 
- **Verzija:** 2.0
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
| Atribut | Tip podatka | Opis |
|---|---|---|
| Title | String | Naslov filma |
| Country | String | Zemlja produkcije |
| Rating | Float (0-10) | Ocjena |
| ReleaseDate | Date (YYYY-MM-DD) | Datum izlaska |
| DurationMinutes | Integer || Trajanje u minutama |
| AgeRestriction | Integer | Preporučena dobna granica |
| OriginalLanguage | String | Izvorni jezik filma |
| Genre | String[] | Žanrovi filma |
| DirectorFirstName | String | Ime redatelja |
| DirectorLastName | String | Prezime redatelja |
| ActorFirstName | String | Ime glumca |
| ActorLastName | String | Prezime glumca |
| ActorCountry | String | Zemlja podrijetla glumca |
| CharacterName | String | Ime filmskog lika kojeg navedeni glumac glumi |

**Napomena o formatima:**

Zbog razlika u strukturi CSV i JSON formata, pojedini atributi prikazani su na različite načine.

- **CSV:** Podaci o redatelju i glumcima prikazani su zasebnim atributima (`DirectorFirstName`, `DirectorLastName`, `ActorFirstName`, `ActorLastName`, `ActorCountry`, `CharacterName`), a žanrovi su prikazani kao polje
- **JSON:** Podaci o redatelju i glumcima organizirani su kao ugniježđeni objekti (`Director` i `Actors`), a žanrovi su prikazani kao polje

## Web sučelje

Podaci su dostupni preko web sučelja koje poslužuje ASP.NET Core backend.

- **`index.html`** – početna stranica s metapodacima, opisom atributa i poveznicama za preuzimanje cjelokupnog skupa podataka (`movies.csv`, `movies.json`) i JSON sheme (`schema.json`). Datoteke se poslužuju s datotečnog sustava
- **`datatable.html`** – tablica filmova s podacima dohvaćenima iz baze asinkronim pozivom na REST API. Sadrži obrazac za filtriranje, prikaz filtriranih podataka i gumbe za preuzimanje trenutnog prikaza u CSV i JSON obliku

### Filtriranje
- Polje za unos teksta pretražuje po svim atributima (wildcard)
- Padajući izbornik omogućuje suženje pretrage na jedan atribut
- Prazan unos ili gumb *Obriši filtar* vraćaju početni prikaz svih podataka
- Pretraga po tekstualnim atributima je djelomična i neosjetljiva na velika/mala slova, a po ocjeni, trajanju, dobnoj granici i datumu traži se točno podudaranje

### API

`GET /api/movies?search={tekst}&attribute={atribut}`

- `search` – tekst pretrage (prazno = svi podaci)
- `attribute` – jedan od 14 atributa (prazno = svi atributi)

Odgovor je JSON polje filmova s ugniježđenim objektima `Director` i `Actors`.

## Struktura repozitorija

```
MoviesApp/            ASP.NET Core (kontroler, DTO-i, mapperi, AppDbContext)
MoviesApp/wwwroot/    index.html, datatable.html, css/, js/, data/
Movies-dump.sql       dump baze podataka
movies.csv            skup podataka (CSV)
movies.json           skup podataka (JSON)
schema.json           JSON shema
LICENSE
README.md
```

## Pokretanje
1. Instalirati PostgreSQL i stvoriti praznu bazu
2. Uvesti dump: `psql -U korisnik -p PORT -d imebaze -f Movies-dump.sql`
3. Inicijalizirati User Secrets: `dotnet user-secrets init`
4. U User Secrets postaviti connection string: `dotnet user-secrets set "ConnectionStrings:MoviesDatabase" "CONNECTION_STRING"`
5. U mapi `backend` pokrenuti `dotnet run`
6. Otvoriti `http://localhost:PORT/`

## Promjene u odnosu na verziju 1.0
- Dodano web sučelje (`index.html`, `datatable.html`)
- Dodan backend s REST API-jem za dohvat i filtriranje podataka iz baze
- Dodano filtriranje (wildcard i po atributu) i preuzimanje filtriranog prikaza u CSV i JSON obliku
- Dodana JSON shema