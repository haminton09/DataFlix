# 🎬 DATAFLIX - Proyecto SQL


# DataFlix
DATAFLIX es un sistema de gestión de películas inspirado en Netflix, desarrollado con Oracle SQL Developer. Incluye un proceso ETL desde datos reales de IMDb.

## ⚙️ Tecnologías

* Python (Pandas)
* Oracle SQL Developer
* SQL (DDL, DML)

---

## 🔄 Proceso ETL

### Extract

Se descargaron datasets desde IMDb en formato `.tsv`.

### IMDb Data Files Available for Download
https://datasets.imdbws.com/

title.basics.tsv.gz - movies
name.basics.tsv.gz  - people


### Transform

* Limpieza de datos (`\N` → NULL)
* Conversión de tipos
* Eliminación de valores inválidos
* Conversión de TSV a CSV

Python - Pandas
https://github.com/haminton09/DataFlix/blob/47ea61c2bbb7689b8041726e899500f082d1fd0d/ETL.py

### Load
  Crear Tablas 
  https://github.com/haminton09/DataFlix/blob/bd9d9572f640ac4f7a86f157d5a03cdacba0f005/DataFlix.sql
  
* Importación de datos a Oracle usando SQL Developer
  
---

## 🧱 Modelo de Datos

Tablas principales:

* movies
* people
* movie_people

---

# Modelo ERD
![image alt](https://github.com/haminton09/DataFlix/blob/673f5b81a1a0753da40ffd30734bfae1f8d01040/Dataflix_Logical.png)
 https://github.com/haminton09/DataFlix/blob/39810fbc32ec06cf26ad60c5298d1c2f99aba6d5/Diagrama_Dataflix.pdf

## 🎬 Movies (Películas)

**Descripción:**
Almacena la información principal de las películas.

| Columna         | Tipo          | Descripción           | Restricciones |
| --------------- | ------------- | --------------------- | ------------- |
| id              | VARCHAR2(20)  | Identificador único   | PK            |
| title           | VARCHAR2(255) | Título de la película | INDEX         |
| release_year    | NUMBER        | Año de estreno        | -             |
| runtime_minutes | NUMBER        | Duración en minutos   | -             |

---

## 👤 People (Personas)

**Descripción:**
Contiene información de actores, directores y participantes.

| Columna    | Tipo          | Descripción          | Restricciones |
| ---------- | ------------- | -------------------- | ------------- |
| id         | VARCHAR2(20)  | Identificador único  | PK            |
| name       | VARCHAR2(255) | Nombre de la persona | -             |
| birth_year | NUMBER        | Año de nacimiento    | -             |

---

## 🎭 Movie Participation (Participación)

**Descripción:**
Relaciona películas con personas y su rol.

| Columna   | Tipo         | Descripción                 | Restricciones |
| --------- | ------------ | --------------------------- | ------------- |
| movie_id  | VARCHAR2(20) | Película                    | PK, FK        |
| person_id | VARCHAR2(20) | Persona                     | PK, FK        |
| role      | VARCHAR2(50) | Rol (actor, director, etc.) | -             |

---

## 🎞 Genres (Géneros)

**Descripción:**
Lista de géneros cinematográficos.

| Columna | Tipo          | Descripción       | Restricciones |
| ------- | ------------- | ----------------- | ------------- |
| id      | NUMBER        | Identificador     | PK            |
| name    | VARCHAR2(100) | Nombre del género | -             |

---

## 🎬 Movie Genres

**Descripción:**
Relaciona películas con sus géneros.

| Columna  | Tipo         | Descripción | Restricciones |
| -------- | ------------ | ----------- | ------------- |
| movie_id | VARCHAR2(20) | Película    | PK, FK        |
| genre_id | NUMBER       | Género      | PK, FK        |

---

## ⭐ Ratings (Calificaciones)

**Descripción:**
Almacena la puntuación de cada película.

| Columna        | Tipo         | Descripción           | Restricciones |
| -------------- | ------------ | --------------------- | ------------- |
| movie_id       | VARCHAR2(20) | Película              | PK, FK        |
| average_rating | NUMBER(3,1)  | Calificación promedio | -             |
| vote_count     | NUMBER       | Número de votos       | -             |

---

## 📅 Releases (Lanzamientos)

**Descripción:**
Contiene la fecha de estreno y si es un lanzamiento reciente.

| Columna      | Tipo         | Descripción              | Restricciones |
| ------------ | ------------ | ------------------------ | ------------- |
| movie_id     | VARCHAR2(20) | Película                 | PK, FK        |
| release_date | DATE         | Fecha de estreno         | -             |
| is_new       | NUMBER(1)    | Indica si es nueva (1/0) | -             |

---

## 🤖 Recommendations (Recomendaciones)

**Descripción:**
Películas recomendadas según un puntaje.

| Columna  | Tipo          | Descripción              | Restricciones |
| -------- | ------------- | ------------------------ | ------------- |
| id       | NUMBER        | Identificador            | PK            |
| movie_id | VARCHAR2(20)  | Película                 | FK            |
| score    | NUMBER(5,2)   | Puntaje de recomendación | INDEX         |
| reason   | VARCHAR2(100) | Motivo                   | -             |

---

## 📚 Lists (Listas)

**Descripción:**
Define colecciones de películas (ej: Top 10, Tendencias).

| Columna     | Tipo          | Descripción        | Restricciones |
| ----------- | ------------- | ------------------ | ------------- |
| id          | NUMBER        | Identificador      | PK            |
| name        | VARCHAR2(100) | Nombre de la lista | -             |
| description | VARCHAR2(255) | Descripción        | -             |

---

## 📌 List Items

**Descripción:**
Asocia películas a listas con un orden.

| Columna  | Tipo         | Descripción          | Restricciones |
| -------- | ------------ | -------------------- | ------------- |
| list_id  | NUMBER       | Lista                | PK, FK        |
| movie_id | VARCHAR2(20) | Película             | PK, FK        |
| position | NUMBER       | Posición en la lista | -             |

---

## 📈 Trends (Tendencias)

**Descripción:**
Registra el ranking de popularidad por fecha.

| Columna    | Tipo         | Descripción         | Restricciones |
| ---------- | ------------ | ------------------- | ------------- |
| movie_id   | VARCHAR2(20) | Película            | PK, FK        |
| trend_date | DATE         | Fecha               | PK            |
| ranking    | NUMBER       | Posición en ranking | -             |

---

## 🚀 Índices

* idx_movies_title → Búsqueda por título
* idx_ratings_score → Ordenar por calificación
* idx_trends_date → Consultas por fecha
* idx_recommendations_score → Ranking de recomendaciones

---

## 🔐 Restricciones

* Claves primarias y foráneas
* Restricciones NOT NULL
* CHECK en categorías y clasificación

---

## 👁️ Vistas

* TITLE_UNAVAIL: muestra películas no devueltas

---

## 🔢 Secuencias

* Generación automática de IDs

---

## 🔄 CRUD

El sistema permite:

* Crear registros
* Consultar datos
* Actualizar información
* Eliminar registros

---

## 🚀 Resultados

Se logró implementar un sistema funcional con datos reales, aplicando conceptos de ETL y bases de datos relacionales.

---

## 👨‍💻 Autor

Jose Haminton Quiñones Preciado

