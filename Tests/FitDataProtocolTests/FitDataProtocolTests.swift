import XCTest
@testable import FitDataProtocol
import FitnessUnits
import AntMessageProtocol


class FitDataProtocolTests: XCTestCase {

    func testExample() {

        let fTime = FitTime(date: Date())


        let act = ActivityMessage(timeStamp: fTime,
                                  totalTimerTime: nil,
                                  localTimeStamp: nil,
                                  numberOfSessions: nil,
                                  activity: Activity.multisport,
                                  event: nil,
                                  eventType: nil,
                                  eventGroup: nil)


        let fiel = FileIdMessage(deviceSerialNumber: nil,
                                 fileCreationDate: fTime,
                                 manufacturer: Manufacturer.northPoleEngineering,
                                 product: nil,
                                 fileNumber: nil,
                                 fileType: FileType.activity,
                                 productName: nil)

        do {
            let encoder = FitFileEncoder(dataEncodingStrategy: .none)

            let data = try encoder.encode(fildIdMessage: fiel, messages: [act])
            print(data as NSData)

            do {
                var decoder = FitFileDecoder(crcCheckingStrategy: .throws)

                try decoder.decode(data: data, messages: FitFileDecoder.defaultMessages, decoded: { (message) in

                    print(message)
                })
                
            } catch  {
                print(error)
            }

        } catch  {
            print(error)
        }


    }


    static var allTests = [
        ("testExample", testExample),
    ]
}
