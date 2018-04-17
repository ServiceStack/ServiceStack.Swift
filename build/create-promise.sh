#!/bin/sh

cat <<EOF > Promise.swift
//License: https://github.com/mxcl/PromiseKit/blob/master/LICENSE
import Foundation
import Dispatch
import class Dispatch.DispatchQueue
import class Foundation.NSError
import func Foundation.NSLog
import class Foundation.Thread
import struct Foundation.TimeInterval
import Foundation.NSProgress

let PMKErrorDomain:String = "PromiseKit"

let PMKFailingPromiseIndexKey:String = "PMKFailingPromiseIndexKey"
let PMKJoinPromisesKey:String = "PMKJoinPromisesKey"

let PMKUnexpectedError:Int = 1
let PMKInvalidUsageError:Int =  3
let PMKAccessDeniedError:Int =  4
let PMKOperationCancelled:Int =  5
let PMKOperationFailed:Int =  8
let PMKTaskError:Int =  9
let PMKJoinError:Int =  10


EOF

# v5.0.6 https://github.com/mxcl/PromiseKit/releases/tag/5.0.6 last version which can be combined, need to move to pkg manager after
SRC=../../PromiseKit/Sources

egrep -h -v '^(import|//)' \
      $SRC/after.swift \
      $SRC/AnyPromise.swift \
      $SRC/Box.swift \
      $SRC/Catchable.swift \
      $SRC/Configuration.swift \
      $SRC/CustomStringConvertible.swift \
      $SRC/Error.swift \
      $SRC/firstly.swift \
      $SRC/Guarantee.swift \
      $SRC/hang.swift \
      $SRC/Promise.swift \
      $SRC/race.swift \
      $SRC/Resolver.swift \
      $SRC/Thenable.swift \
      $SRC/when.swift \
      >> Promise.swift

# Remove `PromiseKit.` refs, e.g:
# sed '/PromiseKit\./d' Promise.swift > Promise.swift

cp Promise.swift ../src/ServiceStackClient/ServiceStackClient/
