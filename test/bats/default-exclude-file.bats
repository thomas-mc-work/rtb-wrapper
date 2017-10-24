#!/usr/bin/env bats

@test "create a backup with excludes from default exclude file" {
  run /opt/rtb-wrapper.sh backup default-exclude-file
  echo ${lines[26]} > out.log
  [ "$status" -eq 0 ]
  [ "${lines[0]}" = "rsync_tmbackup: No previous backup - creating new one." ]
  [ "${lines[26]}" = "rsync_tmbackup: Backup completed without errors." ]

  run stat /target/latest/file1.txt
  [ "$status" -eq 1 ]
  
  run stat /target/latest/file2.txt
  [ "$status" -eq 0 ]

  run stat /target/latest/folder-a/file3.txt
  [ "$status" -eq 0 ]
}
