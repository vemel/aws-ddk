#!/usr/bin/env bash
# Copyright 2022 Amazon.com, Inc. or its affiliates. All Rights Reserved.
#
# Licensed under the Apache License, Version 2.0 (the "License").
# You may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

set -ex

isort --check .
black --check .

pip install 'boto3-stubs[codecommit,cloudformation,sts]'
for DIR in "cli" "core"
do
  mypy --install-types --non-interactive ${DIR}
done

flake8 .
doc8 --ignore D002,D005 --max-line-length 120 docs/source
cfn-lint -t cli/aws_ddk/data/cloudformation_templates/*