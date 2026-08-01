# Recipes

This folder is reserved for reusable boilerplates, complete example device
projects, and smaller samples that show how the reusable modules fit together.

Keep real secrets out of examples. Use substitutions, package includes, and
references to `sample_secrets.yaml` where credentials or private network details
would otherwise be needed.

Use `common/network/wifi_dynamicip.yaml` as the default WiFi package for public
samples. Use `common/network/wifi_fixedip.yaml` only when the example is
intentionally demonstrating static networking.

Use `recipes/boilerplates/` for reusable starter device files that still need
board, network, or package choices before becoming complete examples.

Use `recipes/projects/` for fully cooked, end-to-end device builds.

Use `recipes/samples/` for smaller focused examples and learning snippets.

## Boilerplate Standard

Boilerplates are the starter files most users will copy first, so they should be
consistent, predictable, and beginner-friendly.

Use this structure for boilerplate YAML files:

1. File header.
2. Substitutions.
3. Packages.
4. ESPHome overrides or project metadata.
5. Remove or override package defaults.
6. Add custom peripherals.
7. Add custom sensors.
8. Add custom local logic.

Inside `packages:`, keep package types grouped in this order:

1. Core packages.
2. Network packages.
3. Board package.
4. Peripheral packages.
5. Sensor packages.

Public boilerplates should default to dynamic WiFi:

```yaml
wifi_dynamicip: !include ../../common/network/wifi_dynamicip.yaml
```

Use fixed IP examples only when the recipe is specifically demonstrating static
networking, or when a private workbench device needs it.

Boilerplates should compile with minimal edits wherever possible. If a
boilerplate needs user-specific changes before compiling, call that out in the
header notes.

Prefer reusable board, peripheral, and sensor packages before adding custom YAML.
Use the `Add Custom ...` sections when a reusable package would be awkward,
misleading, or too device-specific, such as a garage door controller.

Keep the visible sections even when they only contain comments. That makes the
copy/paste pattern easier for new users to follow.
