#!/bin/bash

__dir__="$(cd "$(dirname "$0")" && pwd)"

# shellcheck source=scripts/configuration.sh
source "$__dir__/configuration.sh"
# shellcheck source=scripts/digest.sh
source "$__dir__/digest.sh"
# shellcheck source=scripts/aws.sh
source "$__dir__/aws.sh"
# shellcheck source=scripts/io.sh
source "$__dir__/io.sh"

function rbx_package_stdlib {
  echo "Packaging stdlib/cache..."

  rm -rf "$(rbx_stdlib_cache_name)"

  tar -czvf "$(rbx_stdlib_cache_name)" ext/ lib/ bin/

  rbx_digest_file "$(rbx_stdlib_cache_name)" "sha512"
}

function rbx_archive_stdlib {
  local archive ext url bucket

  archive="$(rbx_stdlib_cache_name)"
  ext=".sha512"
  bucket="$(rbx_binary_bucket)"
  url=$(rbx_url_prefix "$bucket")
  path="/stdlib/"

  rm -f "$archive" "$archive$ext"

  rbx_package_stdlib || fail "unable to package stdlib cache"

  rbx_s3_upload "$url" "$bucket" "$archive" "$archive" "$path" ||
    fail "unable to upload stdlib cache archive"
  rbx_s3_upload "$url" "$bucket" "$archive$ext" "$archive$ext" "$path" ||
    fail "unable to upload stdlib cache archive digest"
}

function rbx_build_support_usage {
  cat >&2 <<-EOM
Usage: ${0##*/} archive_stdlib
EOM
  exit 1
}

if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
  case "$1" in
    "archive_stdlib")
      rbx_archive_stdlib
      ;;
    "-h"|"--help"|*)
      rbx_build_support_usage
      ;;
  esac
fi
