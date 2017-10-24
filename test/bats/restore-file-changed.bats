#!/usr/bin/env bats

setup () {
  # create backup
  /opt/rtb-wrapper.sh backup testcase-1

  # manipulate source
  echo "changed-1" > /source/file1.txt
  rm /source/file2.txt
  rm -rf /source/folder-a
}

@test "remove a file from the source and change another one" {
  # verify not present
  run stat /source/folder-a/file3.txt
  [ "$status" -eq 1 ]

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