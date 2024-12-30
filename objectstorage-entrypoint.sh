for file in /docker-entrypoint-init.d/*; do
    if [ -x "$file" ]; then
    echo "Running $file"
    "$file"
    else
    echo "Sourcing $file"
    . "$file"
    fi
done
