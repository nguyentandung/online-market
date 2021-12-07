//
//  UploadLargeFile.swift
//  VNMM
//
//  Created by Nguyen Tan Dung on 04/27/21.
//

import Foundation
import Alamofire
import ObjectMapper


class Networking {
  static let sharedInstance = Networking()
  public var sessionManager: Alamofire.SessionManager // most of your web service clients will call through sessionManager
  public var backgroundSessionManager: Alamofire.SessionManager // your web services you intend to keep running when the system backgrounds your app will use this
  private init() {
    self.sessionManager = Alamofire.SessionManager(configuration: URLSessionConfiguration.default)
    self.backgroundSessionManager = Alamofire.SessionManager(configuration: URLSessionConfiguration.background(withIdentifier: "com.lava.app.backgroundtransfer"))
  }
}

class VideoUploadClient {
    class func uploadWithUrl(serverUrl: URL, headers: HTTPHeaders, videoURL: URL, filename: String, progressing: ((Double) -> Void)?, success: ((DataResponse<Any>) -> Void)?, failure: ((Error) -> Void)?) {
    
        Networking.sharedInstance.backgroundSessionManager.upload(multipartFormData: { (multipartData) in
            multipartData.append(videoURL, withName: "send_file", fileName: filename, mimeType: "video/mp4")
        }, usingThreshold: SessionManager.multipartFormDataEncodingMemoryThreshold, to: serverUrl, method: .post, headers: headers, encodingCompletion: { encodingResult in
          // transmission closure
            switch (encodingResult) {
            // encodingResult success
            case .success(let request, _, _):
                // upload progress closure
                request.uploadProgress(closure: { (progress) in
                    print("upload progress: \(progress.fractionCompleted)")
                    progressing!(progress.fractionCompleted)
                })
        
                // response handler
                request.responseJSON(completionHandler: { response in
                    switch response.result {
                    case .success( _):
                        // do any parsing on your request's response if needed
                        success?(response)
                        
                    case .failure(let error):
                        failure?(error)
                    }
                })
            
            // encodingResult failure
            case .failure(let error):
                failure?(error)
            
            } // end encodingresult switch
        }) // end upload call
    
  }
    
    class func uploadWithData(serverUrl: URL, headers: HTTPHeaders, fileData: Data, filename: String, progressing: ((Double) -> Void)?, success: ((DataResponse<Any>) -> Void)?, failure: ((Error) -> Void)?) {
        print("\(serverUrl.absoluteString)")
        Networking.sharedInstance.backgroundSessionManager.upload(multipartFormData: { (multipartData) in
            multipartData.append(fileData, withName: "send_file", fileName: filename, mimeType: "image")
        }, usingThreshold: SessionManager.multipartFormDataEncodingMemoryThreshold, to: serverUrl, method: .post, headers: headers, encodingCompletion: { encodingResult in
            // transmission closure
            switch (encodingResult) {
            // encodingResult success
            case .success(let request, _, _):
                // upload progress closure
                request.uploadProgress(closure: { (progress) in
                    print("upload progress: \(progress.fractionCompleted)")
                    progressing?(progress.fractionCompleted)
                })
        
                // response handler
                request.responseJSON(completionHandler: { response in
                    switch response.result {
                    case .success( _):
                        // do any parsing on your request's response if needed
                        success?(response)
                        
                      case .failure(let error):
                        failure?(error)
                    }
                })
            
            // encodingResult failure
            case .failure(let error):
              failure?(error)
            
          } // end encodingresult switch
        }) // end upl
    }
    
    class func uploadWithData(serverUrl: URL, headers: HTTPHeaders, fileData: Data, filename: String, withName: String, progressing: ((Double) -> Void)?, success: ((DataResponse<Any>) -> Void)?, failure: ((Error) -> Void)?) {
        print("\(serverUrl.absoluteString)")
        Networking.sharedInstance.backgroundSessionManager.upload(multipartFormData: { (multipartData) in
            multipartData.append(fileData, withName: withName, fileName: filename, mimeType: "image")
        }, usingThreshold: SessionManager.multipartFormDataEncodingMemoryThreshold, to: serverUrl, method: .post, headers: headers, encodingCompletion: { encodingResult in
            // transmission closure
            switch (encodingResult) {
            // encodingResult success
            case .success(let request, _, _):
                // upload progress closure
                request.uploadProgress(closure: { (progress) in
                    print("upload progress: \(progress.fractionCompleted)")
                    progressing?(progress.fractionCompleted)
                })
        
                // response handler
                request.responseJSON(completionHandler: { response in
                    switch response.result {
                    case .success( _):
                        // do any parsing on your request's response if needed
                        success?(response)
                        
                      case .failure(let error):
                        failure?(error)
                    }
                })
            
            // encodingResult failure
            case .failure(let error):
              failure?(error)
            
          } // end encodingresult switch
        }) // end upl
    }
    
    class func uploadWithDataGroup(serverUrl: URL, headers: HTTPHeaders, fileData: Data, filename: String, progressing: ((Double) -> Void)?, success: ((DataResponse<Any>) -> Void)?, failure: ((Error) -> Void)?) {
        Networking.sharedInstance.backgroundSessionManager.upload(multipartFormData: { (multipartData) in
            multipartData.append(fileData, withName: "send_file", fileName: filename, mimeType: "image")
        }, usingThreshold: SessionManager.multipartFormDataEncodingMemoryThreshold, to: serverUrl, method: .post, headers: headers, encodingCompletion: { encodingResult in
            // transmission closure
            switch (encodingResult) {
            // encodingResult success
            case .success(let request, _, _):
                // upload progress closure
                request.uploadProgress(closure: { (progress) in
                    print("upload progress: \(progress.fractionCompleted)")
                    progressing!(progress.fractionCompleted)
                })
        
                // response handler
                request.responseJSON(completionHandler: { response in
                    switch response.result {
                    case .success( _):
                        // do any parsing on your request's response if needed
                        success?(response)
                        
                      case .failure(let error):
                        failure?(error)
                    }
                })
            
            // encodingResult failure
            case .failure(let error):
              failure?(error)
            
          } // end encodingresult switch
        }) // end upl
    }
} // end VideoUploadClient class
