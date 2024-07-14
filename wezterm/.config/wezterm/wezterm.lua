local Config = require("config")

return Config:init()
	:append(require("config.colorscheme"))
	:append(require("config.appearances"))
	:append(require("config.bindings"))
	:append(require("config.launch")).options
