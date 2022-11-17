//
//  Coin.swift
//  Coin
//
//  Created by phuocanh on 08/11/2022.
//
import ActivityKit
import WidgetKit
import SwiftUI


struct LiveActivitiesAppAttributes: ActivityAttributes, Identifiable {
    public typealias LiveDeliveryData = ContentState

    public struct ContentState: Codable, Hashable {
        var data: Dictionary<String, String>
    }

    var id = UUID()
}


@available(iOSApplicationExtension 16.1, *)
struct Coin: Widget {

    var body: some WidgetConfiguration {
        ActivityConfiguration(for: LiveActivitiesAppAttributes.self) { context in
            // MARK: Lock screen
            let coin = CoinData(JSONData: context.state.data)
            let img = getSavedImage(named: coin?.symbol ?? "")
            VStack(alignment: .leading) {
                if img != nil {
                    Image(uiImage: img!)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 50, height: 50)
                }
                Spacer()
                VStack {
                    Text("$\(coin!.price)")
                        .font(.title3)
                        .bold()
                    Spacer()
                }

            }.padding(15)
        } dynamicIsland: { context in


            // MARK: Expanded view
            let coin = CoinData(JSONData: context.state.data)

            return DynamicIsland {
                DynamicIslandExpandedRegion(.leading) {
                    Text("\(coin!.symbol)".uppercased())
                        .lineLimit(1)
                    Image(systemName: "Logo")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 50, height: 50)
                    if let imageContainer = getSavedImage(named: "btc") {
                        Image(uiImage: imageContainer)
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 50, height: 50)
                    }
                }
                DynamicIslandExpandedRegion(.center) {
                    Text("$: \(coin!.price)")
                        .lineLimit(1)

                }
                DynamicIslandExpandedRegion(.bottom) {
                    HStack {
                        Button("Sell") {

                        }

                        Button("Buy") {

                        }
                    }
                        .buttonStyle(.bordered)
                }
            } compactLeading: {
                Text("\(coin!.symbol)".uppercased())

            } compactTrailing: {
                Text("\(coin!.price)")
                    .multilineTextAlignment(.center)
                    .frame(width: 40)
                    .font(.caption2)
            } minimal: {
                VStack(alignment: .center) {
                    Image(systemName: "timer")

                }
            }
                .keylineTint(.accentColor)
        }
    }

    func getSavedImage(named: String) -> UIImage? {
        if let dir = try? FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false) {
            print("path image: \(dir.absoluteString)")
            return UIImage(contentsOfFile: URL(fileURLWithPath: dir.absoluteString).appendingPathComponent(named).path)
        }
        return nil
    }

}



