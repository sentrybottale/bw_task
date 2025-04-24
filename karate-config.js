function fn() {
  var env = karate.env; // Set this only when set for CI execution - karate parameter e=locale
  karate.log('karate.env system property was:', env);

  if (!env) {
    env = 'dev'; // A custom 'intelligent' default
  }

  // Default config (dev environment)
  var config = { baseURL: 'https://qa-assessment.pages.dev/' };

  function getResourcePath(resource) {
    var File = Java.type('java.io.File');
    var Paths = Java.type('java.nio.file.Paths');
    var path = Paths.get('util', resource).toAbsolutePath().toString();
    return path;
  }

  // Website
  if (env == 'dev') {
    config.baseURL = 'https://qa-assessment.pages.dev/';
  }

  // Don't waste time waiting for a connection or if servers don't respond within 15 seconds
  karate.configure('retry', { count: 6, interval: 3000 });
  karate.configure('connectTimeout', 25000);
  karate.configure('readTimeout', 20000);

  // Locally Chrome
  karate.configure('driver', { type: 'chrome', addOptions: ["--remote-allow-origins=*", '--disable-search-engine-choice-screen', '--disable-infobars', '--no-first-run', '--disable-notifications', '--disable-features=PasswordLeakDetection'], showDriverLog: false });

  return config; // Ensure the config object is returned
}