#!/usr/bin/env bash
sed -i "/deb-src/s/# //g" /etc/apt/sources.list
sudo apt update
sudo apt install python3-pyquery -y
python3 get-newest-version.py $1
aria2c $KEY
gpg --import  --pinentry-mode loopback --batch --passphrase "$KEYPASSWORD"  private-file.key
#VERSION=$(grep 'Kernel Configuration' < config | awk '{print $3}')
# add deb-src to sources.list
VERSION=`cat /tmp/kernelversion.txt`
URL=`cat /tmp/kernelurl.txt`
MAINVERSION=`expr substr $VERSION 1 1`
SHOWVERSION=$VERSION-arm64
curl https://github.com/gfdgd-xi/dclc-kernel/raw/main/$SHOWVERSION/index.html | grep 404
if [[ $? == 0 ]]; then
    exit
fi
# install dep
sudo apt install -y wget xz-utils make gcc flex bison dpkg-dev bc rsync kmod cpio libssl-dev git lsb vim libelf-dev
sudo apt build-dep -y linux
wget http://releases.linaro.org/components/toolchain/binaries/7.5-2019.12/aarch64-linux-gnu/gcc-linaro-7.5.0-2019.12-x86_64_aarch64-linux-gnu.tar.xz
tar -xvf gcc-linaro-7.5.0-2019.12-x86_64_aarch64-linux-gnu.tar.xz
sudo mkdir /usr/bin/toolchain
sudo cp gcc-linaro-7.5.0-2019.12-x86_64_aarch64-linux-gnu /usr/bin/toolchain/ -rfv
export PATH=$PATH:/usr/bin/toolchain/gcc-linaro-7.5.0-2019.12-x86_64_aarch64-linux-gnu/bin/
echo $PATH
# change dir to workplace
cd "${GITHUB_WORKSPACE}" || exit

# download kernel source
wget $URL  
if [[ -f linux-"$VERSION".tar.xz ]]; then
    tar -xvf linux-"$VERSION".tar.xz
fi
if [[ -f linux-"$VERSION".tar.gz ]]; then
    tar -xvf linux-"$VERSION".tar.gz
fi
if [[ -f linux-"$VERSION".tar ]]; then
    tar -xvf linux-"$VERSION".tar
fi
if [[ -f linux-"$VERSION".bz2 ]]; then
    tar -xvf linux-"$VERSION".tar.bz2
fi
cd linux-"$VERSION" || exit

# copy config file
cp ../config-arm64 .config
#
# disable DEBUG_INFO to speedup build
# scripts/config --disable DEBUG_INFO 
scripts/config --set-str SYSTEM_TRUSTED_KEYS ""
scripts/config --set-str SYSTEM_REVOCATION_KEYS ""
scripts/config --undefine DEBUG_INFO
scripts/config --undefine DEBUG_INFO_COMPRESSED
scripts/config --undefine DEBUG_INFO_REDUCED
scripts/config --undefine DEBUG_INFO_SPLIT
scripts/config --undefine GDB_SCRIPTS
scripts/config --set-val  DEBUG_INFO_DWARF5     n
scripts/config --set-val  DEBUG_INFO_NONE       y

# build deb packages
CPU_CORES=$(($(grep -c processor < /proc/cpuinfo)*2))
sudo make bindeb-pkg ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu- -j"$CPU_CORES"

# move deb packages to artifact dir
cd ..
mkdir "artifact"
#cp ./*.deb artifact/
git clone https://gfdgd-xi:$PASSWORD@github.com/gfdgd-xi/dclc-kernel
#cd dclc-kernel
mkdir dclc-kernel/$VERSION-aarch64
rm -rfv *dbg*.deb
mv ./*.deb dclc-kernel/$VERSION-aarch64
cd dclc-kernel/$VERSION-aarch64
cd ..
cd head
cat > deb-/DEBIAN/control <<EOF
Package: linux-kernel-dclc-gfdgdxi
Version: $VERSION
Maintainer: gfdgd xi <3025613752@qq.com>
Homepage: https://github.com/gfdgd-xi/dclc-kernel
Architecture: arm64
Severity: serious
Certainty: possible
Check: binaries
Type: binary, udeb
Priority: optional
Depends: linux-headers-$VERSION-arm64-desktop, linux-image-$VERSION-arm64-desktop
Section: utils
Installed-Size: 0
Description: 内核（虚包）
EOF
cat > deb-$MAINVERSION/DEBIAN/control <<EOF
Package: linux-kernel-dclc-gfdgdxi-$MAINVERSION
Version: $VERSION
Maintainer: gfdgd xi <3025613752@qq.com>
Homepage: https://github.com/gfdgd-xi/dclc-kernel
Architecture: arm64
Severity: serious
Certainty: possible
Check: binaries
Type: binary, udeb
Priority: optional
Depends: linux-headers-$VERSION-arm64-desktop, linux-image-$VERSION-arm64-desktop
Section: utils
Installed-Size: 0
Description: 内核（虚包）
EOF
dpkg -b deb linux-kernel-dclc-gfdgdxi_${VERSION}_arm64.deb
dpkg -b deb-$MAINVERSION linux-kernel-dclc-gfdgdxi-$MAINVERSION_${VERSION}_arm64.deb
cd ..
bash ./repack-zstd --scan .
./build.py
git add .
git config --global user.email 3025613752@qq.com
git config --global user.name gfdgd-xi
git commit -m 提交$VERSION
git push
