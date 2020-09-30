compiling js...

  var Module = typeof Module !== 'undefined' ? Module : {};
  
  if (!Module.expectedDataFileDownloads) {
    Module.expectedDataFileDownloads = 0;
  }
  Module.expectedDataFileDownloads++;
  (function() {
   var loadPackage = function(metadata) {
  
      var PACKAGE_PATH;
      if (typeof window === 'object') {
        PACKAGE_PATH = window['encodeURIComponent'](window.location.pathname.toString().substring(0, window.location.pathname.toString().lastIndexOf('/')) + '/');
      } else if (typeof location !== 'undefined') {
        // worker
        PACKAGE_PATH = encodeURIComponent(location.pathname.toString().substring(0, location.pathname.toString().lastIndexOf('/')) + '/');
      } else {
        throw 'using preloaded data can only be done on a web page or in a web worker';
      }
      var PACKAGE_NAME = 'src/x64.o';
      var REMOTE_PACKAGE_BASE = 'x64.o';
      if (typeof Module['locateFilePackage'] === 'function' && !Module['locateFile']) {
        Module['locateFile'] = Module['locateFilePackage'];
        err('warning: you defined Module.locateFilePackage, that has been renamed to Module.locateFile (using your locateFilePackage for now)');
      }
      var REMOTE_PACKAGE_NAME = Module['locateFile'] ? Module['locateFile'](REMOTE_PACKAGE_BASE, '') : REMOTE_PACKAGE_BASE;
    
      var REMOTE_PACKAGE_SIZE = metadata['remote_package_size'];
      var PACKAGE_UUID = metadata['package_uuid'];
    
      function fetchRemotePackage(packageName, packageSize, callback, errback) {
        var xhr = new XMLHttpRequest();
        xhr.open('GET', packageName, true);
        xhr.responseType = 'arraybuffer';
        xhr.onprogress = function(event) {
          var url = packageName;
          var size = packageSize;
          if (event.total) size = event.total;
          if (event.loaded) {
            if (!xhr.addedTotal) {
              xhr.addedTotal = true;
              if (!Module.dataFileDownloads) Module.dataFileDownloads = {};
              Module.dataFileDownloads[url] = {
                loaded: event.loaded,
                total: size
              };
            } else {
              Module.dataFileDownloads[url].loaded = event.loaded;
            }
            var total = 0;
            var loaded = 0;
            var num = 0;
            for (var download in Module.dataFileDownloads) {
            var data = Module.dataFileDownloads[download];
              total += data.total;
              loaded += data.loaded;
              num++;
            }
            total = Math.ceil(total * Module.expectedDataFileDownloads/num);
            if (Module['setStatus']) Module['setStatus']('Downloading data... (' + loaded + '/' + total + ')');
          } else if (!Module.dataFileDownloads) {
            if (Module['setStatus']) Module['setStatus']('Downloading data...');
          }
        };
        xhr.onerror = function(event) {
          throw new Error("NetworkError for: " + packageName);
        }
        xhr.onload = function(event) {
          if (xhr.status == 200 || xhr.status == 304 || xhr.status == 206 || (xhr.status == 0 && xhr.response)) { // file URLs can return 0
            var packageData = xhr.response;
            callback(packageData);
          } else {
            throw new Error(xhr.statusText + " : " + xhr.responseURL);
          }
        };
        xhr.send(null);
      };

      function handleError(error) {
        console.error('package error:', error);
      };
    
        var fetchedCallback = null;
        var fetched = Module['getPreloadedPackage'] ? Module['getPreloadedPackage'](REMOTE_PACKAGE_NAME, REMOTE_PACKAGE_SIZE) : null;

        if (!fetched) fetchRemotePackage(REMOTE_PACKAGE_NAME, REMOTE_PACKAGE_SIZE, function(data) {
          if (fetchedCallback) {
            fetchedCallback(data);
            fetchedCallback = null;
          } else {
            fetched = data;
          }
        }, handleError);
      
    function runWithFS() {
  
      function assert(check, msg) {
        if (!check) throw msg + new Error().stack;
      }
  Module['FS_createPath']('/', 'C64', true, true);
Module['FS_createPath']('/', 'DRIVES', true, true);

      /** @constructor */
      function DataRequest(start, end, audio) {
        this.start = start;
        this.end = end;
        this.audio = audio;
      }
      DataRequest.prototype = {
        requests: {},
        open: function(mode, name) {
          this.name = name;
          this.requests[name] = this;
          Module['addRunDependency']('fp ' + this.name);
        },
        send: function() {},
        onload: function() {
          var byteArray = this.byteArray.subarray(this.start, this.end);
          this.finish(byteArray);
        },
        finish: function(byteArray) {
          var that = this;
  
          Module['FS_createDataFile'](this.name, null, byteArray, true, true, true); // canOwn this data in the filesystem, it is a slide into the heap that will never change
          Module['removeRunDependency']('fp ' + that.name);
  
          this.requests[this.name] = null;
        }
      };
  
          var files = metadata['files'];
          for (var i = 0; i < files.length; ++i) {
            new DataRequest(files[i]['start'], files[i]['end'], files[i]['audio']).open('GET', files[i]['filename']);
          }
  
    
      function processPackageData(arrayBuffer) {
        assert(arrayBuffer, 'Loading data file failed.');
        assert(arrayBuffer instanceof ArrayBuffer, 'bad input to processPackageData');
        var byteArray = new Uint8Array(arrayBuffer);
        var curr;
        
          // Reuse the bytearray from the XHR as the source for file reads.
          DataRequest.prototype.byteArray = byteArray;
    
            var files = metadata['files'];
            for (var i = 0; i < files.length; ++i) {
              DataRequest.prototype.requests[files[i].filename].onload();
            }
                Module['removeRunDependency']('datafile_src/x64.o');

      };
      Module['addRunDependency']('datafile_src/x64.o');
    
      if (!Module.preloadResults) Module.preloadResults = {};
    
        Module.preloadResults[PACKAGE_NAME] = {fromCache: false};
        if (fetched) {
          processPackageData(fetched);
          fetched = null;
        } else {
          fetchedCallback = processPackageData;
        }
      
    }
    if (Module['calledRun']) {
      runWithFS();
    } else {
      if (!Module['preRun']) Module['preRun'] = [];
      Module["preRun"].push(runWithFS); // FS is not initialized yet, wait for it
    }
  
   }
   loadPackage({"files": [{"filename": "/C64/gtk3_pos.vkm", "start": 0, "end": 6465, "audio": 0}, {"filename": "/C64/sdl_joymap_ps3.vjm", "start": 6465, "end": 7853, "audio": 0}, {"filename": "/C64/pc64.vpl", "start": 7853, "end": 8256, "audio": 0}, {"filename": "/C64/kernal", "start": 8256, "end": 16448, "audio": 0}, {"filename": "/C64/rgb.vpl", "start": 16448, "end": 16936, "audio": 0}, {"filename": "/C64/ccs64.vpl", "start": 16936, "end": 17345, "audio": 0}, {"filename": "/C64/sdl_hotkeys_vsid.vkm", "start": 17345, "end": 18214, "audio": 0}, {"filename": "/C64/gtk3_sym_nl.vkm", "start": 18214, "end": 24799, "audio": 0}, {"filename": "/C64/sdl_sym_nl.vkm", "start": 24799, "end": 34286, "audio": 0}, {"filename": "/C64/godot.vpl", "start": 34286, "end": 34695, "audio": 0}, {"filename": "/C64/chargen", "start": 34695, "end": 38791, "audio": 0}, {"filename": "/C64/jpkernal", "start": 38791, "end": 46983, "audio": 0}, {"filename": "/C64/sdl_keyrah_retropie.vkm", "start": 46983, "end": 57584, "audio": 0}, {"filename": "/C64/sdl_sym_da.vkm", "start": 57584, "end": 68172, "audio": 0}, {"filename": "/C64/gskernal", "start": 68172, "end": 76364, "audio": 0}, {"filename": "/C64/cjam.vpl", "start": 76364, "end": 76826, "audio": 0}, {"filename": "/C64/community-colors.vpl", "start": 76826, "end": 77176, "audio": 0}, {"filename": "/C64/gtk3_pos_de.vkm", "start": 77176, "end": 86064, "audio": 0}, {"filename": "/C64/sdl_pos_da.vkm", "start": 86064, "end": 95529, "audio": 0}, {"filename": "/C64/sdl_keyrah_combian.vkm", "start": 95529, "end": 106184, "audio": 0}, {"filename": "/C64/c64hq.vpl", "start": 106184, "end": 106593, "audio": 0}, {"filename": "/C64/gtk3_keyrah_de.vkm", "start": 106593, "end": 113244, "audio": 0}, {"filename": "/C64/frodo.vpl", "start": 113244, "end": 113653, "audio": 0}, {"filename": "/C64/sdl_sym_it.vkm", "start": 113653, "end": 124455, "audio": 0}, {"filename": "/C64/sdl_sym.vkm", "start": 124455, "end": 134722, "audio": 0}, {"filename": "/C64/sdl_hotkeys.vkm", "start": 134722, "end": 136873, "audio": 0}, {"filename": "/C64/ptoing.vpl", "start": 136873, "end": 137281, "audio": 0}, {"filename": "/C64/gtk3_keyrah.vkm", "start": 137281, "end": 143928, "audio": 0}, {"filename": "/C64/sdl_pos_ch.vkm", "start": 143928, "end": 155119, "audio": 0}, {"filename": "/C64/Makefile.in", "start": 155119, "end": 173661, "audio": 0}, {"filename": "/C64/sdl_pos.vkm", "start": 173661, "end": 182105, "audio": 0}, {"filename": "/C64/sxkernal", "start": 182105, "end": 190297, "audio": 0}, {"filename": "/C64/gtk3_sym.vkm", "start": 190297, "end": 196795, "audio": 0}, {"filename": "/C64/default.vrs", "start": 196795, "end": 196999, "audio": 0}, {"filename": "/C64/sdl_pos_no.vkm", "start": 196999, "end": 206345, "audio": 0}, {"filename": "/C64/sdl_keyrah_de.vkm", "start": 206345, "end": 216140, "audio": 0}, {"filename": "/C64/c64s.vpl", "start": 216140, "end": 216549, "audio": 0}, {"filename": "/C64/Makefile", "start": 216549, "end": 235571, "audio": 0}, {"filename": "/C64/vice.vpl", "start": 235571, "end": 235980, "audio": 0}, {"filename": "/C64/pepto-ntsc-sony.vpl", "start": 235980, "end": 236564, "audio": 0}, {"filename": "/C64/sdl_pos_de.vkm", "start": 236564, "end": 246218, "audio": 0}, {"filename": "/C64/Makefile.am", "start": 246218, "end": 247507, "audio": 0}, {"filename": "/C64/jpchrgen", "start": 247507, "end": 251603, "audio": 0}, {"filename": "/C64/sdl_keyrah_retropie_de.vkm", "start": 251603, "end": 262178, "audio": 0}, {"filename": "/C64/sdl_keyrah.vkm", "start": 262178, "end": 271970, "audio": 0}, {"filename": "/C64/gtk3_sym_de.vkm", "start": 271970, "end": 281145, "audio": 0}, {"filename": "/C64/gtk3_sym_se.vkm", "start": 281145, "end": 288293, "audio": 0}, {"filename": "/C64/c64mem.sym", "start": 288293, "end": 297110, "audio": 0}, {"filename": "/C64/colodore.vpl", "start": 297110, "end": 297595, "audio": 0}, {"filename": "/C64/sdl_sym_de.vkm", "start": 297595, "end": 310564, "audio": 0}, {"filename": "/C64/pepto-pal.vpl", "start": 310564, "end": 311064, "audio": 0}, {"filename": "/C64/basic", "start": 311064, "end": 319256, "audio": 0}, {"filename": "/C64/gtk3_sym_da.vkm", "start": 319256, "end": 325471, "audio": 0}, {"filename": "/C64/pepto-ntsc.vpl", "start": 325471, "end": 326061, "audio": 0}, {"filename": "/C64/gtk3_sym_it.vkm", "start": 326061, "end": 333747, "audio": 0}, {"filename": "/C64/pepto-palold.vpl", "start": 333747, "end": 334273, "audio": 0}, {"filename": "/C64/sdl_pos_fi.vkm", "start": 334273, "end": 343744, "audio": 0}, {"filename": "/C64/edkernal", "start": 343744, "end": 351936, "audio": 0}, {"filename": "/C64/deekay.vpl", "start": 351936, "end": 352344, "audio": 0}, {"filename": "/DRIVES/dos1571", "start": 352344, "end": 385112, "audio": 0}, {"filename": "/DRIVES/dos1001", "start": 385112, "end": 401496, "audio": 0}, {"filename": "/DRIVES/d1541II", "start": 401496, "end": 417880, "audio": 0}, {"filename": "/DRIVES/dos3040", "start": 417880, "end": 430168, "audio": 0}, {"filename": "/DRIVES/dos1581", "start": 430168, "end": 462936, "audio": 0}, {"filename": "/DRIVES/Makefile.in", "start": 462936, "end": 480360, "audio": 0}, {"filename": "/DRIVES/dos1551", "start": 480360, "end": 496744, "audio": 0}, {"filename": "/DRIVES/dos2040", "start": 496744, "end": 504936, "audio": 0}, {"filename": "/DRIVES/Makefile", "start": 504936, "end": 522921, "audio": 0}, {"filename": "/DRIVES/dos4040", "start": 522921, "end": 535209, "audio": 0}, {"filename": "/DRIVES/dos1570", "start": 535209, "end": 567977, "audio": 0}, {"filename": "/DRIVES/Makefile.am", "start": 567977, "end": 568185, "audio": 0}, {"filename": "/DRIVES/d1571cr", "start": 568185, "end": 600953, "audio": 0}, {"filename": "/DRIVES/dos1541", "start": 600953, "end": 617337, "audio": 0}, {"filename": "/DRIVES/dos2031", "start": 617337, "end": 633721, "audio": 0}, {"filename": "/DRIVES/dos1540", "start": 633721, "end": 650105, "audio": 0}], "remote_package_size": 650105, "package_uuid": "e897928b-09a8-4b7c-89b1-ad557322b4c9"});
  
  })();
  
