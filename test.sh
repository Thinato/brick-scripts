#!/bin/bash
# ./run-jest.sh

# Run the test and capture output and status
OUTPUT=$(npx jest "$@" 2>&1)
STATUS=$?

if [ $STATUS -eq 0 ]; then
  notify-send "✅ Test Passed" "$(echo "$OUTPUT" | tail -n 5)"  # Optional: show last few lines
else
  code -n -a .  # Re-focus VSCode if needed
  gnome-terminal -- bash -c "echo \"$OUTPUT\"; exec bash"
fi

exit $STATUS
