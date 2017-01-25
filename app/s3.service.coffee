#
# Created by menzelmi on 24/01/2017.
#
angular.module('DemoApp').factory('S3', ['$q', ($q) ->
  list: (bucketName) ->
    filesDefer = $q.defer()
    AWS.config.region = 'eu-central-1'
    AWS.config.credentials = new AWS.CognitoIdentityCredentials(
      IdentityPoolId: 'eu-central-1:68658909-d15f-4579-a7cb-b1d61670e7ce'
    )
    new AWS.S3().listObjects({Bucket: bucketName}, (err, data) ->
      console.log "yay!!! with #{JSON.stringify(data)}"
      if err?
        console.log "error: #{err}"
        filesDefer.reject(err)
      else
        filesDefer.resolve(data.Contents)
    )
    filesDefer.promise

])