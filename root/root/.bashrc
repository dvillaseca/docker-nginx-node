# Set the history file location
export HISTFILE=/config/.bash_history

# Set the number of commands to keep in memory and in the file
export HISTSIZE=1000
export HISTFILESIZE=2000

# Append to the history file, don't overwrite it
shopt -s histappend

# Save history after each command (more robust for multiple exec sessions)
# and reload history for the current session
export PROMPT_COMMAND="history -a; history -n; ${PROMPT_COMMAND}"