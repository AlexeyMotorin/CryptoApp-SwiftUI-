//
//  StatisticView.swift
//  CryptoApp
//
//  Created by Алексей Моторин on 06.02.2024.
//

import SwiftUI

struct StatisticView: View {

    let stat: StatisticModel

    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(stat.title)
                .font(.caption)
                .foregroundColor(Color.theme.secondaryText)
            Text(stat.value)
                .font(.headline)
                .foregroundColor(Color.theme.accent)
            HStack(alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/, spacing: /*@START_MENU_TOKEN@*/nil/*@END_MENU_TOKEN@*/, content: {
                Image(systemName: L10.triangleFill)
                    .font(.caption)
                    .rotationEffect(
                        Angle(degrees: (stat.percentageChange ?? 0) >= 0 ? 0 : 180 )
                    )

                Text(stat.percentageChange?.asPercentString() ?? "")
                    .font(.caption)
                    .bold()
            })
            .foregroundColor((stat.percentageChange ?? 0) >= 0 ? Color.theme.green : Color.theme.red)
            .opacity(stat.percentageChange == nil ? 0 : 1)
        }
    }
}

// MARK: Preview
struct StatisticView_Previews: PreviewProvider {
    static var previews: some View {
        VStack(alignment: .leading, spacing: 30) {
            StatisticView(stat: dev.stat1)
            StatisticView(stat: dev.stat2)
            StatisticView(stat: dev.stat3)
        }
        .previewLayout(.sizeThatFits)
    }
}
