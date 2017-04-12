require('./../../src/tool/test-signature')(__filename);

var validatePairs = require('./../../index'),
    mapping = {
        A: 'X',
        ANE: ['DOC'],
        B: ['XC', 'D']
    };

describe('Can validate', function () {
    it('in-line with mappings provided', function () {
        expect(validatePairs('A', 'Z', mapping)).toBe(false);
        expect(validatePairs('A', 'X', mapping)).toBe(true);
        expect(validatePairs('ANE', 'BOO', mapping)).toBe(false);
        expect(validatePairs('ANE', 'DOC', mapping)).toBe(true);
        expect(validatePairs('B', 'XC', mapping)).toBe(true);
        expect(validatePairs('B', 'D', mapping)).toBe(true);
        expect(validatePairs('B', 'ERR', mapping)).toBe(false);
        expect(validatePairs('else', 'non-empty', mapping)).toBe(true);
        expect(validatePairs('else', '', mapping)).toBe(false);
    });
});
