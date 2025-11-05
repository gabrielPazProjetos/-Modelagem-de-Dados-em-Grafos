// Constraints
CREATE CONSTRAINT ON (u:User) ASSERT u.id IS UNIQUE;
CREATE CONSTRAINT ON (m:Movie) ASSERT m.id IS UNIQUE;
CREATE CONSTRAINT ON (s:Series) ASSERT s.id IS UNIQUE;
CREATE CONSTRAINT ON (g:Genre) ASSERT g.name IS UNIQUE;
CREATE CONSTRAINT ON (a:Actor) ASSERT a.name IS UNIQUE;
CREATE CONSTRAINT ON (d:Director) ASSERT d.name IS UNIQUE;

// Genres
UNWIND [
  "Drama", "Comedy", "Action", "Sci-Fi", "Romance",
  "Thriller", "Fantasy", "Horror", "Documentary", "Adventure"
] AS genreName
MERGE (:Genre {name: genreName});

// Users
UNWIND range(1,10) AS i
CREATE (:User {id: i, name: "User " + i});

// Movies
UNWIND [
  {id: 1, title: "Echoes of Tomorrow", year: 2022},
  {id: 2, title: "Laughing Matters", year: 2021},
  {id: 3, title: "Steel Horizon", year: 2020},
  {id: 4, title: "Quantum Love", year: 2023},
  {id: 5, title: "The Last Stand", year: 2019}
] AS movie
CREATE (:Movie {id: movie.id, title: movie.title, year: movie.year});

// Series
UNWIND [
  {id: 6, title: "Dreamcatchers", year: 2020},
  {id: 7, title: "Bytecode", year: 2021},
  {id: 8, title: "Hearts & Minds", year: 2022},
  {id: 9, title: "Shadow Protocol", year: 2023},
  {id: 10, title: "The Loop", year: 2024}
] AS series
CREATE (:Series {id: series.id, title: series.title, year: series.year});

// Actors
UNWIND [
  "Alice Monroe", "John Carter", "Lena Kim", "Marco Silva", "Tina Zhang"
] AS actorName
MERGE (:Actor {name: actorName});

// Directors
UNWIND [
  "Nora Fields", "David Lin", "Carlos Mendes", "Sophie Tran", "Raj Patel"
] AS directorName
MERGE (:Director {name: directorName});

// Relationships: IN_GENRE, ACTED_IN, DIRECTED
UNWIND [
  {id: 1, type: "Movie", genre: "Sci-Fi", actor: "Alice Monroe", director: "Nora Fields"},
  {id: 2, type: "Movie", genre: "Comedy", actor: "John Carter", director: "David Lin"},
  {id: 3, type: "Movie", genre: "Action", actor: "Marco Silva", director: "Carlos Mendes"},
  {id: 4, type: "Movie", genre: "Romance", actor: "Lena Kim", director: "Sophie Tran"},
  {id: 5, type: "Movie", genre: "Thriller", actor: "Tina Zhang", director: "Raj Patel"},
  {id: 6, type: "Series", genre: "Drama", actor: "Alice Monroe", director: "David Lin"},
  {id: 7, type: "Series", genre: "Fantasy", actor: "John Carter", director: "Carlos Mendes"},
  {id: 8, type: "Series", genre: "Horror", actor: "Marco Silva", director: "Sophie Tran"},
  {id: 9, type: "Series", genre: "Documentary", actor: "Lena Kim", director: "Raj Patel"},
  {id: 10, type: "Series", genre: "Adventure", actor: "Tina Zhang", director: "Nora Fields"}
] AS item
MATCH (g:Genre {name: item.genre})
MATCH (a:Actor {name: item.actor})
MATCH (d:Director {name: item.director})
CALL {
  WITH item
  MATCH (n) WHERE
    (item.type = "Movie" AND n:Movie AND n.id = item.id) OR
    (item.type = "Series" AND n:Series AND n.id = item.id)
  MERGE (n)-[:IN_GENRE]->(g)
  MERGE (a)-[:ACTED_IN]->(n)
  MERGE (d)-[:DIRECTED]->(n)
}

// Relationships: WATCHED with rating
MATCH (u:User), (m:Movie)
WHERE m.id IN [1,2,3,4,5] AND u.id <= 5
MERGE (u)-[:WATCHED {rating: toFloat(3 + rand()*2)}]->(m);

MATCH (u:User), (s:Series)
WHERE s.id IN [6,7,8,9,10] AND u.id > 5
MERGE (u)-[:WATCHED {rating: toFloat(2 + rand()*3)}]->(s);
