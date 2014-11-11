var crypto = require('crypto');

var PUSHER_ID = "64710";
var PUSHER_KEY = "753bbbbb0ecb441ce3eb";
var PUSHER_SECRET = "4f5d7566d190aedca695";

var sign = function(str) {
    return crypto.createHmac('sha256', PUSHER_SECRET).update(str).digest('hex');
}

Parse.Cloud.define("pusher", function(request, response) {
    var socketId = request.params.socket_id;
    var channelId = request.params.channel_id;
    if (!channelId) {
        channelId = "" + Math.floor(Math.random() * 100000);
    }
    var data = request.params.data;
    var result = {channel_id:channelId};
    var signatureData = [socketId, "private-" + channelId];
    if (data) {
        var serializedData = JSON.stringify(data);
        signatureData.push(serializedData);
        result.channel_data = serializedData;
    }
    result.auth = PUSHER_KEY + ':' + sign(signatureData.join(":"));
    response.success(result);
});

Parse.Cloud.define("start", function(req, res) {
    var body = JSON.stringify({
        name: 'start',
        data: JSON.stringify({form: {red: [1, 6, 11], blue:[20, 15, 10]}, seed: 0}),
        channel: 'private-' + req.params.channel_id
    });
    var method = "POST";
    var path = "/apps/" + PUSHER_ID + "/events";
    var query = "auth_key=" + PUSHER_KEY;
    query += "&auth_timestamp=" + parseInt(new Date().getTime() / 1000, 10);
    query += "&auth_version=1.0";
    query += "&body_md5=" + crypto.createHash('md5').update(body, 'utf8').digest('hex');
    query += "&auth_signature=" + sign([method, path, query].join('\n'));
    Parse.Cloud.httpRequest({
        method: method,
        url: "http://api.pusherapp.com" + path + "?" + query,
        headers: {
            'Content-Type': 'application/json'
        },
        body: body,
        success: function(httpResponse) {
            res.success(httpResponse.text);
        },
        error: function(httpResponse) {
            res.error(httpResponse.status + ': ' + httpResponse.text);
        }
    });
});
