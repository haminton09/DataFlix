import pandas as pd

# ==============================
# CONFIGURACIÓN
# ==============================

# Rutas de archivos
movies_path = "data/title.basics.tsv"
people_path = "data/name.basics.tsv"

# ==============================
# EXTRACT
# ==============================

print("📥 Extrayendo datos...")

movies_df = pd.read_csv(movies_path, sep='\t', low_memory=False)
people_df = pd.read_csv(people_path, sep='\t', low_memory=False)

# ==============================
# TRANSFORM
# ==============================

print("🔧 Transformando datos...")

# Reemplazar valores nulos
movies_df.replace('\\N', pd.NA, inplace=True)
people_df.replace('\\N', pd.NA, inplace=True)

# ------------------------------
# 🎬 MOVIES
# ------------------------------
movies_clean = movies_df[
    movies_df['titleType'] == 'movie'
][[
    'tconst', 'primaryTitle', 'startYear', 'runtimeMinutes'
]].copy()

movies_clean.columns = ['id', 'title', 'year', 'duration']

# Convertir tipos
movies_clean['year'] = pd.to_numeric(movies_clean['year'], errors='coerce')
movies_clean['duration'] = pd.to_numeric(movies_clean['duration'], errors='coerce')

# Eliminar nulos importantes
movies_clean.dropna(subset=['id', 'title'], inplace=True)

# ------------------------------
# 👤 PEOPLE
# ------------------------------
people_clean = people_df[[
    'nconst', 'primaryName', 'birthYear'
]].copy()

people_clean.columns = ['id', 'name', 'birth_year']

people_clean['birth_year'] = pd.to_numeric(people_clean['birth_year'], errors='coerce')

people_clean.dropna(subset=['id', 'name'], inplace=True)

# ------------------------------
# 🔗 RELACIÓN (opcional básica)
# ------------------------------
# Nota: Esto normalmente viene de title.principals.tsv
# Aquí generamos un ejemplo simple

movie_people = movies_clean[['id']].head(100).copy()
movie_people['person_id'] = people_clean['id'].head(100).values
movie_people['role'] = 'actor'

movie_people.columns = ['movie_id', 'person_id', 'role']

# ==============================
# LOAD (CSV para Oracle)
# ==============================

print("📤 Guardando archivos limpios...")

movies_clean.to_csv("output/movies.csv", index=False)
people_clean.to_csv("output/people.csv", index=False)
movie_people.to_csv("output/movie_people.csv", index=False)

print("✅ ETL completado correctamente")
