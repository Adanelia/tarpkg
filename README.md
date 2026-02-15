# tarpkg

> en | [中文](README-CN.md)

- [Features](#features)
- [Installation](#installation)
- [Usage](#usage)
- [Important Notes](#important-notes)
- [License](#license)

------

tarpkg is a package manager designed to install and remove software packages archived in tar format.

## Features

- Install software packages from tar archives
- Uninstall previously installed packages
- Support various tar compressing format including gz, xz, bz, zst, etc.
- Verify file existence before installation/uninstallation
- Force mode for bypassing file checks (use with caution)

## Installation

```sh
git clone https://github.com/Adanelia/tarpkg.git && cd tarpkg
chmod +x tarpkg.sh
```
`./tarpkg.sh` can be run directly.

Or install it to `PATH` .
```sh
# user PATH
cp tarpkg.sh ~/.local/bin/tarpkg
# or system PATH
sudo cp tarpkg.sh /usr/local/bin/tarpkg
```
Then you can call `tarpkg` anywhere.

## Usage

### Install a package:

```sh
tarpkg -i example.tar.gz
```

### Uninstall a package:

```sh
tarpkg -r example.tar.gz
```

### List package contents:

```sh
tarpkg -l example.tar.gz
```

### Test package:

```sh
tarpkg -t example.tar.gz
```

### Force operation:

```sh
tarpkg -f -i example.tar.gz
tarpkg -f -r example.tar.gz
```

## Important Notes

- Use `sudo` when necessary
- Tar packages must contain files with paths that match system directory structure (e.g., `usr/local/bin/example`)
- Files are installed directly to the system root (`/`)
- The package manager will check for existing files before installation
- Use the force option only when you're certain you want to override existing files

## License

GPLv3
