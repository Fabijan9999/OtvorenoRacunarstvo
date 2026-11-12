const columns = [
  "Title",
  "Country",
  "Rating",
  "ReleaseDate",
  "DurationMinutes",
  "AgeRestriction",
  "OriginalLanguage",
  "Genre",
  "DirectorFirstName",
  "DirectorLastName",
  "ActorFirstName",
  "ActorLastName",
  "ActorCountry",
  "CharacterName",
];

const API_URL = "/api/movies";

const searchInput = document.getElementById("searchInput");
const attributeSelect = document.getElementById("attributeSelect");
const results = document.getElementById("movieTableBody");

let filteredMovies = [];

function getRows(movies) {
  const values = [];
  movies.forEach((movie) => {
    movie.actors.forEach((actor) => {
      values.push({
        Title: movie.title,
        Country: movie.country,
        Rating: movie.rating,
        ReleaseDate: movie.releaseDate,
        DurationMinutes: movie.durationMinutes,
        AgeRestriction: movie.ageRestriction,
        OriginalLanguage: movie.originalLanguage,
        Genre: movie.genre.join(", "),
        DirectorFirstName: movie.director.firstName,
        DirectorLastName: movie.director.lastName,
        ActorFirstName: actor.actorFirstName,
        ActorLastName: actor.actorLastName,
        ActorCountry: actor.actorCountry,
        CharacterName: actor.characterName,
      });
    });
  });
  return values;
}

function renderMovies(movies) {
  results.innerHTML = "";

  const values = getRows(movies);

  values.forEach((value) => {
    const row = document.createElement("tr");

    columns.forEach((column) => {
      const cell = document.createElement("td");
      cell.textContent = value[column] ?? "";
      row.appendChild(cell);
    });

    results.appendChild(row);
  });
}

async function fetchMovies() {
  const searchText = searchInput.value.trim();
  const selectedAttribute = attributeSelect.value;

  const url = `${API_URL}?search=${encodeURIComponent(searchText)}&attribute=${encodeURIComponent(selectedAttribute)}`;

  try {
    const response = await fetch(url);

    if (!response.ok) {
      throw new Error("Greška prilikom dohvaćanja podataka.");
    }

    filteredMovies = await response.json();

    renderMovies(filteredMovies);
  } catch (error) {
    console.error(error);
  }
}

function downloadFile(content, fileName, type) {
  const blob = new Blob([content], { type: type });
  const url = URL.createObjectURL(blob);

  const link = document.createElement("a");
  link.href = url;
  link.download = fileName;
  link.click();

  URL.revokeObjectURL(url);
}

function exportCSV() {
  const header = columns.join(",");

  const rows = [];

  const values = getRows(filteredMovies);

  values.forEach((value) => {
    const row = columns.map((column) => {
      const val = String(value[column] ?? "");
      return '"' + val + '"';
    });

    rows.push(row.join(","));
  });

  const csv = "\uFEFF" + [header, ...rows].join("\r\n");

  downloadFile(csv, "filmovi.csv", "text/csv;charset=utf-8");
}

function exportJSON() {
  const json = JSON.stringify(filteredMovies, null, 4);

  downloadFile(json, "filmovi.json", "application/json");
}

document.addEventListener("DOMContentLoaded", fetchMovies);

searchInput.addEventListener("input", fetchMovies);

attributeSelect.addEventListener("change", fetchMovies);

const clearFiltersButton = document.getElementById("clearButton");

clearFiltersButton.addEventListener("click", () => {
  searchInput.value = "";
  attributeSelect.value = "";
  fetchMovies();
});

document.getElementById("csvButton").addEventListener("click", exportCSV);

document.getElementById("jsonButton").addEventListener("click", exportJSON);
