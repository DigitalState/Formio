/* eslint-env mocha */
import { expect } from 'chai';

import deleteProperty from '../src/index';

describe('deleteProperty', () => {
    let obj = null;
    beforeEach(() => {
        obj = {
            a: 5,
            b: 6,
            c: 7,
            d: {
                a: 65,
                z: 6,
                d: {
                    a: 65,
                    k: 5
                }
            },
            e: [
                { a: 5 },
                { b: 6 },
                { c: 7 }
            ],
            f: [
                {
                    b: [{ a: 5, z: 5 }],
                    c: 6
                },
                {
                    g: 0
                }
            ]
        };
    });

    it('should delete a simple property', () => {
        let deleteA = deleteProperty('a');
        expect(obj.a).to.equal(5);
        expect(deleteA(obj)).to.be.true;
        expect(obj.hasOwnProperty('a')).to.be.false;
    });

    it('should delete a nested property', () => {
        let deleteADDK = deleteProperty('d.d.k');
        expect(obj.d.d.hasOwnProperty('k')).to.be.true;
        expect(deleteADDK(obj)).to.be.true;
        expect(obj.d.d.hasOwnProperty('k')).to.be.false;
    });

    it('should return false for a non-existent simple property', () => {
        let deleteQ = deleteProperty('q');
        expect(obj.hasOwnProperty('q')).to.be.false;
        expect(deleteQ(obj)).to.be.false;
    });

    it('should return false for a non-existent nested property', () => {
        let deleteIlluminati = deleteProperty('q.z.illuminati');
        expect(obj.hasOwnProperty('q.z.illuminati')).to.be.false;
        expect(deleteIlluminati(obj)).to.be.false;
    });

    it('should return false for null/undefined objects', () => {
        let deleteA = deleteProperty('a');
        expect(deleteA(null)).to.be.false;
        expect(deleteA(undefined)).to.be.false;
        expect(deleteA(69)).to.be.false;
        expect(deleteA('god damn it')).to.be.false;

        // Test nested props too b/c it depends on _.property to handle non-objects
        let deleteAA = deleteProperty('a.a');
        expect(deleteAA(null)).to.be.false;
        expect(deleteAA(undefined)).to.be.false;
        expect(deleteAA(69)).to.be.false;
        expect(deleteAA('god damn it')).to.be.false;
    });

    it('should return false for properties higher up the prototype chain', () => {
        let proto = { a: { a: 1 } };
        obj = Object.create(proto);

        // It'll work for nested properties higher up the chain
        expect(obj.a.hasOwnProperty('a')).to.be.true;
        let deleteAA = deleteProperty('a.a');
        expect(deleteAA(obj)).to.be.true;

        // But not for properties that aren't on the obj itself
        expect(obj.hasOwnProperty('a')).to.be.false;
        let deleteA = deleteProperty('a');
        expect(deleteA(obj)).to.be.false;
    });

});
