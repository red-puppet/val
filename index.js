'use strict';

(function(){
    module.exports = function (value, linkedValue, mapping) {
        return new (require('./src/multi-validator'))(value, linkedValue, mapping);
    };
})();
