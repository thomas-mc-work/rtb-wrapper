# rtb-wrapper: rsync-time-backup wrapper [![Build Status](https://travis-ci.org/thomas-mc-work/rtb-wrapper.svg?branch=master)](https://travis-ci.org/thomas-mc-work/rtb-wrapper)

You know and love the well known __[rsync-time-backup](https://github.com/laurent22/rsync-time-backup)__ from
[Laurent Cozic aka laurent22](https://github.com/laurent22)! Now what could be missing since this is a mature 
project? The whole thing based on separate profile files per backup case!

Consider this example __profile__ (named `user1-documents.inc`):

    SOURCE="${HOME}/Documents"
    TARGET="/mnt/backup-disk/Documents"
    EXCLUDE_FILE="/home/user1/opt/backup-documents-excludes.lst"

Now it's as easy as this to __backup__ our data:

    rtb-wrapper.sh backup user1-documents 

And here is how to __restore__:

    rtb-wrapper.sh restore user1-documents

## Requirements

- [rsync-time-backup](https://github.com/laurent22/rsync-time-backup)
  - rsync

## Setup

    # prepare the users bin folder and the profile folder
    mkdir -p "${HOME}/bin" "${HOME}/.rsync_tmbackup/conf.d"
    # download the script
    curl -o "${HOME}/bin/rtb-profile.sh "https://github.com/thomas-mc-work/rtb-profile/raw/master/rtb-profile.sh"

## Configuration

`rtb-wrapper` is using `$HOME/.rsync_tmbackup` as the base config folder, except it's overridden by the env 
variable `CONFIG_DIR`.

### Basic config file

`$HOME/.rsync_tmbackup/config.inc`: It contains the default executables for the respective jobs

    # the path to your rsync-tmbackup script, including custom parameters
    BASE_CMD_BACKUP="${HOME}/opt/rsync-tmbackup/rsync_tmbackup.sh"
    # the restore command including all desired parameters (e.g. --dry-run)
    BASE_CMD_RESTORE="rsync -aP"

### Profile file(s)

`$HOME/.rsync_tmbackup/conf.d/*.inc`: The backup profiles, one per file

    # the source folder
    SOURCE="${HOME}/Documents"
    # the target folder
    TARGET="/media/user1/backup-disk/Documents"
    # optional: the exclude file for rsync
    EXCLUDE_FILE="${HOME}/backup-documents-excludes.lst"
    # optional: wipe the source folder before restoring files? (true/false; default: false)
    WIPE_SOURCE_ON_RESTORE=true

## Development

### Testing

There are some tests written with [bats](https://github.com/sstephenson/bats) to verify your changes:

```bash
./run-tests.sh
```