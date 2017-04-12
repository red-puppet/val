'use strict';

(function(){
    module.exports = function (value, linkedValue, mapping) {
        return (require('./src/pairs-validator'))(value, linkedValue, mapping);
    };
})();
