#!/usr/bin/env bats

@test "backup with excludes defined in profile" {
  run /opt/rtb-wrapper.sh backup testcase-excludes-in-profile
  [ "$status" -eq 0 ]
  [ "${lines[0]}" = "rsync_tmbackup: No previous backup - creating new one." ]
  [ "${lines[26]}" = "rsync_tmbackup: Backup completed without errors." ]

  [ -r "/target/latest/folder-a/file3.txt" ]
  [ ! -r "/target/latest/file2.txt" ]
}
