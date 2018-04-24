//
//  TestInterfaceMarkerTests.swift
//  ServiceStackClient
//
//  Created by Demis Bellot on 9/21/15.
//  Copyright © 2015 ServiceStack LLC. All rights reserved.
//

import Foundation
import XCTest

class TestInterfaceMarkerTests: XCTestCase {
    var client:JsonServiceClient!
    
    override func setUp() {
        super.setUp()
        client = JsonServiceClient(baseUrl: "http://test.servicestack.net")
    }
    
    func test_Does_SendDefault_as_POST(){
        let request = SendDefault()
        request.id = 1
        
        do {
            let response = try client.send(request)
            XCTAssertEqual(response.id!, 1)
            XCTAssertEqual(response.requestMethod!, HttpMethods.Post)
            XCTAssertEqual(response.pathInfo!, "/json/reply/SendDefault")
        } catch {
            XCTFail()
        }
    }
    
    func test_Does_SendDefault_as_POST_Async(){
        let asyncTest = expectation(description:"asyncTest")

        let request = SendDefault()
        request.id = 1

        client.sendAsync(request)
            .map { (response: SendVerbResponse) in
                XCTAssertEqual(response.id!, 1)
                XCTAssertEqual(response.requestMethod!, HttpMethods.Post)
                XCTAssertEqual(response.pathInfo!, "/json/reply/SendDefault")
                
                asyncTest.fulfill()
            }.catch { _ in }

        waitForExpectations(timeout: 5, handler: { (error) in
            XCTAssertNil(error, "Error")
        })
    }
    
    func test_Does_SendRestGet_as_GET_using_Predefined_Route(){
        let request = SendRestGet()
        request.id = 1
        
        do {
            let response = try client.send(request)
            XCTAssertEqual(response.id!, 1)
            XCTAssertEqual(response.requestMethod!, HttpMethods.Get)
            XCTAssertEqual(response.pathInfo!, "/json/reply/SendRestGet")
        } catch {
            XCTFail()
        }
    }
    
    func test_Does_SendRestGet_as_GET_using_Predefined_Route_Async(){
        let asyncTest = expectation(description:"asyncTest")
        
        let request = SendRestGet()
        request.id = 1
        
        client.sendAsync(request)
            .map { (response: SendVerbResponse) in
                XCTAssertEqual(response.id!, 1)
                XCTAssertEqual(response.requestMethod!, HttpMethods.Get)
                XCTAssertEqual(response.pathInfo!, "/json/reply/SendRestGet")
                
                asyncTest.fulfill()
            }.catch { _ in }
        
        waitForExpectations(timeout: 5, handler: { (error) in
            XCTAssertNil(error, "Error")
        })
    }
    
    func test_Does_SendGet_as_GET(){
        let request = SendGet()
        request.id = 1
        
        do {
            let response = try client.send(request)
            XCTAssertEqual(response.id!, 1)
            XCTAssertEqual(response.requestMethod!, HttpMethods.Get)
            XCTAssertEqual(response.pathInfo!, "/json/reply/SendGet")
        } catch {
            XCTFail()
        }
    }
    
    func test_Does_SendGet_as_GET_Async(){
        let asyncTest = expectation(description:"asyncTest")
        
        let request = SendGet()
        request.id = 1
        
        client.sendAsync(request)
            .map { (response: SendVerbResponse) in
                XCTAssertEqual(response.id!, 1)
                XCTAssertEqual(response.requestMethod!, HttpMethods.Get)
                XCTAssertEqual(response.pathInfo!, "/json/reply/SendGet")
                
                asyncTest.fulfill()
            }.catch { _ in }
        
        waitForExpectations(timeout: 5, handler: { (error) in
            XCTAssertNil(error, "Error")
        })
    }
    
    func test_Does_SendPost_as_POST(){
        let request = SendPost()
        request.id = 1
        
        do {
            let response = try client.send(request)
            XCTAssertEqual(response.id!, 1)
            XCTAssertEqual(response.requestMethod!, HttpMethods.Post)
            XCTAssertEqual(response.pathInfo!, "/json/reply/SendPost")
        } catch {
            XCTFail()
        }
    }
    
    func test_Does_SendPost_as_POST_Async(){
        let asyncTest = expectation(description:"asyncTest")
        
        let request = SendPost()
        request.id = 1
        
        client.sendAsync(request)
            .map { (response: SendVerbResponse) in
                XCTAssertEqual(response.id!, 1)
                XCTAssertEqual(response.requestMethod!, HttpMethods.Post)
                XCTAssertEqual(response.pathInfo!, "/json/reply/SendPost")
                
                asyncTest.fulfill()
            }.catch { _ in }
        
        waitForExpectations(timeout: 5, handler: { (error) in
            XCTAssertNil(error, "Error")
        })
    }
    
    func test_Does_SendPut_as_PUT(){
        let request = SendPut()
        request.id = 1
        
        do {
            let response = try client.send(request)
            XCTAssertEqual(response.id!, 1)
            XCTAssertEqual(response.requestMethod!, HttpMethods.Put)
            XCTAssertEqual(response.pathInfo!, "/json/reply/SendPut")
        } catch {
            XCTFail()
        }
    }
    
    func test_Does_SendPut_as_PUT_Async(){
        let asyncTest = expectation(description:"asyncTest")
        
        let request = SendPut()
        request.id = 1
        
        client.sendAsync(request)
            .map { (response: SendVerbResponse) in
                XCTAssertEqual(response.id!, 1)
                XCTAssertEqual(response.requestMethod!, HttpMethods.Put)
                XCTAssertEqual(response.pathInfo!, "/json/reply/SendPut")
                
                asyncTest.fulfill()
            }.catch { _ in }
        
        waitForExpectations(timeout: 5, handler: { (error) in
            XCTAssertNil(error, "Error")
        })
    }
}
