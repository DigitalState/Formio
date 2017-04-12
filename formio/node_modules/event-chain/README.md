# event-chain
A simple way to chain events and control program flow asynchronously.

This is an open source project under the MIT license, see [LICENSE.md](LICENSE.md) for additional information.

# Install
```
npm install --save event-chain
```

# Example
```javascript
var chain = require('event-chain')();

var example = chain.on(['one', 'two'], function() {
  console.log('foo');
});

example.emit('one');
example.emit('two');
// foo to console.
```

# Debug
Debugging is made possible with [Debug](https://www.npmjs.com/package/debug) and can be enabled by setting the
environment variable `event-chain`:

```
env DEBUG=event-chain
```

# API
##### chain.on(events, callback)

```javascript
/**
 * Create an event-chain that will execute the callback after all the events have been emitted.
 *
 * @param events
 *   An array of events (string) that are required before invoking the callback.
 * @param callback
 *   A callback function to be executed after all the provided events have been fired.
 *
 * @return
 *   A Chain object.
 */
chain.on(events, callback)
```

##### chain.emit(event)

```javascript
/**
 * Emit the given event for the chain.
 *
 * @param event
 *   Emit an event that was previously registered with chain.on();
 */
foo.emit(event);
```

# Options
Customized options are available for the chain.

```javascript
var chain = require('event-chain')(options);
```

##### options.complete (optional)
```
The event that is fired once all user-defined events have completed, used internally. Default: '__complete'
```
