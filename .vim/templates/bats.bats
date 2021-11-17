#!/usr/bin/env bats

setup() {
  test_file="./test.txt"
  touch "$test_file"
}

teardown() {
  rm -f "$test_file"
}

@test "addition using bc" {
  result="$(echo 2+2 | bc)"
  [ "$result" -eq 4 ]
}

@test "addition using bc (fail)" {
  result="$(echo 2+1 | bc)"
  [ "$result" -eq 4 ]
}

@test "check file" {
  [ -f "$test_file" ]
}

@test "skip test" {
  skip
  [ ! -f "$test_file" ]
}

@test "normal command" {
  ls
}
