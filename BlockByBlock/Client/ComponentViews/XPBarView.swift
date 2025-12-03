import SwiftUI

struct XPBarView: View {
    let level: Int
    @State private var fillAmount: CGFloat = 0.0
    
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
                
                // Foreground: Full Bar (Revealed by mask)
                Image("xp_bar_full")
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
