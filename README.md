# S3 Bucket Viewer for AngularJS 1.x

The present project provides a AngularJS (1.x) component that can be reused to display a browser for S3 bucket contents.

__Highlights__

* Lists contents of any (CORS-enabled) S3 bucket.
* Supports browsing of '/' delimited S3 key names as folders.
* Uses the AWS S3 browser javascript SDK.
* Available as reusable AngularJS component.

__[Visit the Demo](http://s3-bucket-viewer-demo.s3-website.eu-central-1.amazonaws.com/
)__

## Usage
The reusable code of the AngularJS component can be found in the folder [./app/component/](./app/component/). After integrating the code into your AngularJS project (mind referencing the js files in your HTML code), you can load the component with:

```HTML
<bucket-viewer></bucket-viewer>
```

To change the bucket loaded by the component, you can change the ```bucketName``` attribute in the file [./app/component/bucket-viewer.component.coffee](./app/component/bucket-viewer.component.coffee).
Please enable CORS access to your bucket for the component to load its S3 objects.

## Local Demo

A local demo can be started by typing ```npm start``` in the folder using a Terminal/Command Prompt window.
Visit [http://localhost:8000](http://localhost:8000) to view the demo in your browser.
