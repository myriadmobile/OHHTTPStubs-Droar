//
//  OHHTTPStubs_Droar.swift
//  OHHTTPStubs-Droar
//
//  Created by Jangle's MacBook Pro on 4/8/21.
//

import UIKit
import Droar
import OHHTTPStubs_Bushel

@objc public class OHHTTPStubs_Droar: NSObject {
    @objc internal static let sharedInstance = OHHTTPStubs_Droar()
    private let dispatchOnce = DispatchOnce()
    
    override private init() {}
    
    static var cells = [DroarCell]()
    static var responseTime: TimeInterval?
    static var stubDescriptor: HTTPStubsDescriptor?
}

extension OHHTTPStubs_Droar: DroarKnob {
    enum Field: Int, CaseIterable {
        case enabled = 0
        case responseTime
        case networkError
    }
    
    public func droarKnobDidFinishRegistering() {
        dispatchOnce.perform {
            Swizzler.swizzleInstanceSelector(instance: HTTPStubsResponse(), origSelector: #selector(getter: HTTPStubsResponse.responseTime), newSelector: #selector(HTTPStubsResponse.getResponseTime_Swizzled))
        }
    }
    
    public func droarKnobTitle() -> String {
        return "OHHTTPStubs"
    }
    
    public func droarKnobPosition() -> PositionInfo {
        return PositionInfo(position: .top, priority: .medium)
    }
    
    public func droarKnobNumberOfCells() -> Int {
        OHHTTPStubs_Droar.cells = []
        return Field.allCases.count
    }
    
    public func droarKnobCellForIndex(index: Int, tableView: UITableView) -> DroarCell {
        var cell: DroarCell!
        
        switch Field(rawValue: index)! {
        case .enabled:
            return DroarSwitchCell.create(title: "Mock Enabled", defaultValue: HTTPStubs.isEnabled(), allowSelection: false) { (newValue) in
                HTTPStubs.setEnabled(newValue)
                OHHTTPStubs_Droar.cells.forEach({ $0.setEnabled(newValue) })
            }
            
        case .responseTime:
            let value = Float(OHHTTPStubs_Droar.responseTime ?? 0)
            cell = DroarSliderCell.create(title: "Response Time", value: value, min: 0.0, max: 10.0, allowSelection: true) { (newValue) in
                OHHTTPStubs_Droar.responseTime = TimeInterval(newValue)
            }
            
        case .networkError:
            let enabled = OHHTTPStubs_Droar.stubDescriptor != nil
            cell = DroarSwitchCell.create(title: "Simulate Network Error", defaultValue: enabled, allowSelection: false) { (newValue) in
                if newValue {
                    OHHTTPStubs_Droar.stubDescriptor = HTTPStubs.stubRequests { (request) -> Bool in
                        return true
                    } withStubResponse: { (request) -> HTTPStubsResponse in
                        return HTTPStubsResponse(error: DroarMockError())
                    }
                } else if let descriptor = OHHTTPStubs_Droar.stubDescriptor {
                    HTTPStubs.removeStub(descriptor)
                    OHHTTPStubs_Droar.stubDescriptor = nil
                }
            }
        }
        
        cell.setEnabled(HTTPStubs.isEnabled())
        OHHTTPStubs_Droar.cells.append(cell)
        
        return cell
    }
    
    public func droarKnobIndexSelected(tableView: UITableView, selectedIndex: Int) {
        switch Field(rawValue: selectedIndex) {
        default:
            ()
        }
    }
}

class DroarMockError: Error {}

extension HTTPStubsResponse {
    @objc func getResponseTime_Swizzled() -> TimeInterval {
        return OHHTTPStubs_Droar.responseTime ?? getResponseTime_Swizzled()
    }
}
