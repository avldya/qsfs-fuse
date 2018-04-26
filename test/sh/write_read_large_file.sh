#!/bin/bash
# +-------------------------------------------------------------------------
# | Copyright (C) 2018 Yunify, Inc.
# +-------------------------------------------------------------------------
# | Licensed under the Apache License, Version 2.0 (the "License");
# | You may not use this work except in compliance with the License.
# | You may obtain a copy of the License in the LICENSE file, or at:
# |
# | http://www.apache.org/licenses/LICENSE-2.0
# |
# | Unless required by applicable law or agreed to in writing, software
# | distributed under the License is distributed on an "AS IS" BASIS,
# | WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# | See the License for the specific language governing permissions and
# | limitations under the License.
# +-------------------------------------------------------------------------
#
#
# test case: read large file

set -o xtrace
set -o errexit

current_path=$(dirname "$0")
source "$current_path/utils.sh"

BIG_FILENAME="read-large-file.txt"
BIG_FILENAME_COPY="read-large-file-download.txt"
BIG_FILESIZE=$(( 25 * 1024 * 1024 ))
BIG_FILE="$QSFS_TEST_RUN_DIR/$BIG_FILENAME"
BIG_FILE_COPY="/tmp/$BIG_FILENAME_COPY"
BIG_TMPFILE="/tmp/${BIG_FILENAME}"

# write at first
dd if=/dev/urandom of="${BIG_TMPFILE}" bs=${BIG_FILESIZE} count=1
dd if="${BIG_TMPFILE}" of="${BIG_FILE}" bs=${BIG_FILESIZE} count=1

# read it
dd if="${BIG_FILE}" of="${BIG_FILE_COPY}" bs=${BIG_FILESIZE} count=1 iflag=nocache status=none

# verify
if [ ! cmp "${BIG_TMPFILE}" "${BIG_FILE_COPY}" ]; then
  echo "Error: expected the same file content for ${BIG_FILE} and ${BIG_TMPFILE}, got different"
  exit 1
fi

rm -f ${BIG_TMPFILE}
rm -f ${BIG_FILE_COPY}
rm_test_file ${BIG_FILENAME}