
#!/bin/bash
# script
PSQL="psql --username=freecodecamp --dbname=periodic_table -t --no-align -c"

if [[ -z $1 ]]; then
  echo "Please provide an element as an argument."
  exit 0
fi

ARG="$1"

if [[ $ARG =~ ^[0-9]+$ ]]; then
  WHERE="e.atomic_number = $ARG"
else
  WHERE="(LOWER(e.symbol) = LOWER('$ARG') OR LOWER(e.name) = LOWER('$ARG'))"
fi

QUERY="
SELECT e.atomic_number, e.name, e.symbol, p.atomic_mass, p.melting_point_celsius, p.boiling_point_celsius, t.type
FROM elements e
JOIN properties p USING(atomic_number)
JOIN types t ON p.type_id = t.type_id
WHERE $WHERE;
"

RESULT="$($PSQL "$QUERY")"

if [[ -z $RESULT ]]; then
  echo "I could not find that element in the database."
  exit 0
fi

IFS='|' read -r ATOMIC_NUMBER NAME SYMBOL ATOMIC_MASS MELTING BOILING TYPE <<< "$RESULT"

echo "The element with atomic number $ATOMIC_NUMBER is $NAME ($SYMBOL). It's a $TYPE, with a mass of $ATOMIC_MASS amu. $NAME has a melting point of $MELTING celsius and a boiling point of $BOILING celsius."
