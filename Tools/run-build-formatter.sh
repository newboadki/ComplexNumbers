# Staged files
git diff --cached --name-only | grep "\.swift" | while read filename; do
    ./Tools/swiftformat "$filename"
done

# Unstaged files
git diff --name-only | grep "\.swift" | while read filename; do
    ./Tools/swiftformat "$filename"
done

