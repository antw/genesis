#!/usr/bin/env bash

# From RVM:
#
# Copyright (c) 2009-2011 Wayne E. Seguin
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

if [[ -n "${ZSH_VERSION:-""}" ]] ; then __array_start=1 ; else __array_start=0 ; fi

# Usage: contains "a_string" "${an_array[@]}"
array_contains()
{
  local pattern="$1" ; shift
  local index list
  list=("$@")
  for index in "${!list[@]}" ; do
    [[ ${list[index]} = $pattern ]] && { echo $index ; return 0 ; }
  done
  echo -1 ; return 1
}

array_length()
{
  array=$1
  eval "length=\${#${array}[*]}"
  echo $length
  return $length
}

array_push()
{
  array=$1 ; item=$2
  # TODO: allow loop over more arguments.
  eval "index=\$((\${#${array}[*]} + $__array_start))"
  eval "${array}[${index}]=${item}"
}
