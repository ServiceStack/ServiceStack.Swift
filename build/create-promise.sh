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

SRC=../src/ServiceStackClient/PromiseKit-4.0.5/Sources

egrep -h -v '^(import|//)' \
      $SRC/after.swift \
      $SRC/AnyPromise.swift \
      $SRC/DispatchQueue+Promise.swift \
      $SRC/Error.swift \
      $SRC/join.swift \
      $SRC/Promise+Properties.swift \
      $SRC/Promise.swift \
      $SRC/race.swift \
      $SRC/State.swift \
      $SRC/SwiftPM.swift \
      $SRC/when.swift \
      $SRC/wrap.swift \
      $SRC/Zalgo.swift \
      >> Promise.swift

cp Promise.swift ../src/ServiceStackClient/ServiceStackClient/