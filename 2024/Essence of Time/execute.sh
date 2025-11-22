if [ $1 ]; then
    date -d "$1" +%s
else
    echo "No timestamp provided."
fi
