'use strict';

var chain = require('../lib/index')();

describe('The event-chain test suite', function() {
  it('The callback function should be executed after all events are completed', function(done) {
    var a = chain.on(['one', 'two'], done);

    a.emit('one');
    a.emit('two');
  });

  it('Two chains will operate independently', function(done) {
    var a = chain.on(['one'], function() {
      throw new Error('This should never trigger.');
    });
    var b = chain.on(['one', 'two'], done);

    b.emit('one');
    b.emit('two');
  });

  it('A chain cannot be made without events', function(done) {
    try {
      var a = chain.on([], done);
    }
    catch (e) {
      done();
    }
  });

  it('Chains can be linked together', function(done) {
    var final = chain.on(['one', 'two'], done);
    var first = chain.on(['first'], function() {
      final.emit('one');
    });
    var second = chain.on(['second'], function() {
      final.emit('two');
    });

    // Emitting both linked events, should trigger the final event.
    first.emit('first');
    second.emit('second');
  });
});
