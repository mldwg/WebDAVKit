//
//  WebDAVSession+Download.swift
//  WebDAVKit
//
//  Created by Matteo Ludwig on 10.12.25.
//  Licensed under the MIT-License included in the project.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
// SOFTWARE.
//

import Foundation

extension WebDAVSession {
    /// Downloads the data for the given path to a file and returns the URL to that file.
    /// - Parameters: request: The request to fetch the data for.
    /// - Returns: The URL to the downloaded data and the response.
    public func download(request: URLRequest) async throws -> (URL, HTTPURLResponse) {
        let (data, response) = try await self.urlSession.download(for: request)
        
        try WebDAVError.checkForError(response: response, data: nil)
        
        return (data, response as! HTTPURLResponse)
    }
    
    /// Downloads the data for the given path to a file and returns the URL to that file.
    /// - Parameters: path: The path to fetch the data for.
    /// - Parameters: headers: Any additional headers to use for the request.
    /// - Parameters: query: The query to use for the request.
    /// - Parameters: account: The account used to authorize the request.
    /// - Returns: The URL to the downloaded data and the response.
    public func download(from path: any WebDAVPathProtocol,
                         headers: [String: String]? = nil,
                         query: [String: String]? = nil,
                         account: any WebDAVAccount) async throws -> (URL, HTTPURLResponse) {
        let request = try self.authorizedRequest(method: .get, filePath: path, query: query, headers: headers, account: account)
        return try await self.download(request: request)
    }
}
