#!/usr/bin/env bash
exit
sed -i "/deb-src/s/# //g" /etc/apt/sources.list
sudo apt update
sudo apt install python3-pyquery python3-requests -y
sudo apt install gpg python3-pyquery -y
aria2c $KEY
gpg --import  --pinentry-mode loopback --batch --passphrase "$KEYPASSWORD"  private-file.key
python3 get-newest-version-xanmod.py $1
#curl https://www.xanmod.org/
#exit
#VERSION=$(grep 'Kernel Configuration' < config | awk '{print $3}')
# add deb-src to sources.list
#$1
VERSION=`cat /tmp/kernelversion.txt`
URL=`cat /tmp/kernelurl.txt`
MAINVERSION=`expr substr $VERSION 1 1`
SHOWVERSION=$VERSION
# 使用 deepin hwe config编译
if [[ $2 == 1 ]]; then
    SHOWVERSION=$VERSION-hwe
fi
curl https://github.com/gfdgd-xi/dclc-kernel/raw/main/$SHOWVERSION/index.html | grep 404
if [[ $? != 0 ]]; then
    exit
fi
# install dep
sudo apt install -y wget xz-utils make gcc flex bison dpkg-dev bc rsync kmod cpio libssl-dev git lsb vim libelf-dev
sudo apt build-dep -y linux

# change dir to workplace
cd "${GITHUB_WORKSPACE}" || exit

# download kernel source
wget $URL  
tar -xvf "$VERSION".tar.bz2
cd linux-"$VERSION"* || exit

# copy config file
if [[ $2 == 1 ]]; then
    cp ../config-6.1.11-amd64-desktop-hwe .config
else
    cp ../config .config
fi
#
# disable DEBUG_INFO to speedup build
scripts/config --set-str SYSTEM_TRUSTED_KEYS ""
scripts/config --set-str SYSTEM_REVOCATION_KEYS ""
scripts/config --undefine DEBUG_INFO
scripts/config --undefine DEBUG_INFO_COMPRESSED
scripts/config --undefine DEBUG_INFO_REDUCED
scripts/config --undefine DEBUG_INFO_SPLIT
scripts/config --undefine GDB_SCRIPTS
scripts/config --set-val  DEBUG_INFO_DWARF5     n
scripts/config --set-val  DEBUG_INFO_NONE       y
# apply patches
# shellcheck source=src/util.sh
# source ../patch.d/*.sh

# build deb packages
CPU_CORES=$(($(grep -c processor < /proc/cpuinfo)*2))
sudo make bindeb-pkg -j"$CPU_CORES"
if [[ $2 == 1 ]]; then
    # move deb packages to artifact dir
    cd ..
    mkdir "artifact"
    #cp ./*.deb artifact/
    git clone https://gfdgd-xi:$PASSWORD@github.com/gfdgd-xi/dclc-kernel --depth=1
    #cd dclc-kernel
    mkdir dclc-kernel/$SHOWVERSION
    rm -rfv *dbg*.deb
    mv ./*.deb dclc-kernel/$SHOWVERSION
    cd dclc-kernel/$SHOWVERSION
    cd ..
    cd head
    cat > deb/DEBIAN/control <<EOF
Package: linux-kernel-dclc-gfdgdxi-xanmod-hwe
Version: $VERSION
Maintainer: gfdgd xi <3025613752@qq.com>
Homepage: https://github.com/gfdgd-xi/dclc-kernel
Architecture: amd64
Severity: serious
Certainty: possible
Check: binaries
Type: binary, udeb
Priority: optional
Depends: linux-headers-$VERSION-amd64-desktop-hwe, linux-image-$VERSION-amd64-desktop-hwe
Section: utils
Installed-Size: 0
Description: 内核（虚包）
EOF
    if [[ ! -d deb-$MAINVERSION-xanmod ]]; then
        mkdir -pv deb-$MAINVERSION-xanmod/DEBIAN
    fi
    cat > deb-$MAINVERSION-xanmod/DEBIAN/control <<EOF
Package: linux-kernel-dclc-gfdgdxi-$MAINVERSION-xanmod-hwe
Version: $VERSION
Maintainer: gfdgd xi <3025613752@qq.com>
Homepage: https://github.com/gfdgd-xi/dclc-kernel
Architecture: amd64
Severity: serious
Certainty: possible
Check: binaries
Type: binary, udeb
Priority: optional
Depends: linux-headers-$VERSION-amd64-desktop-hwe, linux-image-$VERSION-amd64-desktop-hwe
Section: utils
Installed-Size: 0
Description: 内核（虚包）
EOF
    dpkg-deb -Z xz -b deb linux-kernel-dclc-gfdgdxi-xanmod-hwe_${VERSION}_amd64.deb
    dpkg-deb -Z xz -b deb-$MAINVERSION-xanmod linux-kernel-dclc-gfdgdxi-xanmod-$MAINVERSION-hwe_${VERSION}_amd64.deb
    cd ..
    bash ./repack-zstd --scan .
    rm Packages || echo "Failed to remove packages file"
    rm Packages.gz || echo "Failed to remove packages.gz file"
    rm Release || echo "Failed to remove release file"
    rm Release.gpg || echo "Failed to remove release.gpg file"
    rm InRelease || echo "Failed to remove inrelease file"
    dpkg-scanpackages --multiversion . > Packages
    gzip -k -f Packages
    apt-ftparchive release . > Release
    gpg --default-key "3025613752@qq.com" --batch --pinentry-mode="loopback" --passphrase="$KEYPASSWORD" -abs -o - Release > Release.gpg || error "failed to sign Release.gpg with gpg "
    gpg --default-key "3025613752@qq.com" --batch --pinentry-mode="loopback" --passphrase="$KEYPASSWORD" --clearsign -o - Release > InRelease || error "failed to sign InRelease with gpg"
    ./build.py
    git add .
    #git pull
    git config --global user.email 3025613752@qq.com
    git config --global user.name gfdgd-xi
    git commit -m 提交$VERSION
    git push
else
    # move deb packages to artifact dir
    cd ..
    mkdir "artifact"
    #cp ./*.deb artifact/
    git clone https://gfdgd-xi:$PASSWORD@github.com/gfdgd-xi/dclc-kernel --depth=1
    #cd dclc-kernel
    mkdir dclc-kernel/$VERSION
    rm -rfv *dbg*.deb
    mv ./*.deb dclc-kernel/$VERSION
    cd dclc-kernel/$VERSION
    cd ..
    cd head
    cat > deb/DEBIAN/control <<EOF
Package: linux-kernel-dclc-gfdgdxi-xanmod
Version: $VERSION
Maintainer: gfdgd xi <3025613752@qq.com>
Homepage: https://github.com/gfdgd-xi/dclc-kernel
Architecture: amd64
Severity: serious
Certainty: possible
Check: binaries
Type: binary, udeb
Priority: optional
Depends: linux-headers-$VERSION-amd64-desktop, linux-image-$VERSION-amd64-desktop
Section: utils
Installed-Size: 0
Description: 内核（虚包）
EOF
    if [[ ! -d deb-$MAINVERSION-xanmod ]]; then
        mkdir -pv deb-$MAINVERSION-xanmod/DEBIAN
    fi
    cat > deb-$MAINVERSION-xanmod/DEBIAN/control <<EOF
Package: linux-kernel-dclc-gfdgdxi-$MAINVERSION-xanmod
Version: $VERSION
Maintainer: gfdgd xi <3025613752@qq.com>
Homepage: https://github.com/gfdgd-xi/dclc-kernel
Architecture: amd64
Severity: serious
Certainty: possible
Check: binaries
Type: binary, udeb
Priority: optional
Depends: linux-headers-$VERSION-amd64-desktop, linux-image-$VERSION-amd64-desktop
Section: utils
Installed-Size: 0
Description: 内核（虚包）
EOF
    dpkg-deb -Z xz -b deb linux-kernel-dclc-gfdgdxi-xanmod_${VERSION}_amd64.deb
    dpkg-deb -Z xz -b deb-$MAINVERSION-xanmod linux-kernel-dclc-gfdgdxi-xanmod-$MAINVERSION_${VERSION}_amd64.deb
    cd ..
    bash ./repack-zstd --scan .
    rm Packages || echo "Failed to remove packages file"
    rm Packages.gz || echo "Failed to remove packages.gz file"
    rm Release || echo "Failed to remove release file"
    rm Release.gpg || echo "Failed to remove release.gpg file"
    rm InRelease || echo "Failed to remove inrelease file"
    dpkg-scanpackages --multiversion . > Packages
    gzip -k -f Packages
    apt-ftparchive release . > Release
    gpg --default-key "3025613752@qq.com" --batch --pinentry-mode="loopback" --passphrase="$KEYPASSWORD" -abs -o - Release > Release.gpg || error "failed to sign Release.gpg with gpg "
    gpg --default-key "3025613752@qq.com" --batch --pinentry-mode="loopback" --passphrase="$KEYPASSWORD" --clearsign -o - Release > InRelease || error "failed to sign InRelease with gpg"
    ./build.py
    git add .
    #git pull
    git config --global user.email 3025613752@qq.com
    git config --global user.name gfdgd-xi
    git commit -m 提交$VERSION
    git push
fi
