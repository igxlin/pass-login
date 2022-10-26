# pass-login

A [pass](https://www.passwordstore.org/) extension for extracting usernames.

The extension looks for the following fields by order:

- The second column in any line beginning with `login:`, `Login:`,
  `Username:`, `username:`.
- The path of the pass file.

## Usage

```
Usage:
    pass login [--clip,-c] pass-name
        Show existing username and optionally put it on the clipboard.
        If put on the clipboard, it will be cleared in 45 seconds.
    pass help
        Show this text.

More information may be found in the pass-login(1) man page.
```

## Installation

### Manually

```bash
git clone https://github.com/igxlin/pass-login.git
cd pass-login
sudo make install
```

### macOS

Homebrew:

```bash
brew tap igxlin/tap
brew install pass-login
```
