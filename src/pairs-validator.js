'use strict';

var _id = 0,
    _singleton = false,
    valdi = require('valdi');

function PairsValidator() {

    this.id = ++_id;
    this.mapping = {};
    this.predef = {
        nonEmptyString = valdi.new('Non-empty string').string().lengthMin(2)
    };

    this.setMapping = function(ob) {
        foreach (var k in ob) {
            var _arr = this.arrayify(ob[k]);
            this.mapping[k] = valdi
                .new('value of \'' + k + '\' is mapped to [' + _arr.join(', ') + ']')
                .string()
                .inList(_arr);
        }
    };

    this.arrayify = function (value) {
        var match = {
            string: true,
            number: true
        }
        if (match[typeof value]) {
            return [value];
        } else {
            return value;
        }
    };

    this.check = function(val1, val2) {
        if (typeof this.mapping[val1]) {
            return this.mapping[val1].valid(val2);       // this is NET
        } else {
            return this.predef,nonEmptyString,valid(val2); // implementation
        }
    }
};


function _pairsValidator(mapping) {
    if (_singleton === false) {
        _singleton = new MultiValidator();
    }
    _singleton.setMapping(mapping)
    return _singleton;
}

module.exports = function jacin(value, linked, mapping) {
    return new _pairsValidator(mapping).check(value, linked);
};
