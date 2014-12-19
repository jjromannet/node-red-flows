module.exports = function(RED) {

    var sense = require('ds18b20');
	var Promise = require("es6-promise").Promise

    function LowerCaseNode(config) {
        RED.nodes.createNode(this, config);
		this.readType = config.readType;
        this.sensorid = config.sensorid;
		this.property = config.property;
        var node = this;

        this.on('input', function(msg) {
		
			if(this.readType === "read-all"){
				sense.sensors(function(err, ids) {
					// ONE for now
					var arrayOfPromises = []
					for(var i = 0; i < ids.length; i++){
						arrayOfPromises.push(new Promise(function(resolve, reject){
							var idFromArray = ids[i];
							sense.temperature(idFromArray, function(err, value) {
								resolve({serialid: idFromArray, err: err, value: value});
							});
						}));
					}
					Promise.all(arrayOfPromises).then(function(arrayOfResults) {
						msg.payload = arrayOfResults;
						node.send(msg);
					});
				});
			}else{
				var tempReading = {
						where: node.name,
						sensorid: node.sensorid };
				if(node.readType === "payload-sensor"){
					tempReading['sensorid'] = msg.payload[node.property]
				}// else
				// "fixed-sensor"
				sense.temperature(tempReading['sensorid'], function(err, value) {
					tempReading['reading'] = value;
					tempReading['err'] = err;
					msg.payload = tempReading;
					node.send(msg);
				});
			}
        });
    }
    RED.nodes.registerType("ds18b20", LowerCaseNode);
}
