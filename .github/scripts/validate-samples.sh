#!/bin/bash
set -euo pipefail
samples=$(cat samples/index.json | jq -rc '.samples[] | @base64')
exit_code=0
for sample_b64 in ${samples}; do
    _jq() {
        echo "${sample_b64}" | base64 --decode | jq -r "$1"
    }
    sample_id=$(_jq '.id')
    echo -n "Validating sample '${sample_id}'... "
    if [ -d "samples/${sample_id}" ]; then
        echo "ok"
    else
        echo "failed"
        echo >&2 "Sample directory 'samples/${sample_id}' does not exist"
        exit_code=1
    fi
    # TODO: run more validations: arm-ttk, UI-template wiring, bicep/json linter, etc.
done

exit ${exit_code}
