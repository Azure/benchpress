# Copyright 2015 gRPC authors.
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
"""The Python implementation of the GRPC helloworld.Greeter client."""

from __future__ import print_function

import logging

import grpc
import deployment_pb2
import deployment_pb2_grpc


def run():
    print("Will try to greet world ...")
    with grpc.insecure_channel('localhost:5152') as channel:
        stub = deployment_pb2_grpc.DeploymentStub(channel)
        req = deployment_pb2.DeploymentGroupRequest(
            bicep_file_path = '/Users/jessicaern/Projects/benchpress-private/engine/BenchPress.TestEngine.Tests/SampleFiles/storageAccount.bicep',
            resource_group_name = 'jern-benchpress-playground',
            subscription_name_or_id = '519c3e33-0884-4604-bad7-6964e6ef55f8'
            )
        response = stub.DeploymentGroupCreate(req)
    print("Success? " + response.success)
    print(response.error_message)


if __name__ == '__main__':
    logging.basicConfig()
    run()
