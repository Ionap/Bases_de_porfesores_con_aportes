# Bases_de_profesores_con_aportes
# Base de Datos - Bases_de_profesores

Este repositorio contiene la estructura y datos de la base de datos **Bases_de_profesores**, utilizada para gestionar información de profesores, aportes y entidades.

## 📂 Contenido del Repositorio

- `Bases_de_profesores.sql` → Archivo SQL con la estructura y datos de la base de datos.
- `README.md` → Documento con instrucciones para importar y utilizar la base de datos.

## 📌 Requisitos
Antes de importar la base de datos, asegúrate de tener instalado:

- **MySQL** (versión 5.7 o superior)
- **phpMyAdmin** (opcional, para una gestión más sencilla)

## 🚀 Instalación
Para importar la base de datos, sigue estos pasos:

### Opción 1: Usando MySQL desde la Terminal
1. Crea la base de datos:
   ```sql
   CREATE DATABASE Bases_de_profesores_con_aportes;
   ```
2. Importa el archivo SQL:
   ```sh
   mysql -u usuario -p Bases_de_profesores_con_aportes < Bases_de_profesores_con_aportes.sql
   ```
   *(Reemplaza `usuario` con tu usuario de MySQL.)*

### Opción 2: Usando phpMyAdmin
1. Accede a phpMyAdmin.
2. Crea una nueva base de datos llamada **Bases_de_profesores_con_aportes**.
3. Ve a la pestaña **Importar** y selecciona el archivo `Bases_de_profesores_con_aportes.sql`.
4. Haz clic en **Continuar**.

## 🛠 Estructura de la Base de Datos
La base de datos cuenta con las siguientes tablas principales:

- **profesores**: Contiene datos de los profesores.
- **aportes**: Registra los aportes realizados por cada profesor.
- **entes**: Guarda información sobre los entes relacionados con los aportes.
- **departamentos y municipios**: Relación entre departamentos y municipios.

## 📊 Consultas Útiles

- Consultar el procedimiento: Obtener el número de profesores por ente:
  ```sql
  SELECT e.nombre_ente, COUNT(DISTINCT p.numero_cedula) AS total_profesores
  FROM aportes a
  INNER JOIN entes e ON a.id_entes = e.id_entes
  INNER JOIN profesores p ON a.numero_cedula = p.numero_cedula
  GROUP BY e.nombre_ente;
  ```

- Consultar la vista: Obtener municipios por departamento
  ```sql
  SELECT d.nombre_departamentos, m.nombre_municipios
  FROM municipios m
  INNER JOIN departamentos d ON m.id_departamentos = d.id_departamentos;
  ```

## 📄 Licencia
Este proyecto es de uso interno. Si deseas utilizarlo o modificarlo, consulta con el propietario del repositorio.

---
**Autor:** Ing. Iona Duarte-

