# rtb-wrapper - declarative rsync-time-backup [![Build Status](https://travis-ci.org/thomas-mc-work/rtb-wrapper.svg?branch=master)](https://travis-ci.org/thomas-mc-work/rtb-wrapper)

You know and love the well known __[rsync-time-backup](https://github.com/laurent22/rsync-time-backup)__ from
[Laurent Cozic aka laurent22](https://github.com/laurent22)! Now what could be missing since this is a mature
project? The whole thing based on separate profile files per backup case!

__Example:__

Consider this example __profile__ (named `user1-documents.inc`):

    SOURCE="${HOME}/Documents"
    TARGET="/mnt/backup-disk/Documents"
    EXCLUDE_FILE="/home/user1/opt/backup-documents-excludes.lst"

Now it's as easy as this to __backup__ our data:

    rtb-wrapper.sh backup user1-documents

And here is how to __restore__ from the `latest` backup:

    rtb-wrapper.sh restore user1-documents

## Requirements

- [rsync-time-backup](https://github.com/laurent22/rsync-time-backup)
  - rsync

## Setup

    # prepare the profile folder
    mkdir -p "${HOME}/.rsync_tmbackup/conf.d"
    # download the script
    curl -Lo "/usr/local/bin/rtb-wrapper.sh" "https://raw.githubusercontent.com/thomas-mc-work/rtb-wrapper/master/rtb-wrapper.sh"
    # mark the script executable
    chmod +x "/usr/local/bin/rtb-wrapper.sh"

## Configuration

`rtb-wrapper` is using `$HOME/.rsync_tmbackup` as the base config folder, except it's overridden by the environment variable `RTB_CONFIG_DIR`.

### Profile file

`$HOME/.rsync_tmbackup/conf.d/<profile-name>.inc`: The backup profiles, one per file

    # the source folder
    SOURCE="${HOME}/Documents"
    # the target folder
    TARGET="/media/user1/backup-disk/Documents"
    # optional: the exclude file for rsync
    EXCLUDE_FILE="${HOME}/backup-documents-excludes.lst"
    # optional: wipe the source folder before restoring files? (true/false; default: false)
    WIPE_SOURCE_ON_RESTORE=true

### Exclude file

Alternatively you can define the exlcude file also by placing it next to the profile file. Following the convention:

    ${HOME}/.rsync-tmbackup/conf.d/<profile-name>.inc
    ${HOME}/.rsync-tmbackup/conf.d/<profile-name>.excludes.lst

This exclude file definition will be overriden by the definition within the profile.

## Development

### Testing

There are some tests written with [bats](https://github.com/sstephenson/bats) to verify your changes:

```bash
./run-tests.sh
```
