'use strict';

(function () {
    var fs = nw.require('fs');

    function ssvg () {
        var svg, ser;

        svg = document.querySelector('#SVG');
        ser = new XMLSerializer();
        return '<?xml version="1.0" standalone="no"?>\n'
            + '<!DOCTYPE svg PUBLIC "-//W3C//DTD SVG 1.1//EN" "http://www.w3.org/Graphics/SVG/1.1/DTD/svg11.dtd">\n'
            + '<!-- Created -->\n'
            + ser.serializeToString(svg);
    }

    function writeToFileEvent (selector, cb) {
        var cho = document.querySelector(selector);
        cho.addEventListener('change', function() {
            var filename = this.value;
            if (!filename) { return; }
            fs.writeFile(filename, cb(), function(err) {
                if (err) {
                    console.log('error');
                }
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
        writeToFileEvent('#IPNG', function () {
            return '<png></png>';
        });
    });

})();
