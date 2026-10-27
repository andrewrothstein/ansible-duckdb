#!/usr/bin/env sh
set -e
DIR=~/Downloads
MIRROR=https://github.com/duckdb/duckdb/releases/download

dl()
{
    local ver=$1
    local os=$2
    local arch=$3
    # 2.0.0 switched from duckdb_cli-*.zip to duckdb-cli-*.tar.gz
    local archive_type=${4:-tar.gz}
    local sep=${5:--}
    local platform="${os}-${arch}"
    # https://github.com/duckdb/duckdb/releases/download/v2.0.0/duckdb-cli-linux-amd64.tar.gz
    local url="${MIRROR}/v${ver}/duckdb${sep}cli-${platform}.${archive_type}"
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
    local archive_type=tar.gz
    local sep=-
    if [ "$(printf '%s\n2.0.0\n' $ver | sort -V | head -n1)" != "2.0.0" ];
    then
        archive_type=zip
        sep=_
    fi
    dl $ver linux arm64 $archive_type $sep
    dl $ver linux amd64 $archive_type $sep
    dl $ver osx universal $archive_type $sep
    dl $ver windows amd64 $archive_type $sep
}

dlver ${1:-2.0.0}
