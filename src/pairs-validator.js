'use strict';

var _id = 0,
    _singleton = false,
    Valdi = require('valdi'),
    simple = Valdi.simple;

function PairsValidator() {

    this.id = ++_id;
    this.mapping = {};
    this.nonEmpty = simple.new('Non-empty string').string().lengthMin(2);

    this.setMapping = function(ob) {
        for (var k in ob) {
            var _arr = this.arrayify(ob[k]);
            this.mapping[k] = simple.new('value of \'' + k + '\' is mapped to [' + _arr.join(', ') + ']').string().inList(_arr);
        }
    };

    this.arrayify = function (value) {
        var match = {
            string: true,
            number: true
        };

        if (match[typeof value]) {
            return [value];
        } else {
            return value;
        }
    };

    this.check = function(val1, val2) {

        //console.log('-----------------------------');
        //console.log('value');
        //console.log(val1);
        //console.log('linked');
        //console.log(val2);
        //console.log('mapping');
        var _check = (!this.mapping[val1]) ? this.nonEmpty : this.mapping[val1];
        //console.log(_check);
        //console.log('value returned');
        //console.log(_check.value(val2));
        return _check.value(val2);
    };
}


function _pairsValidator(mapping) {
    if (_singleton === false) {
        _singleton = new PairsValidator();
    }
    _singleton.setMapping(mapping);
    return _singleton;
}

module.exports = function (value, linked, mapping) {
    var _val = _pairsValidator(mapping);
    return _val.check(value, linked);
};
