
var should          = require('chai').should();
var expect          = require('chai').expect;
var dateFilter      = require('../index');
var nunjucks        = require('nunjucks');
var moment          = require('moment');

var testDate        = '2015-03-21';
var testMoment      = moment.utc(testDate);
var testMomentPlus  = moment.utc(testDate).add(7, 'days');
var testFilterName  = 'custom_filter';
var testFormat      = 'YYYY';
var testDefFormat   = 'YYYY-MM-DD';

var env             = new nunjucks.Environment();
var renderNunjucks  = function(filter, str) {
    if (str===undefined) {
        str = '{{ my_date | ' + (filter || 'date') + ' }}';
    }
    return env.renderString(str, {'my_date': testDate});
};

/*
describe('#init - test variables validation', function() {
    it('checking testMoment', function() {
        testMoment.format().should.equal('2015-03-21T00:00:00+01:00');
    });

    it('checking testMomentPlus', function() {
        testMomentPlus.format().should.equal('2015-03-28T00:00:00+01:00');
    });
});
*/

describe('#dateFunction - format arg', function() {
    it('no arg - using default format', function() {
        dateFilter(testDate).should.equal(testMoment.format());
    });

    it('using "'+testFormat+'" arg', function() {
        dateFilter(testDate, testFormat).should.equal(testMoment.format(testFormat));
    });
});

describe('#dateFunction - moment method calls', function() {
    it('using the "add" method', function() {
        dateFilter(testDate, 'add', 7, 'days').format().should.equal(testMomentPlus.format());
    });
});

describe('#nunjucksFilter - filter installation', function() {
    it('using default filter name "date" manually', function() {
        env.addFilter('date', dateFilter);
        expect(renderNunjucks()).to.be.a('string').and.equal(testMoment.format());
    });

    it('using filter auto-install with default filter name', function() {
        dateFilter.install(env);
        expect(renderNunjucks()).to.be.a('string').and.equal(testMoment.format());
    });

    it('using filter auto-install with default filter name and no "env"', function() {
        dateFilter.install();
        expect(renderNunjucks()).to.be.a('string').and.equal(testMoment.format());
    });

    it('using filter auto-install with custom filter name', function() {
        dateFilter.install(env, testFilterName);
        expect(renderNunjucks(testFilterName)).to.be.a('string').and.equal(testMoment.format());
    });
});

describe('#nunjucksFilter - default date format', function() {
    it('using no arg', function() {
        env.addFilter('date', dateFilter);
        dateFilter.setDefaultFormat(testDefFormat);
        dateFilter(testDate).should.equal(testMoment.format(testDefFormat));
        dateFilter.setDefaultFormat(null);
    });
});

describe('#nunjucksFilter - format calls', function() {
    it('using "'+testFormat+'" arg', function() {
        env.addFilter('date', dateFilter);
        expect(
            renderNunjucks('date', '{{ my_date | date("'+testFormat+'") }}')
        ).to.be.a('string').and.equal(testMoment.format(testFormat));
    });
});

describe('#nunjucksFilter - format calls with custom default date format', function() {
    it('using no arg', function() {
        env.addFilter('date', dateFilter);
        dateFilter.setDefaultFormat(testDefFormat);
        expect(renderNunjucks()).to.be.a('string').and.equal(testMoment.format(testDefFormat));
        dateFilter.setDefaultFormat(null);
    });
});

describe('#nunjucksFilter - moment methods calls', function() {
    it('using method chaining', function() {
        env.addFilter('date', dateFilter);
        expect(
            renderNunjucks('date', '{{ my_date | date("add", 7, "days") | date }}')
        ).to.be.a('string').and.equal(testMomentPlus.format());
    });
});
