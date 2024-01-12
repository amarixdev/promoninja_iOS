import SwiftUI

struct TruncateView: View {
    let text:String
    static let maxTruncatedValue = 150
    @State private var isExpanded = false
    var toggleText: String {
        isExpanded ? " show less" : " see more"
    }
    
    var showToggle: Bool {
        text.count <= Self.maxTruncatedValue ? false : true
    }
    
     var body: some View {
         HStack {
             Text( isExpanded ? text : text.truncated(Self.maxTruncatedValue))
             +
             Text(showToggle ? "[\(toggleText)](myappurl://action)" : "")
                 .fontWeight(.bold)
             
         }
         .multilineTextAlignment(.leading)
         .font(.subheadline)
         .opacity(0.8)
         .frame(width: UIScreen.main.bounds.width / 1.15, alignment: .leading)
         .onOpenURL { _ in
             withAnimation {
                 isExpanded.toggle()
                 print(text.count <= Self.maxTruncatedValue)
             }
         }
         .padding(.vertical, 20)
     }
}


#Preview {
    TruncateView(text: "Flagrant is a comedy podcast that delivers unfiltered, unapologetic, and unruly hot takes directly to your dome piece. In an era dictated by political correctness, hosts Andrew Schulz and Akaash Singh, along with AlexxMedia and Mark Gagnon, could care less about sensitivities. If it’s funny and flagrant it flies. If you are sensitive this podcast is not for you. But if you miss the days of comedians actually being funny instead of preaching to a choir then welcome " )
        .preferredColorScheme(.dark)
}
