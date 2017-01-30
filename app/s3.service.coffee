#
#    Copyright 2017 Dr. Michael Menzel, Amazon Web Services Germany GmbH
#
#   Licensed under the Apache License, Version 2.0 (the "License");
#   you may not use this file except in compliance with the License.
#   You may obtain a copy of the License at
#
#       http://www.apache.org/licenses/LICENSE-2.0
#
#   Unless required by applicable law or agreed to in writing, software
#   distributed under the License is distributed on an "AS IS" BASIS,
#   WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
#   See the License for the specific language governing permissions and
#   limitations under the License.
#
class S3Client
  constructor: ->
    AWS.config.region = 'eu-central-1'
    AWS.config.credentials = new AWS.CognitoIdentityCredentials(
      IdentityPoolId: 'eu-central-1:68658909-d15f-4579-a7cb-b1d61670e7ce'
    )
    @s3 = new AWS.S3()

  client: ->
    @s3


s3Client = new S3Client().client()

angular.module('DemoApp').factory('S3', ['$q', ($q) ->
  list: (bucketName, prefix) ->
    filesDefer = $q.defer()

    s3Client.listObjects({Bucket: bucketName, Prefix: prefix}, (err, data) ->
      if err?
        console.log "error: #{err}"
        filesDefer.reject(err)
      else
        filesDefer.resolve(data.Contents)
    )
    filesDefer.promise


  downloadLink: (bucketName, objectName) ->
    s3Client.getSignedUrl('getObject', {Bucket: bucketName, Key: objectName, Expires: 300})

])