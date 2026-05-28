# Validation

This project uses a repo-local Python virtual environment for ESPHome validation.
The environment lives in `.venv/` and is intentionally ignored by git.

## Create The Environment

```bash
uv venv
uv pip install --prerelease allow --upgrade -r requirements_dev.txt
```

The `--prerelease allow` flag is intentional. This rebuild should track current
ESPHome releases and beta releases so compatibility issues are found early.

## Run The CLI

```bash
.venv/bin/esphome version
```

Initial local verification on 2026-05-11:

```text
Python 3.13.13
ESPHome 2026.4.5
```

Latest local validation environment refresh on 2026-05-25:

```text
ESPHome 2026.5.1
```

The 2026.5.1 refresh was done to validate newer audio components, including
SendSpin.

## Module Compatibility Notes

For modules that rely on newer or experimental ESPHome components, record the
minimum and recommended validation version in the module header:

```yaml
# Compatibility:
#     - Minimum ESPHome: 2026.5.1
#     - Recommended ESPHome: 2026.5.1 or newer
```

Use the minimum version for the oldest version expected to compile, and the
recommended version for the version currently used in this repo-local validation
environment.

For native ESPHome enforcement, add `min_version` under the `esphome:` block in
the device or package that requires the newer feature:

```yaml
esphome:
  min_version: 2026.5.1
```

This causes `esphome config` and `esphome compile` to fail when the installed
ESPHome version is too old.

For a visible compatibility note before validation or compile, use the project
wrapper:

```bash
ruby tools/esphome_with_notes.rb config local_workbench/devices/<device_name>/device.yaml
ruby tools/esphome_with_notes.rb compile local_workbench/devices/<device_name>/device.yaml
```

The wrapper prints `Compatibility` blocks from the target file and local included
packages, then delegates to `.venv/bin/esphome`.

When sample projects are available, validate them with:

```bash
.venv/bin/esphome config sample_projects/<device>.yaml
```

## Notes

- `.venv/` is local to this repository.
- Deleting `.venv/` removes the installed CLI environment.
- This environment does not change system Python, Home Assistant, or any other
  ESPHome installation.
