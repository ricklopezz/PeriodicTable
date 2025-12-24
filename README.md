# periodic_table (freeCodeCamp)

## Uso
- Conexión: `psql --username=freecodecamp --dbname=periodic_table`
- Dump: `pg_dump -cC --inserts -U freecodecamp periodic_table > periodic_table.sql`
- Script: `./element.sh <atomic_number|symbol|name>`

## Notas del proyecto
- Esquema normalizado: FK `properties.atomic_number` -> `elements.atomic_number`; tabla `types` con `type_id`.
- `atomic_mass` en DECIMAL/NUMERIC sin ceros a la derecha.
- Elementos agregados: Fluorine (#9), Neon (#10), tipo `nonmetal`.
EOF
