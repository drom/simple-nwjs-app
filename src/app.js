(function () {
    'use strict';
    var fs = require('fs');

    function ssvg () {
        var svg = document.querySelector('#SVG');

        var ser = new XMLSerializer();

        return '<?xml version="1.0" standalone="no"?>\n'
            + '<!DOCTYPE svg PUBLIC "-//W3C//DTD SVG 1.1//EN" "http://www.w3.org/Graphics/SVG/1.1/DTD/svg11.dtd">\n'
            + '<!-- Created -->\n'
            + ser.serializeToString(svg);
    }

    function pngdata () {
        var svgdata = 'data:image/svg+xml;base64,' + btoa(ssvg());

        var img = new Image();
            img.src = svgdata;

        var canvas = document.createElement('canvas');
            canvas.width = img.width;
            canvas.height = img.height;

        var context = canvas.getContext('2d');
            context.drawImage(img, 0, 0);

        var rawdata = canvas
            .toDataURL('image/png')
            .replace(/^data:image\/\w+;base64,/, '');

        return new Buffer(rawdata, 'base64');;
    }

    function writeToFileEvent (selector, cb) {
        var cho = document.querySelector(selector);
        cho.addEventListener('change', function() {
            var filename = this.value;
            if (!filename) { return; }
            fs.writeFile(filename, cb(), function(err) {
                if (err) { console.log('error'); }
            });
            this.value = '';
        }, false);
        cho.click();
    }

    function setClickEvent (selector, cb) {
        document
        .querySelector(selector)
        .addEventListener('click', function() {
            cb();
        }, false);
    }

    setClickEvent('#BSVG', function () {
        writeToFileEvent('#ISVG', ssvg);
    });

    setClickEvent('#BPNG', function () {
        writeToFileEvent('#IPNG', pngdata);
    });

    console.log(JSON.stringify(process.versions, null, 4));
})();
