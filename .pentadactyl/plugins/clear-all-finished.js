function clearAllFinished() {

    // Remove the finished download elements in each browser window
    try {
        var wm = Components.classes["@mozilla.org/appshell/window-mediator;1"].getService(Components.interfaces.nsIWindowMediator);
        var e = wm.getEnumerator("navigator:browser");
        var win;
        var finishedIDs;

        while (e.hasMoreElements()) {
            win = e.getNext();
            finishedIDs = [];  // only want to end up with one copy of this
            var downbarelem = win.document.getElementById("downbar");

            var comparray = downbarelem.getElementsByAttribute("state", "1");
            for (i = 0; i <= comparray.length - 1; i) {

                finishedIDs.push(comparray[i].id.substring(3));

                winElem = win.document.getElementById(comparray[i].id);
                downbarelem.removeChild(winElem);
            }

            win._dlbar_checkShouldShow();
            win._dlbar_updateMini();

        }

        // Add all these cleared ids to the recentCleared array
        this._dlbar_recentCleared = this._dlbar_recentCleared.concat(finishedIDs);

    } catch (e) {
    }

    // Fix the database
    try {
        var _dlbar_dlmgrContractID = "@mozilla.org/download-manager;1";
        var _dlbar_dlmgrIID = Components.interfaces.nsIDownloadManager;
        _dlbar_gDownloadManager = Components.classes[_dlbar_dlmgrContractID].getService(_dlbar_dlmgrIID);
        var dbase = _dlbar_gDownloadManager.DBConnection;

        var _dlbar_pref = Components.classes["@mozilla.org/preferences-service;1"].getService(Components.interfaces.nsIPrefBranch);
        var keepHist = _dlbar_pref.getBoolPref('downbar.function.keepHistory');

        if (keepHist) {
            var simpleStmt = "UPDATE moz_downloads SET DownbarShow=0 WHERE DownbarShow=1 AND state=1";
            dbase.executeSimpleSQL(simpleStmt);
        }
        else {
            // I could edit the database directly,
            //   but by calling removeDownload, observers are notified of the "download-manager-remove-download" topic automatically
            try {
                var stmt = dbase.createStatement("SELECT id FROM moz_downloads WHERE DownbarShow=1 AND state=1");
            }
            catch (e) {
                return;
            }
            try {
                while (stmt.executeStep()) {
                    _dlbar_gDownloadManager.removeDownload(stmt.getInt32(0));
                }
            }
            finally {
                stmt.reset();
            }
        }
    } catch (e) {
    }

}

commands.addUserCommand(["caf"], "Clear all finished",
    function (args) {
        clearAllFinished();
    }
);