#!/bin/bash

UV=$(uuidgen) 
val1=$(echo $UV | tr '[:lower:]' '[:upper:]' | tr "-" " " ) 

echo $val1

