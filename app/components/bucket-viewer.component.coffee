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
class BucketViewerController

  constructor: (S3, $scope) ->
    @scope = $scope
    @s3 = S3
    @currentPrefix = ''

  $onInit: =>
    @refresh()

  home: =>
    @currentPrefix = ''
    @refresh()

  open: (prefix) =>
    @currentPrefix = @currentPrefix + prefix
    @refresh()

  close: =>
    @currentPrefix = @currentPrefix.slice(0, -1) if @currentPrefix.slice(-1) is '/'
    @currentPrefix = @currentPrefix.substr(0, @currentPrefix.lastIndexOf('/') + 1)
    @refresh()


  prefix: =>
    @basePrefix + @currentPrefix

  bucketNamesList: =>
    @bucketNames.trim().replace(' ', '').split(',')

  updateFiles: (newFiles) =>
    @files = newFiles
    @scope.$digest()


  refresh: =>
    Promise.all(@bucketNamesList().map((bucketName) => @s3.list(bucketName, @prefix())))
      .then((lists) =>
        lists.reduce((arr, val) ->
          arr.concat(val)
        , [])
      ).then((data) =>
        data
          .map (el) =>
            el.Key = el.Key.substr(@prefix().length)
            el
          .map (el) =>
            if el.Key.indexOf('/') > -1
              el.type = 'folder'
              el.Key = el.Key.substr(0, el.Key.indexOf('/') + 1)
            else
              el.type = 'file'
              el.Key = el.Key.substr(el.Key.lastIndexOf('/') + 1)

            el.url = "about:home"
            #@s3.downloadLink(bucketName, @prefix  + el.Key).then((url) -> el.url = url) if el.type is 'file'
            el
          .reduce((a, b) ->
            a.push(b) if a.map((el) -> el.Key).indexOf(b.Key) < 0
            a
          , [])
      ).then(@updateFiles)






angular.module('DemoApp').component('bucketViewer',
#Note: The URL is relative to our `index.html` file
  templateUrl: 'components/bucket-viewer.template.html'
  controller: ['S3', '$scope', BucketViewerController]
  bindings:
    bucketNames: '@'
    basePrefix: '@'
)