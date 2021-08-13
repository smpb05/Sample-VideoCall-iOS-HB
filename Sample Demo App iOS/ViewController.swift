//
//  ViewController.swift
//  Sample Demo App iOS
//
//  Created by smartex on 12.08.2021.
//

import UIKit
import TSAVideoCallSDKHB

class ViewController: UIViewController {

    var session: TSAVideoCallSession?
    var publisher: TSAVideoCallPublisher?
    var subscriber: TSAVideoCallSubscriber?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let config = TSAVideoCallConfig(webUrl: "enter-url",
                                        webSocketMediaServerUrl: "enter-url",
                                        webSocketBrokerUrl: "enter-url",
                                        webSocketBrokerPath: "enter-path",
                                        callHash: "enter-callHash",
                                        authData: "enter-credentials")
        
       initSession(config: config)
    }


    private func initSession(config: TSAVideoCallConfig){
        session = TSAVideoCallSession(config: config)
        session?.sessionDelegate = self
        session?.connect()
    }
    
    
    private func initializePublisher( _ session: TSAVideoCallSession){
        publisher = TSAVideoCallPublisher(session: session)
        if let publisher = publisher{
            publisher.delegate = self
            session.publish(publisher: publisher)
        }
    }
    
    private func initializeSubscriber(session: TSAVideoCallSession, stream: TSAVideoCallStream){
        subscriber = TSAVideoCallSubscriber(session: session, stream: stream, frame: CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height))
        subscriber?.delegate = self
        if let subscriber = subscriber{
            session.subscribe(subscriber: subscriber)
            view.addSubview(subscriber.getVideoView())
        }
    }
    
}

extension ViewController: TSAVideoCallSessionDelegate, TSAVideoCallPublisherDelegate, TSAVideoCallSubscriberDelegate{
    
    //publisher
    func onStreamCreated(publisher: TSAVideoCallPublisher) {
        let publisherVideoView = publisher.getVideoView()
        publisherVideoView.frame = CGRect(x: view.frame.width*0.7, y: view.frame.height*0.7, width: view.frame.width*0.4, height: view.frame.height*0.3)
        publisherVideoView.layer.zPosition = 1
        view.addSubview(publisherVideoView)
    }
    
    func onStreamDestroyed(publisher: TSAVideoCallPublisher) {
        
    }
    
    func onError(publisher: TSAVideoCallPublisher, error: TSAVideoCallError) {
        
    }
    
    
    //subscriber
    func onConnected(subscriber: TSAVideoCallSubscriber) {
        
    }
    
    func onDisconnected(subcriber: TSAVideoCallSubscriber) {
        
    }
    
    func onError(subscriber: TSAVideoCallSubscriber, error: TSAVideoCallError) {
        
    }
    
    
    //session
    func onConnected(session: TSAVideoCallSession) {
        initializePublisher(session)
    }
    
    func onDisconnected(session: TSAVideoCallSession) {
        
    }
    
    func onStreamReceived(session: TSAVideoCallSession, stream: TSAVideoCallStream) {
        initializeSubscriber(session: session, stream: stream)
    }
    
    func onStreamDropped(session: TSAVideoCallSession, stream: TSAVideoCallStream) {
        
    }
    
    func onMessageReceived(session: TSAVideoCallSession, message: String) {
        
    }
    
    func onFileReceived(session: TSAVideoCallSession, fileName: String, filePath: String) {
        
    }
    
    func onError(session: TSAVideoCallSession, error: TSAVideoCallError) {
        
    }
    
}


