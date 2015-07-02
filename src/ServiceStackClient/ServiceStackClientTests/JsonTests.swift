#if true
//
//  JsonTests.swift
//  ServiceStackClient
//
//  Created by Demis Bellot on 3/22/15.
//  Copyright (c) 2015 ServiceStack LLC. All rights reserved.
//

import UIKit
import XCTest

class JsonTests: XCTestCase {

    func test_can_Serialize_TimeSpan() {
        let oneDay:NSTimeInterval = 24 * 60 * 60
        XCTAssertEqual(oneDay.toXsdDuration(),"P1D")
        let oneHour:NSTimeInterval = 60 * 60
        XCTAssertEqual(oneHour.toXsdDuration(),"PT1H")
        let oneMin:NSTimeInterval = 60
        XCTAssertEqual(oneMin.toXsdDuration(),"PT1M")
        let oneSec:NSTimeInterval = 1
        XCTAssertEqual(oneSec.toXsdDuration(),"PT1S")
        let oneMs:NSTimeInterval = 0.001
        XCTAssertEqual(oneMs.toXsdDuration(),"PT0.001S")

        let oneAll:NSTimeInterval = oneDay + oneHour + oneMin + oneSec + oneMs
        XCTAssertEqual(oneAll.toXsdDuration(),"P1DT1H1M1.001S")
    }

}
    
#endif
