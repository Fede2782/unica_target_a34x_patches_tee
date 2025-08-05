DELETE_FROM_WORK_DIR "vendor" "tee"
mkdir -p "$WORK_DIR/vendor/tee"
SET_METADATA "vendor" "tee" 0 2000 755 "u:object_r:tee_file:s0"

if ! grep -q "tee_file (dir (mounton" "$WORK_DIR/vendor/etc/selinux/vendor_sepolicy.cil"; then
    echo "(allow init_202404 tee_file (dir (mounton)))" >> "$WORK_DIR/vendor/etc/selinux/vendor_sepolicy.cil"
    echo "(allow priv_app_202404 tee_file (dir (getattr)))" >> "$WORK_DIR/vendor/etc/selinux/vendor_sepolicy.cil"
fi

SET_PROP "vendor" "ro.vendor.teegris.supported_bootloaders" "$(cat "$(dirname ${BASH_SOURCE[0]})/supported_bootloaders" | tr '\n' ',' | sed 's/,$//')"
