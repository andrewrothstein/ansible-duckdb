#!/usr/bin/env sh
set -e
DIR=~/Downloads
MIRROR=https://github.com/duckdb/duckdb/releases/download

dl()
{
    local ver=$1
    local os=$2
    local arch=$3
    local archive_type=${4:-zip}
    local platform="${os}-${arch}"
    # https://github.com/duckdb/duckdb/releases/download/v0.8.1/duckdb_cli-linux-amd64.zip
    local url="${MIRROR}/v${ver}/duckdb_cli-${platform}.${archive_type}"
    local lfile="${DIR}/duckdb_cli-${ver}-${platform}.${archive_type}"

    if [ ! -e $lfile ];
    then
        curl -sSLf -o $lfile $url
    fi

    printf "    # %s\n" $url
    printf "    %s: sha256:%s\n" $platform $(sha256sum $lfile | awk '{print $1}')
}

dlver () {
    local ver=$1
    printf "  '%s':\n" $ver
    dl $ver linux aarch64
    dl $ver linux amd64
    dl $ver osx universal
    dl $ver windows amd64
}

dlver ${1:-1.2.0}
