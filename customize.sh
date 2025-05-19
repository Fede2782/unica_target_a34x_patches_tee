SKIPUNZIP=1

# Move current to eea
mv -f "$WORK_DIR/vendor/tee" "$WORK_DIR/vendor/tee_eea"
sed -i "s./vendor/tee./vendor/tee_eea.g" "$WORK_DIR/configs/file_context-vendor"
sed -i "s.vendor/tee.vendor/tee_eea.g" "$WORK_DIR/configs/fs_config-vendor"

# Setup extraction script
# Create the placebo dir
mkdir -p "$WORK_DIR/vendor/tee"
SET_METADATA "vendor" "tee" 0 0 644 "u:object_r:tee_file:s0"

ADD_TO_WORK_DIR "$SRC_DIR/target/a34x/patches/tee" "vendor" "etc/init/tee_blobs.rc"
EEA_VER="$(cat $FW_DIR/SM-A346B_EUX/.extracted | cut -d'/' -f1 )"
sed -i "s/EEAVER/$EEA_VER/" "$WORK_DIR/vendor/etc/init/tee_blobs.rc"

ADD_TO_WORK_DIR "$SRC_DIR/target/a34x/patches/tee" "vendor" "tee_chn"
ADD_TO_WORK_DIR "$SRC_DIR/target/a34x/patches/tee" "vendor" "tee_sea"
ADD_TO_WORK_DIR "$SRC_DIR/target/a34x/patches/tee" "vendor" "tee_kor"
ADD_TO_WORK_DIR "$SRC_DIR/target/a34x/patches/tee" "vendor" "tee_latam"

if ! grep -q "tee_file (dir (mounton" "$WORK_DIR/vendor/etc/selinux/vendor_sepolicy.cil"; then
    echo "(allow init_31_0 tee_file (dir (mounton)))" >> "$WORK_DIR/vendor/etc/selinux/vendor_sepolicy.cil"
    echo "(allow priv_app_31_0 tee_file (dir (getattr)))" >> "$WORK_DIR/vendor/etc/selinux/vendor_sepolicy.cil"
fi
