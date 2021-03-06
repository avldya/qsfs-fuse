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
# test case: sequence write in parallel

set -o xtrace
set -o errexit

current_path=$(dirname "$0")
source "$current_path/utils.sh"
cd $QSFS_TEST_RUN_DIR

WORK_DIR_NAME="write_file_sequence_parallel"
mk_test_dir ${WORK_DIR_NAME}

THREADS=20
FILENAME_TXT="${WORK_DIR_NAME}/write-sequence-parallel.txt"

append_test_file_parallel $FILENAME_TXT $THREADS

# cleanup
rm_test_file $FILENAME_TXT
rm_test_dir ${WORK_DIR_NAME}