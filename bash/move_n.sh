#!/bin/bash

# Script to move the top n files to a destination directory
# Usage: move_n [number_of_files] [source_directory] [destination_directory] [sort_option]

# Function to display usage
usage() {
  echo "Usage: move_n [number_of_files] [source_directory] [destination_directory] [sort_option]"
  echo "  number_of_files: Number of files to move (required)"
  echo "  source_directory: Directory to move files from (default: current directory)"
  echo "  destination_directory: Directory to move files to (required)"
  echo "  sort_option: How to sort files (default: name)"
  echo "    Options: name, size, time, access, creation"
  exit 1
}

# Check if at least two arguments are provided (number and destination)
if [ $# -lt 2 ]; then
  usage
fi

# Get the number of files to move
n=$1
shift

# Check if n is a valid number
if ! [[ "$n" =~ ^[0-9]+$ ]]; then
  echo "Error: First argument must be a number."
  usage
fi

# Get the source directory (default to current directory if not specified)
source_dir="."
if [ $# -gt 1 ] && [ -d "$1" ]; then
  source_dir="$1"
  shift
fi

# Get the destination directory
if [ $# -lt 1 ] || [ ! -d "$1" ]; then
  echo "Error: Destination directory does not exist or was not specified."
  usage
fi
dest_dir="$1"
shift

# Get the sort option (default to name if not specified)
sort_opt="name"
if [ $# -gt 0 ]; then
  sort_opt="$1"
fi

# Set the find and sort options based on the sort_opt
find_cmd="find \"$source_dir\" -type f -not -path \"*/\\.*\""
case "$sort_opt" in
  "name")
    find_cmd="$find_cmd | sort"
    ;;
  "size")
    find_cmd="$find_cmd -exec ls -S {} \\;"
    ;;
  "time"|"modified")
    find_cmd="$find_cmd -exec ls -t {} \\;"
    ;;
  "access")
    find_cmd="$find_cmd -exec ls -u {} \\;"
    ;;
  "creation")
    find_cmd="$find_cmd -exec ls -U {} \\;"
    ;;
  *)
    echo "Warning: Unknown sort option '$sort_opt'. Using 'name' instead."
    find_cmd="$find_cmd | sort"
    ;;
esac

# Get the top n files
files=$(eval "$find_cmd" | head -n "$n")

# Check if any files were found
if [ -z "$files" ]; then
  echo "No files found in '$source_dir' to move."
  exit 1
fi

# Count how many files will be moved
file_count=$(echo "$files" | wc -l | xargs)

# Move the files and show progress
echo "Moving $file_count files to '$dest_dir'..."
echo "$files" | while read -r file; do
  if [ -f "$file" ]; then
    echo "Moving: $file"
    mv "$file" "$dest_dir"
  fi
done

echo "Done! Moved $file_count files to '$dest_dir'."