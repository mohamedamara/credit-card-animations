{{flutter_js}}
{{flutter_build_config}}

const mainContent = document.createElement('div');
mainContent.className = "main-content";
document.body.appendChild(mainContent);
const progressElement = document.createElement('progress');
progressElement.className = "pure-material-progress-circular";
mainContent.appendChild(progressElement);

// Customize the app initialization process
_flutter.loader.load({
  onEntrypointLoaded: async function(engineInitializer) {
    const appRunner = await engineInitializer.initializeEngine();

    // Remove the progress element when the app runner is ready
    if (document.body.contains(mainContent)) {
      document.body.removeChild(mainContent);
    }
    await appRunner.runApp();
  }
});