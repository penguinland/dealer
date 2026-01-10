#!/bin/bash

make test > tmp.log

# The last 3 things removed are:
# - the current date, which differs from 2025.12.29
# - diff output saying a line in the output differs from the same line in the
#   reference output (e.g., "123c123")
# - lines containing at least 3 consecutive hyphens, which are put in between
#   each example run and in between each piece of diff output
# The sed at the end is that Mac's wc command puts a bunch of leading spaces in,
# which we strip out.
output_length="$(cat tmp.log \
               | grep -v 'Time needed' \
               | grep -v 'Now processing' \
               | grep -v 'Done, output in' \
               | grep -v 'Comparing against reference output' \
               | grep -v '2025.12.29' \
               | grep -v '< .Date .20..\...\.....$' \
               | grep -v '\([0-9]\+\)c\1' \
               | grep -v -- --- \
               | wc -l \
               | sed 's/[[:space:]]//g'
               )"
# The remaining output shoud consist of make explaining what commands it's
# running. On Linux, this is 6 lines long, but on Mac it's only 4.
# On Windows, though, the PRNG has a different implementation, and since the
# random numbers provided are different, the tables of HCP distributions and
# suit length probabilities are slightly different! So, the Windows output still
# has 284 lines remaining!

cat tmp.log
echo ''
echo "Raw result length: '$(cat tmp.log | wc -l)'"
echo "Processed result length: '$output_length'"

if [[ ! "$output_length" =~ ^(4|6|284)$ ]]; then
    echo 'Unexpected test output length!'
    echo 'Non-filtered lines are:'
    echo ''
    # Surely there's a better way to do this than copy-and-paste from above, but
    # I couldn't figure it out. If you remove the `wc -l` above and just do it
    # later, all newlines get turned into spaces and it looks like it's a single
    # giant line.
    cat tmp.log \
        | grep -v 'Time needed' \
        | grep -v 'Now processing' \
        | grep -v 'Done, output in' \
        | grep -v 'Comparing against reference output' \
        | grep -v '2025.12.29' \
        | grep -v '< .Date .20..\...\.....$' \
        | grep -v '\([0-9]\+\)c\1' \
        | grep -v -- ---
    exit 1
fi

echo 'Success!'
