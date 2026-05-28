# Documentation

This folder is the working documentation set for the ESPHome Modular Rebuild
2026 project.

## Reference Documents

- [Compatible boards](compatibilities/boards.md)
- [Header samples](headers/header.md)
- [Project structure](project_structure.md)
- [Changelogs](changelogs/README.md)
- [Deferred components](deferred_components/README.md)

## Secrets

The root `secrets.yaml` file is intentionally ignored by git. Use
`../sample_secrets.yaml` as the reference file for required secret keys.

## Documentation Principles

- Keep current behaviour separate from historical notes.
- Preserve compatibility and changelog history.
- Mark untested modules plainly.
- Prefer examples that can be copied into real ESPHome YAML with minimal edits.
- Update documentation in the same change as module behaviour changes.
