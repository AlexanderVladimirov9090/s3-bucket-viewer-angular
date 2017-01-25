#
# Created by menzelmi on 24/01/2017.
#
class BucketViewerController
  constructor: (S3) ->
    console.log "s3 is #{JSON.stringify(S3)}"
    S3.list('s3-bucket-viewer-demo').then((data) =>
      @files = data.map((el) ->
        el.url = S3.downloadLink('s3-bucket-viewer-demo', el.Key)
        el
      )
    )


angular.module('DemoApp').component('bucketViewer',
#Note: The URL is relative to our `index.html` file
  templateUrl: 'components/bucket-viewer.template.html'
  controller: ['S3', BucketViewerController]
)