
var exec = require("cordova/exec");

var BackgroundTask = function () {
    this.name = "BackgroundTask";
};

BackgroundTask.prototype.start = function (task) {
    exec(task, null, "BackgroundTask", "start", []);
};

BackgroundTask.prototype.end = function (task) {
    exec(task, null, "BackgroundTask", "end", []);
};

module.exports = new BackgroundTask();
