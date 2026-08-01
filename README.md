# HAZA ESPHome Modular Framework

HAZA, or Home Automator ZA, this project is Pascal Parent's ESPHome modular
framework. It is being rebuilt as a practical cookbook of reusable ESPHome
boards, common packages, peripherals, sensors, and project recipes that are
cleaned up, validated, documented, and proven from real use.

The original project is here:

- YouTube: https://www.youtube.com/@homeautomatorza
- Original modules: https://github.com/homeautomatorza/ESPHome-Modules

## Current State

This repository is being reset around physical validation and project recipes.
Automated ESPHome config and compile checks are useful evidence, but they do not
make a module `Tested`. A module becomes public-ready only after Pascal has used
it on real hardware and approved the user-facing documentation.

The large historical `documentation/` tree has been temporarily removed from the
public repository while the cookbook is rebuilt. The old material is preserved
locally in the ignored workbench so useful notes can be reused, corrected, or
discarded as each project is physically tested.

## Public Folders

| Path | Purpose |
| --- | --- |
| `boards/` | Board package files and hardware defaults. |
| `common/` | Shared core, display, network, and time packages. |
| `fonts/` | Font assets used by display packages. |
| `peripherals/` | Reusable peripheral packages. |
| `recipes/` | Boilerplates, focused samples, and future cookbook projects. |
| `sensors/` | Reusable sensor packages grouped by bus or type. |
| `sample_secrets.yaml` | Public example of required secret keys. |

Local workbench content is intentionally ignored by git. Unfinished modules,
draft documentation, private validation devices, and archived notes stay under
`local_workbench/` until they are ready for review and promotion.

## Cookbook Workflow

Documentation will be rebuilt project by project.

For each new cookbook project:

1. Physically test the board, sensors, peripherals, and common packages used by
   the project.
2. Create or revisit the documentation for every component in that project.
3. If a module has no documentation, draft the first version from the file
   frontmatter and header.
4. Show the draft documentation to Pascal for additions, corrections, and
   approval.
5. Publish only the approved documentation for that project and its components.
6. Record compatibility honestly: automated checks remain `Needs validation`;
   physical hardware proof is required before anything is called `Tested`.

This keeps the cookbook useful without forcing every module to be documented up
front. Many projects share the same boards and sensors, so approved component
documentation can be reused and improved as the cookbook grows.

## AI Transparency

This is a human-led, AI-assisted project.

Pascal lives with CRPS, which limits how much hands-on development and writing he
can do in one sitting. He uses ChatGPT Codex as a practical assistant so he can
continue working on ESPHome, Home Assistant, IoT, home automation, education, and
knowledge sharing.

Codex helps with tasks such as spelling, cleanup, refactoring, debugging,
validation runs, documentation drafts, and Kanban tracking. That includes this
README, which was drafted with AI assistance and then reviewed and edited by
Pascal.

The ideas, project direction, hardware choices, and final decisions remain
Pascal's. Most of these projects existed, or were planned, before AI became part
of his workflow. AI may help express, organize, and test the work, but it does
not replace Pascal's engineering judgement or physical hardware validation.

If you communicate with Pascal through any public channel, you are communicating
with Pascal. AI may help him with spelling, formatting, or drafting, but the
voice, decisions, and accountability remain his.

Pascal also plans to relaunch his personal site,
http://www.onlyinsouthafrica.com, where he will share more about this and other
projects. For now, the focus is this ESPHome framework and the cookbook that will
grow from it.

## Validation Framework

This project uses layered validation. Each layer answers a different question,
and no single layer replaces the others.

1. **Structure review:** files are checked for spelling, naming, folder
   placement, package shape, headers, substitutions, and obvious copy/paste
   errors.
2. **ESPHome config validation:** `esphome config` confirms that ESPHome can
   parse and resolve the YAML for the selected validation profile.
3. **ESPHome compile validation:** `esphome compile` confirms that the generated
   firmware can build for the selected board or profile.
4. **Physical validation:** Pascal tests the module on real hardware, with the
   actual board, sensor, peripheral, wiring, and project context.
5. **Documentation approval:** user-facing documentation is drafted, edited, and
   reviewed by Pascal before publication.

Automated checks can prove that a file parses and compiles. They cannot prove
that a sensor is wired correctly, calibrated correctly, physically accurate, or
useful in a real Home Assistant project. For that reason, automated success is
recorded as `Needs validation`. The word `Tested` is reserved for physical
hardware validation by Pascal.

AI support helps keep the validation work organized:

- inspecting modules for consistency, stale references, and incomplete work
- running and summarizing ESPHome config and compile checks
- tracking unfinished work that remains in `local_workbench/`
- drafting documentation from file frontmatter and headers
- keeping Kanban follow-up items and compatibility evidence aligned
- flagging calibration, physical validation, and Pascal approval gaps

Unfinished or experimental modules stay in `local_workbench/`. Public promotion
requires implementation, examples, documentation, validation evidence, and
Pascal approval.

## Secrets

Use `sample_secrets.yaml` as the public reference for required secret keys.
Create a local `secrets.yaml` in the repository root for real values. Do not
commit real passwords, tokens, API keys, WiFi credentials, or private network
details.

## Licence

The original ESPHome Modules project uses CC0 1.0 Universal. Keep licence
metadata in module headers aligned with the project licence unless a file has a
specific reason to do otherwise.

See `LICENSE` for the full licence text.
