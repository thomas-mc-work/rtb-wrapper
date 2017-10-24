#!/usr/bin/env bats

@test "backup without excludes" {
  run /opt/rtb-wrapper.sh backup testcase-no-excludes
  [ "$status" -eq 0 ]
  [ "${lines[0]}" = "rsync_tmbackup: No previous backup - creating new one." ]
  [ "${lines[27]}" = "rsync_tmbackup: Backup completed without errors." ]

  [ -r "/target/latest/file1.txt" ]
  [ -r "/target/latest/file2.txt" ]
  [ -r "/target/latest/folder-a/file3.txt" ]
}
