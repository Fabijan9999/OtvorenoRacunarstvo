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
    movie.Actors.forEach((actor) => {
      values.push({
        Title: movie.Title,
        Country: movie.Country,
        Rating: movie.Rating,
        ReleaseDate: movie.ReleaseDate,
        DurationMinutes: movie.DurationMinutes,
        AgeRestriction: movie.AgeRestriction,
        OriginalLanguage: movie.OriginalLanguage,
        Genre: movie.Genre.join(", "),
        DirectorFirstName: movie.Director.DirectorFirstName,
        DirectorLastName: movie.Director.DirectorLastName,
        ActorFirstName: actor.ActorFirstName,
        ActorLastName: actor.ActorLastName,
        ActorCountry: actor.ActorCountry,
        CharacterName: actor.CharacterName,
      });
    });
  });
  return values;
}

function renderMovies(movies) {
  results.innerHTML = "";

  try {
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

    document.getElementById("resultCount").textContent =
      `Pronađeno redaka: ${values.length}`;
    document.getElementById("status").textContent = "";
  } catch (error) {
    console.error(error);
    document.getElementById("status").textContent =
      "Greška prilikom prikaza podataka.";
  }
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

  downloadFile(csv, "movies.csv", "text/csv;charset=utf-8");
}

function exportJSON() {
  const json = JSON.stringify(filteredMovies, null, 4);

  downloadFile(json, "movies.json", "application/json");
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
