#!/bin/bash

NOTES_FILE="notes.txt"  # File to store notes

# Function to display usage
show_usage() {
  echo "Usage:"
  echo "./note.sh add \"Your note here\""
  echo "./note.sh list"
  echo "./note.sh search \"keyword\""
  echo "./note.sh delete"
  echo "./note.sh help"
}

# Function to handle commands
handle_command() {
  case "$1" in
    add)
      if [ -z "$2" ]; then
        echo "Error: Note content is required for the 'add' command."
        exit 1
      fi
      timestamp=$(date "+%Y-%m-%d %H:%M:%S")
      echo "$2 - $timestamp" >> "$NOTES_FILE"
      echo "Note added successfully"
      ;;
    list)
      if [[ -s $NOTES_FILE ]]; then
        echo "Your notes:"
        cat "$NOTES_FILE"
      else
        echo "No notes found."
      fi
      ;;
    search)
      if [ -z "$2" ]; then
        echo "Error: Search keyword is required for the 'search' command."
        exit 1
      fi
      grep -i "$2" "$NOTES_FILE" || echo "No matching notes found."
      ;;
    delete)
      > "$NOTES_FILE"
      echo "All notes deleted."
      ;;
    help)
      show_usage
      ;;
    *)
      echo "Invalid command."
      show_usage
      exit 1
      ;;
  esac
}

# Main script logic
if [ $# -lt 1 ]; then
  echo "Error: No command provided."
  show_usage
  exit 1
fi

handle_command "$@"
