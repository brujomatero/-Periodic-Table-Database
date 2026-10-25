#!/bin/bash

PSQL="psql --username=freecodecamp --dbname=periodic_table -t --no-align -c"

#arg vacío
if [ -z "$1" ]
then
  echo -e "Please provide an element as an argument."

#si es num
elif [[ $1 =~ ^[0-9]+$ ]]
then
  b_num=$($PSQL "SELECT properties.atomic_number, symbol, name, atomic_mass, melting_point_celsius, boiling_point_celsius, type from properties inner join elements on properties.atomic_number=elements.atomic_number inner join types on properties.type_id=types.type_id where properties.atomic_number=$1") 
  if [ -z "$b_num" ]
  then
    echo I could not find that element in the database.
  else
    echo -e $b_num | while IFS="|" read number symbol name mass melt boil type
    do
    echo -e "The element with atomic number $number is $name ($symbol). It's a $type, with a mass of $mass amu. $name has a melting point of $melt celsius and a boiling point of $boil celsius."
    done
  fi

#si es símbolo
elif [[ ${#1} -le 2 ]]
then
  b_sym=$($PSQL "SELECT properties.atomic_number, symbol, name, atomic_mass, melting_point_celsius, boiling_point_celsius, type from properties inner join elements on properties.atomic_number=elements.atomic_number inner join types on properties.type_id=types.type_id where symbol='$1'")
  if [ -z "$b_sym" ]
  then
    echo I could not find that element in the database.
  else
    echo -e $b_sym | while IFS="|" read number symbol name mass melt boil type
    do
    echo -e "The element with atomic number $number is $name ($symbol). It's a $type, with a mass of $mass amu. $name has a melting point of $melt celsius and a boiling point of $boil celsius."
    done
  fi

#si es nombre
elif [[ ${#1} -gt 2 ]]
then
  b_nom=$($PSQL "SELECT properties.atomic_number, symbol, name, atomic_mass, melting_point_celsius, boiling_point_celsius, type from properties inner join elements on properties.atomic_number=elements.atomic_number inner join types on properties.type_id=types.type_id where name='$1'")
  if [ -z "$b_nom" ]
  then
    echo I could not find that element in the database.
  else
    echo -e $b_nom | while IFS="|" read number symbol name mass melt boil type
    do
    echo -e "The element with atomic number $number is $name ($symbol). It's a $type, with a mass of $mass amu. $name has a melting point of $melt celsius and a boiling point of $boil celsius."
    done
  fi

fi



