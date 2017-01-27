#
# Created by menzelmi on 24/01/2017.
#
class BucketViewerController

  constructor: (S3) ->
    @prefix = ''
    @bucketName = 's3-bucket-viewer-demo'
    @s3 = S3
    @refresh()

  home: =>
    @prefix = ''
    @refresh()

  open: (prefix) =>
    @prefix = @prefix + prefix
    @refresh()

  close: =>
    @prefix = @prefix.slice(0, -1) if @prefix.slice(-1) is '/'
    @prefix = @prefix.substr(0, @prefix.lastIndexOf('/') + 1)
    @refresh()

  refresh: =>
    console.log "checking for bucket #{@bucketName} with prefix #{@prefix}"
    @s3.list(@bucketName, @prefix).then((data) =>
      @files = data
        .map (el) =>
          el.Key = el.Key.substr(@prefix.length)
          el
        .map (el) =>
          if el.Key.indexOf('/') > -1
            el.type = 'folder'
            el.Key = el.Key.substr(0, el.Key.indexOf('/') + 1)
          else
            el.type = 'file'
            el.Key = el.Key.substr(el.Key.lastIndexOf('/') + 1)

          el.url = @s3.downloadLink(@bucketName, @prefix  + el.Key)
          el
        .reduce((a, b) ->
          a.push(b) if a.map((el) -> el.Key).indexOf(b.Key) < 0
          a
        , [])
    )



angular.module('DemoApp').component('bucketViewer',
#Note: The URL is relative to our `index.html` file
  templateUrl: 'components/bucket-viewer.template.html'
  controller: ['S3', BucketViewerController]
)