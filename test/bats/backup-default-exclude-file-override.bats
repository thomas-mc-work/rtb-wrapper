#!/usr/bin/env bats

@test "backup with default exclude file overriden by profile definition" {
  run /opt/rtb-wrapper.sh backup default-exclude-file-override
  echo ${lines[26]} > out.log
  [ "$status" -eq 0 ]
  [ "${lines[0]}" = "rsync_tmbackup: No previous backup - creating new one." ]
  [ "${lines[26]}" = "rsync_tmbackup: Backup completed without errors." ]

  [ -r "/target/latest/file1.txt" ]
  [ ! -r "/target/latest/file2.txt" ]
  [ -r "/target/latest/folder-a/file3.txt" ]
}
