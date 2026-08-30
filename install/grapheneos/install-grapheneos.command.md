# Install GrapheneOS

**Status: DRAFT / PLACEHOLDER — do not treat this command as production-ready.**

Use `install-grapheneos` to prepare and guide installation of GrapheneOS on a supported Pixel connected to the execution computer over USB.

## Why

Privacy and control. The goal is to reduce reliance on a vendor-controlled phone OS, make device behavior and permissions more observable, and regain as much practical control as possible over access to personal data. This does not guarantee perfect privacy; starting at the OS provides a stronger trust boundary.

## Intent

Map requests such as `install GrapheneOS`, `install GrapheneOS on this Pixel`, or `prepare this Pixel for GrapheneOS` to this command.

## Safety contract

- Never guess the connected device model.
- Never continue when the device is unsupported or device identity is ambiguous.
- Use the current official GrapheneOS installation documentation as the source of truth before execution.
- Verify downloaded artifacts using the verification procedure documented by GrapheneOS.
- Stop before bootloader unlocking, data wiping, flashing, locking/relocking the bootloader, or any other irreversible/destructive boundary and obtain explicit human approval.
- Never bypass device security protections to make installation easier.
- Preserve a clear execution log and verification result.

## Expected input

- A supported Pixel physically connected over USB.
- A host computer capable of running the required Android platform tools.
- Human access to the phone for required confirmations.
- Backup/acceptance that installation may erase device data.

## Draft execution flow

1. Detect the connected Android device without modifying it.
2. Identify exact Pixel model and current boot/lock state.
3. Validate that the model is currently supported by GrapheneOS.
4. Check host prerequisites and required tools.
5. Read/validate the current official GrapheneOS installation procedure.
6. Present the detected device, planned destructive operations, and backup warning to the human.
7. STOP for explicit approval before any destructive operation.
8. Prepare bootloader state using only documented GrapheneOS/Pixel procedures.
9. Obtain and verify the correct GrapheneOS release for the exact device.
10. Flash/install GrapheneOS following the official procedure.
11. Relock the bootloader when required by the official procedure and confirm with the human on-device.
12. Boot GrapheneOS and verify installation/integrity.
13. Apply the requested privacy baseline: minimal microphone permissions, sandboxed Google services only if requested, and unnecessary ambient/voice features disabled.
14. Produce a final verification report.

## Implementation status

The executable implementation is intentionally a placeholder. The first implementation should automate only safe discovery/preflight checks. Destructive operations must remain explicit guarded stages with human confirmation.

See `install-grapheneos.sh` for the initial executable placeholder.

## Completion

Complete only when the exact device and installed OS are verified, the expected bootloader/security state is confirmed, and the privacy configuration/report is presented to the human.

## Tags

`#command` `#ai-command` `#install` `#android` `#pixel` `#grapheneos` `#privacy` `#device-provisioning`
