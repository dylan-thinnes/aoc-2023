#!/usr/bin/env bash
tmp=$(mktemp)
for i in `seq 1000000`; do
  sed "/total/d;/exit/d;s/glob_adjacent_pipes\^:_/glob_adjacent_pipes^:$i/" j/sol1.j >$tmp
  echo result | jconsole $tmp | ./to-unicode
done
