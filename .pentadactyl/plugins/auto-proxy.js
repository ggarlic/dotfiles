// http://marlonyao.iteye.com/blog/776775
// only set string value  
function setPreferenceValue(branch, name, value) {
    var prefs = Components.classes["@mozilla.org/preferences-service;1"].getService(Components.interfaces.nsIPrefService).getBranch(branch);
    var str = Components.classes["@mozilla.org/supports-string;1"].createInstance(Components.interfaces.nsISupportsString);
    str.data = value;
    prefs.setComplexValue(name, Components.interfaces.nsISupportsString, str);
}
function getPreferenceValue(branch, name) {
    var prefs = Components.classes["@mozilla.org/preferences-service;1"].getService(Components.interfaces.nsIPrefService).getBranch(branch);
    //if (prefs.prefHasUserValue(name)) {
    return prefs.getComplexValue(name, Components.interfaces.nsISupportsString).data;
    //} else {
    //  return null;
    //}  
}

function setIntPreferenceValue(branch, name, value) {
    var prefs = Components.classes["@mozilla.org/preferences-service;1"].getService(Components.interfaces.nsIPrefService).getBranch(branch);
    prefs.setIntPref(name, value);
}
function getIntPreferenceValue(branch, name) {
    var prefs = Components.classes["@mozilla.org/preferences-service;1"].getService(Components.interfaces.nsIPrefService).getBranch(branch);
    return prefs.getIntPref(name);
}

function refresh() {
	tabs.reload(config.browser.mCurrentTab);
}


commands.addUserCommand(["autoproxy", "ap"], "Change autoproxy status",
    function (args) {
        if (args.length == 0) { // print current autoproxy status
            var mode = getPreferenceValue("extensions.autoproxy.", "proxyMode");
            //if (mode == null)
            //{
            //	mode = 'auto';f
            //}
            liberator.echomsg("proxyMode is " + mode);
        } else {
            var arg = args[0].toLowerCase();
            var mode;
            if (arg.indexOf('d') == 0) {
                mode = 'disabled';
                setPreferenceValue("extensions.autoproxy.", "proxyMode", mode);
                liberator.echomsg("set proxyMode to " + mode);
            } else if (arg.indexOf('a') == 0) {
                mode = 'auto';
                setPreferenceValue("extensions.autoproxy.", "proxyMode", mode);
                liberator.echomsg("set proxyMode to " + mode);
            } else if (arg.indexOf('g') == 0) {
                mode = 'global';
                setPreferenceValue("extensions.autoproxy.", "proxyMode", mode);
                liberator.echomsg("set proxyMode to " + mode);
            } else {
                liberator.echoerr("mode should be one of 'disabled', 'auto' or 'global'");
            }
        }
    }, {
        argCount: "?",
    }
);

commands.addUserCommand(["switchproxy", "sp"], "Switch autoproxy status",
    function (args) {
        if (args.length == 0) {
            var mode = getPreferenceValue("extensions.autoproxy.", "proxyMode");
            //if (mode == null)
            if (mode == 'auto') {
                //mode = 'auto';
                newmode = 'global';
                setPreferenceValue("extensions.autoproxy.", "proxyMode", newmode);
                liberator.echomsg("proxyMode is " + mode + ", switch proxyMode to " + newmode);
            }
            else if (mode == 'global') {
                newmode = 'auto';
                setPreferenceValue("extensions.autoproxy.", "proxyMode", newmode);
                liberator.echomsg("proxyMode is " + mode + ", switch proxyMode to " + newmode);
            }
            else {
                liberator.echoerr("proxyMode is not 'auto' or 'global'");
            }
        }
        else {
            liberator.echoerr("We dont need args...");
        }
    }, {
        argCount: "?",
    }
);

commands.addUserCommand(["switchdefaultproxy", "sdp"], "Switch autoproxy default proxy",
    function (args) {
        if (args.length == 0) {
            var default_proxy = getIntPreferenceValue("extensions.autoproxy.", "default_proxy");
            liberator.echomsg("default proxy is " + default_proxy);
        } else {
            if (isNaN(args)) {
                liberator.echoerr("default proxy should be number");
            }
            else {
                setIntPreferenceValue("extensions.autoproxy.", "default_proxy", args);
                liberator.echomsg("switch autoproxy default proxy to " + args);
            }
        }
    }, {
        argCount: "?",
    }
);

commands.addUserCommand(["switchproxyrefresh", "spr"], "Switch autoproxy status and refresh",
    function (args) {
        if (args.length == 0) {
            var mode = getPreferenceValue("extensions.autoproxy.", "proxyMode");
            //if (mode == null)
            if (mode == 'auto') {
                //mode = 'auto';
                newmode = 'global';
                setPreferenceValue("extensions.autoproxy.", "proxyMode", newmode);
                liberator.echomsg("proxyMode is " + mode + ", switch proxyMode to " + newmode);
                refresh();
            }
            else if (mode == 'global') {
                newmode = 'auto';
                setPreferenceValue("extensions.autoproxy.", "proxyMode", newmode);
                liberator.echomsg("proxyMode is " + mode + ", switch proxyMode to " + newmode);
                refresh();
            }
            else {
                liberator.echoerr("proxyMode is not 'auto' or 'global'");
            }
        }
        else {
            liberator.echoerr("We dont need args...");
        }
    }, {
        argCount: "?",
    }
);