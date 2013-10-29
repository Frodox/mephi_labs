#!/bin/bash
awk '!(x[$1]++ && /^A.*ko .*$/)' Ttel
