#!/usr/bin/env bash
# Local equivalent of the GitHub Actions fmt + validate jobs.
# Does not call Azure. Uses a local backend and terraform validate only.
set -euo pipefail

root="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

terraform fmt -check -recursive -no-color "${root}/terraform"

for env in dev prod; do
  dir="${root}/terraform/environments/${env}"
  echo "==> init/validate ${env}"
  terraform -chdir="${dir}" init -backend=false -input=false -no-color
  terraform -chdir="${dir}" validate -no-color
done
