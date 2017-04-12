'use strict';

var EventEmitter = require('events').EventEmitter;
var uniq = require('lodash.uniq');
var debug = require('debug')('event-chain');

/**
 * The primary container for chained events.
 *
 * @param config
 *   An optional configuration object.
 *
 * @constructor
 */
var Chain = function(config) {
  this.events = new EventEmitter();
  this.config = config || {};

  // Allow someone to change the complete event label.
  if (!this.config.complete) {
    this.config.complete = '__complete';
  }

  debug('Chain created with the following configuration: ' + JSON.stringify(this.config));
};

/**
 * Register a function to execute once all the given events have been triggered.
 *
 * @param list
 *   The list of events to chain together.
 * @param cb
 *   The callback function to invoke after all events have been fired.
 */
Chain.prototype.on = function(list, cb) {
  if (!(list instanceof Array)) {
    throw new Error('The required events should be in an Array.');
  }

  if (typeof cb !== 'function') {
    throw new Error('A callback Function is required for the EventChain.');
  }

  if (list.length === 0) {
    throw new Error('An Array of events is required for the EventChain.')
  }

  // Confirm the event names are unique.
  list = uniq(list);

  // Iterate the given events and store them in the chain.
  debug('Chain initializing with the following events: ' + JSON.stringify(list));
  list.forEach(function(element) {
    if (typeof  element !== 'string') {
      throw new Error('All elements contained within the Events array must be strings, given: ' + typeof element
        + ' (' + element + ').');
    }

    // Register every event to be triggered once and make it check for chain completion upon being fired.
    debug('Event Added: ' + element);
    this.events.once(element, function() {
      debug('Event completed: ' + element);
      this.isComplete();
    }.bind(this));
  }.bind(this));

  // Register the complete callback.
  this.events.on(this.config.complete, cb);
};

/**
 * Checks all events contained within the chain and emits the complete event, if all have been invoked.
 */
Chain.prototype.isComplete = function() {
  var temp = Object.keys(this.events._events);

  debug('Testing for chain completeness: ' + JSON.stringify(temp));
  if (temp.length === 1 && temp[0] === this.config.complete) {
    debug('Received the complete event: ' + this.config.complete);
    this.events.emit(this.config.complete);
  }
};

/**
 *
 * @param finished
 *   The label of an event to mark as emitted.
 */
Chain.prototype.emit = function(finished) {
  // Iterate all known events in the chain and update the event with the provided label
  debug('Event triggered: ' + finished);
  this.events.emit(finished);
};

module.exports = Chain;
