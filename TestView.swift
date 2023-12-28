import SwiftUI


struct TestView: View {
    var body: some View {
        ExpandableView(thumbnail: ThumbnailView(content: {
            ZStack {
                Rectangle()
                    .foregroundStyle(.ultraThinMaterial)
                    .frame(height: 80)
                    .cornerRadius(10)
                Text("What is Promoninja?")
                    .font(.subheadline)
                    .fontWeight(.semibold)
                    .padding()
            }
        }), expanded: ExpandedView(content: {
            ZStack {
                Rectangle()
                    .foregroundStyle(.ultraThinMaterial)
                    .frame(height: 220)
                    .cornerRadius(10)
                Text("PromoNinja is a free platform that brings together podcast creators, listeners, and sponsors. It simplifies sponsorship management for creators, provides exclusive promotions for listeners, and offers increased reach for sponsors. It's an all in one application for anyone who enjoys podcasts and saving money.")
                    .font(.subheadline)
                    .fontWeight(.semibold)
                    .padding()
            }
        }))
    }
}


#Preview {
    TestView()
        .preferredColorScheme(.dark)
}
