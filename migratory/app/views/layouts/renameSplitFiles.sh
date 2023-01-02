for file in application*.haml*; do
   mv "$file" "$(echo "$file" | sed 's/\(.*\)haml\(.*\)/\1aa.haml\2/')"
done
