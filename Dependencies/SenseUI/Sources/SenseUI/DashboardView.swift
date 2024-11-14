import Charts
import SwiftUI

public struct DataPoint: Equatable {
    let label: String
    let value: Decimal
    let dateTime: Date

    public init(label: String, value: Decimal, dateTime: Date) {
        self.label = label
        self.value = value
        self.dateTime = dateTime
    }

    public static func == (lhs: DataPoint, rhs: DataPoint) -> Bool {
        lhs.label == rhs.label && lhs.value == rhs.value && lhs.dateTime.formatted(.dateTime) == rhs.dateTime.formatted(.dateTime)
    }
}

public struct DashboardStyle {
    let lineColor: Color
    let middleColor: Color

    public init(lineColor: Color, middleColor: Color) {
        self.lineColor = lineColor
        self.middleColor = middleColor
    }
}

public struct DashboardConfiguration {
    let upLabel: String
    let middleLabel: String
    let downLabel: String

    public init(upLabel: String, middleLabel: String, downLabel: String) {
        self.upLabel = upLabel
        self.middleLabel = middleLabel
        self.downLabel = downLabel
    }
}

public struct DashboardView: View {
    let style: DashboardStyle
    let configuration: DashboardConfiguration

    @State var selectedXPosition: String = ""
    @State var selectedHour: String? = Date().getHour()

    let dataPoints: [DataPoint]

    public init(
        style: DashboardStyle,
        configuration: DashboardConfiguration,
        dataPoints: [DataPoint]
    ) {
        self.style = style
        self.configuration = configuration
        self.dataPoints = dataPoints
    }

    public var body: some View {
        Chart {
            ForEach(dataPoints, id: \.dateTime) { dataPoint in
                LineMark(
                    x: .value("Hour", dataPoint.dateTime.getHour()),
                    y: .value("Value", dataPoint.value)
                )
                .interpolationMethod(.cardinal)
                .symbol(by: .value("Type", "Dopamine"))
                .foregroundStyle(style.lineColor.opacity(0.8))

                RuleMark(y: .value("Value", 0))
                    .foregroundStyle(style.middleColor.opacity(0.1))

                PointMark(
                    x: .value("Hour", dataPoint.dateTime.getHour()),
                    y: .value("Value", dataPoint.value)
                )
                .foregroundStyle(style.lineColor.opacity(0.5))
                .annotation(
                    position: dataPoint.value >= 0 ? .bottom : .top,
                    alignment: .center,
                    spacing: 10
                ) {
                    VStack {
                        Text(dataPoint.label)
                            .font(.system(size: 20, weight: .medium))
                        if dataPoint.value == .zero {
                            Text(configuration.middleLabel)
                                .font(.system(size: 18, weight: .regular))
                        } else {
                            Text(dataPoint.value > 0 ? configuration.upLabel : configuration.downLabel)
                                .font(.system(size: 18, weight: .regular))
                        }
                    }
                    .padding(8)
                    .background(style.lineColor.opacity(0.25))
                    .clipShape(RoundedRectangle(cornerRadius: 16))
                }

                BarMark(
                    x: .value("Hour", Date().getHour()),
                    y: .value("Value", 0)
                )
                .annotation {
                    VStack {
                        Label(
                            "Now",
                            systemImage: dataPoint.value > .zero ? "arrowtriangle.up.circle.fill" : "arrowtriangle.down.circle.fill"
                        )
                        .labelStyle(.titleAndIcon)
                        .font(.system(size: 14, weight: .medium))
                    }
                }

                if dataPoint.dateTime.getHour() != Date().getHour() {
                    BarMark(
                        x: .value("Hour", dataPoint.dateTime.getHour()),
                        y: .value("Value", 0)
                    )
                    .annotation {
                        VStack {
                            Label(
                                "\(dataPoint.dateTime.getHour())",
                                systemImage: dataPoint.value > .zero ? "arrowtriangle.up.circle.fill" : "arrowtriangle.down.circle.fill"
                            )
                            .labelStyle(.titleAndIcon)
                            .font(.system(size: 14, weight: .medium))
                        }
                    }
                }
            }
        }
        .chartYAxis {
            AxisMarks(stroke: StrokeStyle(lineWidth: 0))
        }
        .chartPlotStyle(content: { content in
            content
        })
        .chartXAxis(.hidden)
        .chartYAxis(.hidden)
        .chartLegend(.hidden)
        .scrollDisabled(false)
        .chartScrollableAxes(.horizontal)
        .chartXVisibleDomain(length: 1)
        .chartScrollPosition(initialX: Date().getHour())
        .chartScrollPosition(x: $selectedXPosition)
        .chartYScale(domain: .automatic)
    }
}

#if DEBUG
#Preview {
    DashboardView(
        style: .init(lineColor: .indigo, middleColor: .yellow),
        configuration: .init(
            upLabel: "High Dopamine",
            middleLabel: "Regular Dopamine",
            downLabel: "Low Dopamine"
        ),
        dataPoints: [
            DataPoint(label: "Coffee", value: 0, dateTime: Calendar.current.date(byAdding: .hour, value: -2, to: Date()) ?? Date()),
            DataPoint(
                label: "Coffee, Cigarettes",
                value: 150,
                dateTime: Calendar.current.date(byAdding: .hour, value: -1, to: Date()) ?? Date()
            ),
            DataPoint(
                label: "Coffee, Cigarettes",
                value: 100,
                dateTime: Calendar.current.date(byAdding: .hour, value: 1, to: Date()) ?? Date()
            ),
            DataPoint(
                label: "Coffee, Cigarettes",
                value: -50,
                dateTime: Calendar.current.date(byAdding: .hour, value: 2, to: Date()) ?? Date()
            ),
            DataPoint(label: "Cigarettes", value: 150, dateTime: Calendar.current.date(byAdding: .hour, value: 3, to: Date()) ?? Date()),
            DataPoint(label: "Cigarettes", value: -100, dateTime: Calendar.current.date(byAdding: .hour, value: 4, to: Date()) ?? Date()),
        ]
    )
}
#endif
