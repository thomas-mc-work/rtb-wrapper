#!/usr/bin/env bats

setup () {
  # prepare backup
  /opt/rtb-wrapper.sh backup testcase-1
}

@test "add a dirty file to the source and then restore with wipe" {
  # verify changed state
  run stat /target/latest/folder-a/file3.txt
  [ "$status" -eq 0 ]

  run stat /target/latest/file2.txt
  [ "$status" -eq 1 ]

  # prepare changed source
  echo "dirty" > "/source/dirty-file.txt"
  
  # actual test
  run stat /source/dirty-file.txt
  [ "$status" -eq 0 ]
  
  run /opt/rtb-wrapper.sh restore testcase-1
  [ "$status" -eq 0 ]

  run stat /source/dirty-file.txt
  [ "$status" -eq 1 ]
}