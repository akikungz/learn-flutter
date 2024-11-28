# Alias flutter command to FLUTTER_PATH in .env file

# Load .env file
source .env

# Alias flutter command
alias flutter=$FLUTTER_PATH/bin/flutter

# Add prefix to ps1
export PS1="(flutter) $PS1"