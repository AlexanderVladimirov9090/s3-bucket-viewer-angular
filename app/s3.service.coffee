#
# Created by menzelmi on 24/01/2017.
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