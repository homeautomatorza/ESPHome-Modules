# Sample Projects

This folder is reserved for complete example device configurations and starter
projects that show how the reusable modules fit together.

Keep real secrets out of examples. Use substitutions, package includes, and
references to `sample_secrets.yaml` where credentials or private network details
would otherwise be needed.

Use `common/network/wifi_dynamicip.yaml` as the default WiFi package for public
samples. Use `common/network/wifi_fixedip.yaml` only when the example is
intentionally demonstrating static networking.

Use `sample_projects/board_templates/` for reusable starter device files that still
need board, network, or package choices before becoming complete examples.
