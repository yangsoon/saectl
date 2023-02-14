#!/usr/bin/env bash

# Implemented based on Vela Cli https://static.kubevela.net/script/install.sh

# SAECTL location
: ${SAECTL_INSTALL_DIR:="/usr/local/bin"}

# sudo is required to copy binary to SAECTL_INSTALL_DIR for linux
: ${USE_SUDO:="false"}

# Http request CLI
SAECTL_HTTP_REQUEST_CLI=curl

# SAECTL filename
SAECTL_FILENAME=saectl

SAECTL_FILE="${SAECTL_INSTALL_DIR}/${SAECTL_FILENAME}"

DOWNLOAD_BASE="https://sae-component-software.oss-cn-hangzhou.aliyuncs.com/saectl"

getSystemInfo() {
    ARCH=$(uname -m)
    case $ARCH in
        armv7*) ARCH="arm";;
        aarch64) ARCH="arm64";;
        x86_64) ARCH="amd64";;
    esac

    OS=$(echo `uname`|tr '[:upper:]' '[:lower:]')

    # Most linux distro needs root permission to copy the file to /usr/local/bin
    if [ "$OS" == "linux" ] || [ "$OS" == "darwin" ]; then
        if [ "$SAECTL_INSTALL_DIR" == "/usr/local/bin" ]; then
            USE_SUDO="true"
        fi
    fi
}

verifySupported() {
    local supported=(darwin-amd64 darwin-arm64 linux-amd64 linux-arm linux-arm64)
    local current_osarch="${OS}-${ARCH}"

    for osarch in "${supported[@]}"; do
        if [ "$osarch" == "$current_osarch" ]; then
            echo -e "Your system is ${OS}_${ARCH}"
            return
        fi
    done

    echo "No prebuilt binary for ${current_osarch}"
    exit 1
}

runAsRoot() {
    local CMD="$*"

    if [ $EUID -ne 0 -a $USE_SUDO = "true" ]; then
        CMD="sudo $CMD"
    fi

    $CMD
}

checkHttpRequestCLI() {
    if type "curl" > /dev/null; then
        SAECTL_HTTP_REQUEST_CLI=curl
    elif type "wget" > /dev/null; then
        SAECTL_HTTP_REQUEST_CLI=wget
    else
        echo "Either curl or wget is required"
        exit 1
    fi
}

checkExistingSaeCtl() {
    if [ -f "$SAECTL_FILE" ]; then
        echo -e "\nSaeCtl is detected:\n"
        $SAECTL_FILE version
        echo -e "\nReinstalling SaeCtl - ${SAECTL_FILE}..."
    else
        echo -e "Installing SaeCtl..."
    fi
}

downloadFile() {
    LATEST_RELEASE_TAG=$1

    SAECTL_ARTIFACT="${SAECTL_FILENAME}-${LATEST_RELEASE_TAG}-${OS}-${ARCH}.tar.gz"
    # convert `-` to `_` to let it work
    DOWNLOAD_URL="${DOWNLOAD_BASE}/${LATEST_RELEASE_TAG}/${SAECTL_ARTIFACT}"

    # Create the temp directory
    SAECTL_TMP_ROOT=$(mktemp -dt saectl-install-XXXXXX)
    ARTIFACT_TMP_FILE="$SAECTL_TMP_ROOT/$SAECTL_ARTIFACT"

    echo "Downloading $DOWNLOAD_URL ..."
    if [ "$SAECTL_HTTP_REQUEST_CLI" == "curl" ]; then
        curl -SsL "$DOWNLOAD_URL" -o "$ARTIFACT_TMP_FILE"
    else
        wget -q -O "$ARTIFACT_TMP_FILE" "$DOWNLOAD_URL"
    fi

    if [ ! -f "$ARTIFACT_TMP_FILE" ]; then
        echo "failed to download $DOWNLOAD_URL ..."
        exit 1
    fi
}

installFile() {
    tar xf "$ARTIFACT_TMP_FILE" -C "$SAECTL_TMP_ROOT"
    local tmp_root_saectl="$SAECTL_TMP_ROOT/${OS}-${ARCH}/$SAECTL_FILENAME"

    if [ ! -f "$tmp_root_saectl" ]; then
        echo "Failed to unpack SaeCtl executable."
        exit 1
    fi

    chmod o+x $tmp_root_saectl
    runAsRoot cp "$tmp_root_saectl" "$SAECTL_INSTALL_DIR"

    if [ $? -eq 0 ] && [ -f "$SAECTL_FILE" ]; then
        echo -e "$SAECTL_FILENAME installed into $SAECTL_INSTALL_DIR successfully.\n"

        $SAECTL_FILE version
    else
        echo "Failed to install $SAECTL_FILENAME"
        exit 1
    fi
}

fail_trap() {
    result=$?
    if [ "$result" != "0" ]; then
        echo "Failed to install SaeCtl"
        echo "For support, go to https://help.aliyun.com/document_detail/475877.html"
    fi
    cleanup
    exit $result
}

cleanup() {
    if [[ -d "${SAECTL_TMP_ROOT:-}" ]]; then
        rm -rf "$SAECTL_TMP_ROOT"
    fi
}

installCompleted() {
    echo -e "\nTo get started with SaeCtl, please visit https://help.aliyun.com/document_detail/475877.html"
}

# -----------------------------------------------------------------------------
# main
# -----------------------------------------------------------------------------
trap "fail_trap" EXIT

getSystemInfo
verifySupported
checkExistingSaeCtl
checkHttpRequestCLI

echo "Installing latest SaeCtl..."

downloadFile "latest"
installFile
cleanup

installCompleted