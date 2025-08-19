
    let useHtml = true;
    window.addEventListener('load', function (ev) {
      _flutter.loader.loadEntrypoint({
        serviceWorker: {
          serviceWorkerVersion: serviceWorkerVersion,
        },
        onEntrypointLoaded: function (engineInitializer) {
          let config = {
            renderer:"html" ,
          };
          engineInitializer.initializeEngine(config).then(function (appRunner) {
            appRunner.runApp();
          });
        }
      });
    });
