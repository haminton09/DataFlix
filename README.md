# 🎬 DATAFLIX - Proyecto SQL + ETL


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

### Transform

* Limpieza de datos (`\N` → NULL)
* Conversión de tipos
* Eliminación de valores inválidos
* Conversión de TSV a CSV

### Load

* Importación de datos a Oracle usando SQL Developer

---

## 🧱 Modelo de Datos

Tablas principales:

* movies
* people
* movie_people

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

