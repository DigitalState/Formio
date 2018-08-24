'use strict';

var Chain = require('./Chain');

/**
 * A Factory interface for making chained events.
 *
 * @param config
 * @returns {{on: Function}}
 */
module.exports = function(config) {
  return {
    /**
     * EventChain factory.
     *
     * @param required
     *   The list of events that are required before invoking the callback function.
     * @param cb
     *   The callback to invoke after all required events have been fired.
     *
     * @returns {Chain|exports|module.exports}
     */
    on: function(required, cb) {
      var chain = new Chain(config);
      chain.on(required, cb);
      return chain;
    }
  };
};
