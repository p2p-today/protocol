# Abstract

This document is meant to describe a peer-to-peer networking protocol that can
be reasonably implemented in any popular language. Its principle goals are

1. Must work with nodes which can only initiate connections ✓
    1. Caveat: at least one node must be able to accept connections ✓
2. Must be capable of network-wide broadcasts ✓
    1. Must scale better than O(N^2)
    2. Lag factor (compared to hub-and-spoke) must be < O(N)
3. Must be capable of broadcasting only to direct peers ✓
4. Must be capable of sending messages to specific nodes ✓
    1. And be able to optionally encrypt it (opt-in or opt-out)
5. Should have public keys as address
6. Should be able to support a Kademlia-like distributed hash table
    1. This table should be able to have locks
    2. This table should be able to support atomic changes
    3. This table should be able to support diff-based changes

# Notes

While this document will make references to object diagrams, please be aware
that we are not dictating how you must implement things. If a different
implementation can achieve the same results, then by all means use it,
especially if it's simpler.

Also, this document will largely be written with Python in mind, partly because
it reads like pseudocode, and partly because I am most comfortable with it. I
will try to use type annotations as a guide for static languages.

# Constants

## Network Constants

These are the set of constants which manage network topology. They determine
things like how many peers one can have, or the number of bits in your address
space. Explanations will be given when these numbers are non-arbitrary.

* `ℓ`: The limit on a nodes self-initiated connections
* `k`: Kademlia's replication parameter (longest size of k-bucket)
* `α`: Kademlia's concurrency parameter (number of parallel lookups)
* `τ`: Kademlia's address size (number of bits to consider per address/hash)

## Opcodes

These are the values of the various opcodes used in this project. While they are
arbitrary, they are chosen to take the smallest space possible when serialized.

* `ACK`: 0
* `NACK`: 1
* `PING`: 2
* `SET_CONNECTION_OPT`: 3
* `SHOUT`: 4
* `SPEAK`: 5
* `WHISPER`: 6
* `FIND_NODE`: 7
* `FIND_VALUE`: 8
* `STORE`: 9

## Connection Options

These are the values of the various connection options used in this project. In
the lexicon of this paper, "Option" will refer to a key, while "setting" will
refer to a value. So for the compression option, you can have a setting `zlib`.
While they are arbitrary, they are chosen to take the smallest space possible
when serialized.

## Connection Settings

These are the values of the various connection settings used in this project. In
the lexicon of this paper, "Option" will refer to a key, while "setting" will
refer to a value. So for the compression option, you can have a setting `zlib`.
While they are arbitrary, they are chosen to take the smallest space possible
when serialized.

### Compression

Option: 0

Settings:

* `bz2`: 0
* `gzip`: 1
* `lzma`: 2
* `zlib`: 3
* `snappy`: 4

### Preferred Compression

Option: 1

Settings:

* `bz2`: 0
* `gzip`: 1
* `lzma`: 2
* `zlib`: 3
* `snappy`: 4

# Message Format

# Object Overview

## Basic Structure

## Protocol Parsing

## Connection Management

# RPCs

This section describes how your node should respond to incoming network messages

## ACK *

This is the RPC that should be sent back to acknowledge a network message as
successful, and provide return data if necessary.

## NACK *

This is the RPC that should be sent back to acknowledge a network message as
failed, and provide return data if necessary.

## PING

Always respond with `ACK PING`. This will be utilized heavily in datagram protocols
like UDP or µTP.

## SET_CONNECTION_OPT \<option> \<setting>

This will take two arguments. The first will be the option you wish to set, and
the second is what you will set it to. Typically this will be something like
enabling a compression method, or setting one as preferred.

Should either respond `ACK SET_CONNECTION_OPT <option> <setting>` or
`NACK SET_CONNECTION_OPT <option> <setting>`, depending on if your node supports
this setting.

## SHOUT \<message>

This indicates that a message should be forwarded to all peers if you have not
previously seen it. `ACK`s are ill-advised here.

## SPEAK \<message>

This indicates that a message may be forwarded to all peers *at your
discretion*, if you have not previously seen it. By default a node should *not*
forward it, but there are some situations where it might be desirable.

`ACK`s are not necessary except on UDP-like transports, since the nodes
receiving this message are directly connected. If it is difficult to implement
this conditional, send the `ACK` by default.

## WHISPER \<message>

This indicates that a message should *not* be forwarded to *anyone*. The message
may or not be encrypted. That should be handled on the message parser level.

Acknowledge these messages in the format `ACK WHISPER <sig or hash of message>`.

## FIND_NODE

## FIND_VALUE

### If Value Unknown

### If Value Known

## STORE

# Public API
