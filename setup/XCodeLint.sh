SWIFTLINT=${PODS_ROOT}/SwiftLint/swiftlint
SWIFTLINT_CONFIG=../setup/.swiftlint.yml
ROOT_PATH=$(git rev-parse --show-toplevel)
NEWLINE=$'\n'

# Check if SwiftLint is installed
if [ -f "$SWIFTLINT" ]; then
	printf "Found SwiftLint: '$SWIFTLINT'.\n"
else
	printf "SwiftLint is not installed in the project. Please install pods of the project and re-run the script.\n"
	exit 1
fi

# Run SwiftLint
printf "Launching SwiftLint.\n"

RESULT=""

# Runs swiftlint for a file by a given path
lint_file() {
    local filename=$1

    local fileResult=$($SWIFTLINT --quiet --strict --path "${filename}" --config "${SWIFTLINT_CONFIG}")

    if [ "$fileResult" != '' ]; then    	
    	RESULT="${RESULT}${fileResult}${NEWLINE}"
    fi
}

# Automatically fix some linter errors
autocorrect_file() {
    local filename=$1

    $SWIFTLINT autocorrect --quiet --path "${filename}" --config "${SWIFTLINT_CONFIG}"
}

# Runs swiftlint for all modified swift files, including staged and unstaged changes
lint_changed_files() {
    for filename in $(git diff HEAD --name-only | egrep "\.swift$")
    do
        local filename="${ROOT_PATH}/${filename}" 

        autocorrect_file $filename
    	lint_file $filename
	done
}

lint_changed_files

if [[ "$RESULT" == '' ]]; then
	printf "\nSwiftLint Finished.\n\n"
else 
    # Print the result of lint so that xCode displays warnings and errors in Issue Navigator
    echo "$RESULT"
    exit 1
fi

