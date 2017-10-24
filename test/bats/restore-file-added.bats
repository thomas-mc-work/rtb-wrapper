#!/usr/bin/env bats

setup () {
  # prepare backup
  /opt/rtb-wrapper.sh backup testcase-excludes-in-profile
}

@test "add a dirty file to the source and then restore with wipe" {
  # verify changed state
  [ -r "/target/latest/folder-a/file3.txt" ]
  [ ! -r "/target/latest/file2.txt" ]

  # prepare changed source
  echo "dirty" > "/source/dirty-file.txt"

  # verify change  
  [ -r "/source/dirty-file.txt" ]

  # actual test  
  run /opt/rtb-wrapper.sh restore testcase-excludes-in-profile
  [ "$status" -eq 0 ]

  [ ! -r "/source/dirty-file.txt" ]
}