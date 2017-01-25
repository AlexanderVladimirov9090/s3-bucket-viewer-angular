#
# Created by menzelmi on 24/01/2017.
#
class BucketViewerController

  constructor: (S3) ->
    bucketName = 's3-bucket-viewer-demo'
    S3.list(bucketName).then((data) =>
      @files = data.map((el) ->
        el.url = S3.downloadLink(bucketName, el.Key)
        el
      )
    )


angular.module('DemoApp').component('bucketViewer',
#Note: The URL is relative to our `index.html` file
  templateUrl: 'components/bucket-viewer.template.html'
  controller: ['S3', BucketViewerController]
)