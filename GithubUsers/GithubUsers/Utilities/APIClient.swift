//
//  APIClass.swift

import Foundation
import Alamofire

class APIClient: NSObject {
    
    var loopCount: Int!
    var responseModel: APIResponseModel?
    
    required override init() {
        loopCount = 0                 
    }
    
    func postData(parameters:[String:Any]?, wholeAPIUrl:String, httpMethod: HTTPMethod, delegate: BaseViewController, completionHandler: ((APIResponseModel?) -> Void)!) -> Void {
        self.loopCount += 1
        delegate.startLoading()
        
        if let para = parameters {
            print("Parameters = \(para)")
        }
        Alamofire.request(wholeAPIUrl, method: httpMethod, parameters: parameters, encoding: JSONEncoding.prettyPrinted, headers: nil).responseJSON { response in
            print("\(wholeAPIUrl) response = \(String(describing: response.result.value))")
            switch response.result {
            case .success(let value) :
                delegate.stopLoading()
                let response = value as! [String : Any]
                do {
                    
                    let jsonData = try JSONSerialization.data(withJSONObject: response, options: .prettyPrinted)
                    self.responseModel = try JSONDecoder().decode(APIResponseModel.self, from: jsonData)
                    
                } catch {
                    print("Unexpected error: \(error).")
                }
                completionHandler(self.responseModel)
                break
            case .failure(let encodingError):
                print(encodingError)
                delegate.stopLoading()
                if let err = encodingError as? URLError, err.code == .notConnectedToInternet {
                    print("NO INTERNET CONNECTION")
                    delegate.showAlertWithErrorMessage("NO INTERNET CONNECTION")
                } else {
                    if self.loopCount == 2 {
                        print("Loop error = ", "SOMETHING WENT WRONG")
                        delegate.showAlertWithErrorMessage("SOMETHING WENT WRONG")
                    } else {
                        print("Loop count = \(String(describing: self.loopCount))")
                        self.postData(parameters: parameters, wholeAPIUrl: wholeAPIUrl, httpMethod: httpMethod, delegate: delegate, completionHandler: completionHandler)
                        return
                    }
                }
                break
            }
        }
    }
}
