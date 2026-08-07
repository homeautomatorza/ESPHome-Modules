<h1 align="center">
  <img src=".github/images/logo.png" alt="HAZA ESPHome Modular Framework" width="100" align="absmiddle"> <span style="font-size:2em; font-weight:bold">Home Automator ZA <br/> ESPHome Modular Framework</span>
</h1>

<span align="center">

![GitHub License](https://img.shields.io/github/license/homeautomatorza/ESPHome-Modules)
![GitHub Repo Stars](https://img.shields.io/github/stars/homeautomatorza/ESPHome-Modules?style=flat)
![GitHub Contributors](https://img.shields.io/github/contributors/homeautomatorza/ESPHome-Modules)
![GitHub Last Commit](https://img.shields.io/github/last-commit/homeautomatorza/ESPHome-Modules)

[![version](https://img.shields.io/badge/version-2026.0.0-success.svg)](wiki/changelog.md)
![GitHub Issues](https://img.shields.io/github/issues/homeautomatorza/ESPHome-Modules)
![GitHub Issues](https://img.shields.io/github/issues-closed/homeautomatorza/ESPHome-Modules)

[![Home Assistant](https://img.shields.io/badge/Home_Assistant-2026.0.0_+-41BDF5.svg)](https://www.home-assistant.io/)
[![ESPHome](https://img.shields.io/badge/ESPHome-2026.7.0_+-000000.svg)](https://esphome.io/)

</span>

A practical best-practice framework for ESPHome that helps makers build IoT devices faster, with reusable modules, clearer patterns, less guesswork for beginners, and guidance for troubleshooting common issues.

---

> [!WARNING]
> This code comes with an "it works on my setup" guarantee, a.k.a. use it at your own risk.
>

---

## Disclaimer

- This project is under **very active** development, at least in the dev branch.
- Expect bugs, rough edges, and breaking changes.

---

## Quick Start

### Download the ZIP

Download the latest ZIP file from the Code button above and copy the modules you need into your ESPHome setup.
Find the instructions [here](wiki/installation.md#zip).

### Clone the repository

Clone the project from the Code button above, or use your favourite Git software, when you want to keep the framework available locally.
Find the instructions [here](wiki/installation.md#clone).

### Use remotely

Reference this repository directly from ESPHome packages when you want to pull modules from GitHub without copying the files by hand.
Find the instructions [here](wiki/installation.md#remote).

---

## Minimum Requirements

- ESPHome installed and working.
- A compatible ESP32 or ESP8266 board.
- A way to edit YAML files, such as Visual Studio Code.
- A USB cable or other supported flashing method for your board.

Git is recommended if you want to clone the repository or keep your local copy updated, but it is not required if you use the ZIP download method.

See the [System Requirements wiki page](wiki/system-requirements.md) for more details.

---

## About

As an enterprise architect, software developer, and hardware tinkerer, I found ESPHome easy to start with but harder to maintain as my devices grew. Too many projects relied on repeated copy-paste blocks, and small changes quickly became difficult to track across multiple devices.

This framework grew out of that problem. ESPHome packages made it possible to write a module once, reuse it across devices, and still add or remove features at the device file level when a project needed something different.

What started as a personal modular setup grew alongside the Home Automator ZA YouTube channel and became a passion project for anyone who wanted a more structured way to build with ESPHome. The 2026 version is being reviewed, reorganized, documented at module level, and supported by a dedicated wiki.

And yes, this is the same framework I use for my own projects.

Read more in the [About wiki page](wiki/about.md).

---

## The YouTube Channel

[![Watch the video](.github/images/Splash_Screen_1_1.jpg)](https://youtube.com/playlist?list=PLJ3MNJX_MOUnMWzUNDatN3LWAN8l99v5I)

---

## Features

- **Reusable ESPHome packages:** Build devices from shared board, network, display, sensor, and peripheral modules instead of repeating the same YAML in every project.
- **Less copy-paste, fewer mistakes:** Fix common logic in one module and reuse it across multiple devices, instead of hunting the same bug through several device files.
- **Faster project starts:** Use boilerplates and cookbook projects as working starting points for common ESPHome builds.
- **Modular by design:** Add, remove, or override features at the device file level while keeping the reusable parts clean and consistent.
- **Board-aware structure:** Keep board defaults, pins, flash settings, and hardware notes separate from sensors, peripherals, and project-specific behavior.
- **Common building blocks:** Share Wi-Fi, Ethernet, Bluetooth, web server, time, display, colour, font, and core settings across projects.
- **Documented module intent:** Module headers and wiki pages are being rebuilt so each reusable part explains what it does, where it belongs, and what still needs validation.
- **Honest validation model:** Config and compile checks are useful evidence, but hardware testing is tracked separately so the project does not claim more certainty than it has.
- **Cookbook-friendly workflow:** Real projects can become practical examples that show how the framework pieces fit together in a complete ESPHome device.

---

## Documentation

Documentation is being rebuilt alongside the 2026 framework cleanup.

- Start with the [wiki home page](wiki/Home.md) for the public documentation structure.
- Use the [installation guide](wiki/installation.md) for ZIP, clone, and remote package options.
- Check the [system requirements](wiki/system-requirements.md) before building your first device.
- Browse the [module catalogue](wiki/module-catalogue.md) as reusable boards, common packages, peripherals, and sensors are documented.
- Read the [validation guide](wiki/validation.md) to understand the difference between config checks, compile checks, and real hardware testing.

The wiki is still a work in progress, so some pages are placeholders until the related modules and projects have been reviewed.

---

## Roadmap

I am currently rebuilding my own projects against this version of the framework so they can be cleaned up, validated, and documented properly.

Once that work is further along, I will publish a public roadmap that people can vote on. In the meantime, suggestions and ideas for future [cookbook projects](recipes/projects/README.md) are welcome.

Please [open an issue](https://github.com/homeautomatorza/ESPHome-Modules/issues) and mark it as a cookbook suggestion.

Read more in the [Roadmap wiki page](wiki/roadmap.md).

---

## Contributing

Contributions are welcome, especially tested modules, documentation fixes, cookbook ideas, and clear bug reports.

Please read [CONTRIBUTING.md](CONTRIBUTING.md) before opening a pull request.

---

## Bugs

Found a bug, broken example, stale module, or confusing bit of documentation?

Please [open an issue](https://github.com/homeautomatorza/ESPHome-Modules/issues).

> [!TIP]
> Include the board, module, ESPHome version, what you expected, and what actually happened.

> [!IMPORTANT]
> Please remove Wi-Fi details, API keys, tokens, private hostnames, and other secrets before sharing logs or YAML.

Read more in the [Bugs wiki page](wiki/bugs.md).

---

## Updates

Version notes, module changes, breaking changes, and rebuild progress will be tracked in the [Wiki Changelog page](wiki/changelog.md).

---

## Acknowledgments

- **Nabu Casa** and **The Open Home Foundation**: For supporting the open home ecosystem that makes projects like this possible.
- **The ESPHome community**: For the tools, examples, ideas, and shared knowledge that make ESPHome such a practical platform to build on.
- **My wife**: For the patience, support, and space that make it possible for me to keep working on this passion project.

---

## Contact

Questions, build ideas, or want to share a project?

- For bugs or broken examples, please [open an issue](https://github.com/homeautomatorza/ESPHome-Modules/issues).
- For questions, project ideas, or cookbook suggestions, please open an issue and mark it clearly in the title or description.
- For general discussion, use [GitHub Discussions](https://github.com/homeautomatorza/ESPHome-Modules/discussions) when available.

> [!IMPORTANT]
> Please do not share Wi-Fi details, API keys, tokens, private hostnames, or other secrets in public issues or discussions.

---

## Licence

This project uses CC0 1.0 Universal unless a file says otherwise. Keep licence metadata in module headers aligned with the project licence unless a file has a specific reason to use different terms.

See [`LICENSE`](LICENSE) for the full licence text.

Read more in the [Licence wiki page](wiki/licence.md).

---

> **Trademark & Branding Notice**: CC0 applies to the project files, but it does not grant permission to use the project name, "Home Automator ZA", logos, app icons, or branding in derivative works or redistributions. Modified versions or redistributions must remove or replace official project branding.
