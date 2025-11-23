for f in src/*; do
  name=$(basename "$f")
  if echo "$name" | grep -qE "$1"; then
    mv "$f" "${f%.*}_renamed.${f##*.}"
  fi
done
