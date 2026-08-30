#!/usr/bin/env bash
set -euo pipefail

cat <<'EOF'
install-grapheneos 0.0.0 [DRAFT]

NOT READY FOR USE
GrapheneOS installation is not implemented or tested yet.
This command currently documents the intended workflow only.
No device changes will be performed.
EOF

echo
echo "Planned implementation:"
echo "  1. Verify adb/fastboot prerequisites"
echo "  2. Detect exactly one connected device"
echo "  3. Identify exact Pixel model and boot state"
echo "  4. Validate current GrapheneOS support/documentation"
echo "  5. Verify release artifacts"
echo "  6. STOP for human approval before destructive operations"
echo "  7. Install using the official GrapheneOS procedure"
echo "  8. Verify OS and bootloader/security state"

exit 0
