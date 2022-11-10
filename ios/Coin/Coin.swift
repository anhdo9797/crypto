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
            VStack(alignment: .leading) {
                Text("\(coin!.name) is on the way!")
                    .font(.title2)

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

}



