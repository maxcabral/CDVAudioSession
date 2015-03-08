var exec = require('cordova/exec');

module.exports = {
	setCategory : function (categoryString, success, fail) {
		console.log('JS: setting audio session');
		return cordova.exec(success, fail, "CDVAudioSession", "setCategoryAndOptions", [categoryString]);
	},

	setCategoryAndOptions : function (categoryString, optionString, success, fail) {
		console.log('JS: setting audio session');
		return cordova.exec(success, fail, "CDVAudioSession", "setCategoryAndOptions", [categoryString, optionString]);
	}
};
