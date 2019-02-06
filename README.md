# Hedron

Hedron is an easy-to-use, OOP Crystal GUI library, that allows you to do the following:

- Create your own UI classes ("widgets") that fully integrate with existing classes
- A markup language (with extension `.hdml`), which makes creating UI easy
- Full integration with custom widgets and HDML, so you can inject your own widgets into your markup

Hedron is under active development, so check back often!

## Installation

1. Follow the instructions for installation laid out in [andlabs/libui](https://github.com/andlabs/libui).
2. Copy the compiled files from step 1 (i.e. files in `build/out`) to `/usr/lib` for OSX and Linux users.
3. Go to your `shard.yml` file, and enter this in:

```yaml
dependencies:
  hedron:
    github: hedron-crystal/hedron
    version: 0.1.0
```

## Acknowledgement

- [andlabs/libui](https://github.com/andlabs/libui), for providing the basic UI elements
- [Fusion/libui.cr](https://github.com/Fusion/libui.cr), for originally providing the libui bindings

## Contributors

- [Qwerp-Derp](https://github.com/Qwerp-Derp) Hanyuan Li - creator, maintainer
