'use strict';

(function(){
    module.exports = function (value, linkedValue, mapping) {
        return new (require('./src/pairs-validator'))(value, linkedValue, mapping);
    };
})();
