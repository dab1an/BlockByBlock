import SwiftUI

struct XPBarView: View {
    let level: Int
    let progress: Double
    @State private var fillAmount: CGFloat = 0.0
    
    private var barImageName: String {
        switch progress {
        case 0..<0.25: return "xp_bar_empty"
        case 0.25..<0.5: return "xp_bar_25"
        case 0.5..<0.75: return "xp_bar_50"
        default: return "xp_bar_75"
        }
    }
    
    var body: some View {
        VStack(spacing: 4) {
            Text("\(level)")
                .font(.custom("Mojangles", size: 16))
                .fontWeight(.semibold)
                .foregroundColor(.green)
                .frame(maxWidth: .infinity, alignment: .center)
            // XP Bar with animation
            ZStack(alignment: .leading) {
                // Background: Empty Bar
                Image("xp_bar_empty")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                // Foreground: Dynamic XP Bar (Revealed by mask)
                Image(barImageName)    
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .mask(
                        GeometryReader { geo in
                            Rectangle()
                                .frame(width: geo.size.width * fillAmount)
                        }
                    )
            }
            .frame(height: 20)
        }
        .transition(.opacity)
        .onAppear {
            withAnimation(.easeInOut(duration: 1.0)) {
                fillAmount = 1.0
            }
        }
    }
}
