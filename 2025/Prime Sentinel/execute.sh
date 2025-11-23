#!/bin/bash
n=$1

(( n <= 1 )) && { echo "Neither"; exit 0; }
(( n == 2 )) && { echo "Prime"; exit 0; }
(( n % 2 == 0 )) && { echo "Composite"; exit 0; }

for ((i=3; i*i<=n; i+=2)); do
    (( n % i == 0 )) && { echo "Composite"; exit 0; }
done

echo "Prime"
