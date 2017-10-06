#!/usr/bin/env bats

@test "create a backup with excludes" {
  run /opt/rtb-wrapper.sh backup testcase-1
  [ "$status" -eq 0 ]
  [ "${lines[0]}" = "rsync_tmbackup: No previous backup - creating new one." ]
#  [ "${lines[11]}" = "Number of files: 4 (reg: 2, dir: 2)" ]
  [ "${lines[26]}" = "rsync_tmbackup: Backup completed without errors." ]

  run stat /target/latest/folder-a/file3.txt
  [ "$status" -eq 0 ]

  run stat /target/latest/file2.txt
  [ "$status" -eq 1 ]
}

  echo "----- ${lines[26]} ---" >&2

@test "remove a file from the source and change another one" {
  echo "changed-1" > /source/file1.txt
  rm -rf /source/folder-a
  rm /source/file2.txt
  
  run /opt/rtb-wrapper.sh restore testcase-1
  [ "$status" -eq 0 ]

  run md5sum /source/file1.txt
  [ "$output" = "e6bbb3095edb03733dfa4e6dd9962cfb  /source/file1.txt" ]

  # still gone
  run stat /source/file2.txt
  [ "$status" -eq 1 ]

  run md5sum /source/folder-a/file3.txt
  [ "$output" = "f1aad22b17992651f9fbf60c5ebd9920  /source/folder-a/file3.txt" ]
}

@test "add a dirty file to the source and then restore with wipe" {
  echo "dirty" > /source/dirty-file.txt
  
  run stat /source/dirty-file.txt
  [ "$status" -eq 0 ]
  
  run /opt/rtb-wrapper.sh restore testcase-1
  [ "$status" -eq 0 ]

  run stat /source/dirty-file.txt
  [ "$status" -eq 1 ]
}