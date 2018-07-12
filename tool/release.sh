#!/bin/bash

# Tags and publishes the package.
#
# Required env vars:
#   GH_KEY_ID is used to sign the tag.

package=$(sed -nr -e 's|^name: (.+)$|\1|p' pubspec.yaml)
version=$(sed -nr -e 's|^version: (.+)$|\1|p' pubspec.yaml)

cat<<EOF
  Releasing $package ${version}...
EOF

check_commit() {
  git rev-list --format=%s -n 1 HEAD | grep '[ann]'
  bv=$?
  if [[ $bv -ne 0 ]]; then
    cat <<EOF
  Could not verify last commit bumped the package version. Aborting.
EOF
    exit $bv
  fi
}

check_changelog() {
  grep $version CHANGELOG.md
  cl=$?
  if [[ $cl -ne 0 ]]; then
    cat<<EOF
  Could not find changelog entry for "$version". Aborting.
EOF
    exit $cl
  fi
}

check_commit
check_changelog

git tag --cleanup=whitespace -u $GH_KEY_ID v$version && \
git push --tags && \
pub publish
