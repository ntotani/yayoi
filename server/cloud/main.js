var crypto = require('crypto');

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
    var key = "753bbbbb0ecb441ce3eb";
    var secret = "4f5d7566d190aedca695";
    var sign = crypto.createHmac('sha256', secret).update(signatureData.join(":")).digest('hex');
    result.auth = key + ':' + sign;
    response.success(result);
});
