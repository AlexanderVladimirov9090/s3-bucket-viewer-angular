# S3 Bucket Viewer for AngularJS 1.x

The present project provides a AngularJS (1.x) component that can be reused to display a browser for S3 bucket contents.

__[Visit the Demo](http://s3-bucket-viewer-demo.s3-website.eu-central-1.amazonaws.com/
)__

## Usage
The reusable code of the AngularJS component can be found in the folder [./app/component/](./app/component/). After integrating the code into your AngularJS project (mind referencing the js files in your HTML code), you can load the component with:

```HTML
<bucket-viewer></bucket-viewer>
```

To change the bucket loaded by the component, you can change the ```bucketName``` attribute in the file [./app/component/bucket-viewer.component.coffee](./app/component/bucket-viewer.component.coffee).

## Local Demo

A local demo can be started by typing ```npm start``` in the folder using a Terminal/Command Prompt window.
Visit [http://localhost:8000](http://localhost:8000) to view the demo in your browser.
