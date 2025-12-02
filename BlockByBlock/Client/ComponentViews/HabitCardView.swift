import SwiftUI

struct HabitCardView: View {
    let habit: HabitModel
    @StateObject private var blockController = BlockController()
    // We use this single state to control the Button, the Top-Right X, and the XP Bar visibility
        @State private var isCheckedIn = false
    
    // ***Changed this- Added a state to control the XP bar fill animation (0.0 to 1.0)
        @State private var xpFillAmount: CGFloat = 0.0
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            // Habit Title
            HStack {
                // Habit Title
                Text(habit.title)
                    .font(.custom("Mojangles", size: 24))
                    .fontWeight(.bold)
                    .foregroundColor(.black)
                
                Spacer() // Pushes the button to the //
                // ***Changed this- Now always uses "Button" (blank) and overlays a Text "X" when checked in.
                                Button(action: {
                                    // Logic remains: Only clickable if already checked in (to Undo)
                                    if isCheckedIn {
                                        withAnimation {
                                            isCheckedIn = false
                                        }
                                    }
                                }) {
                                    ZStack {
                                        // Always use the blank button background
                                        Image("Button")
                                            .renderingMode(.original)
                                            .resizable()
                                            .aspectRatio(contentMode: .fit)
                                            .frame(height: 20)
                                        
                                        // ***Changed this- Overlays a crisp "X" only when checked in
                                        if isCheckedIn {
                                            Text("X")
                                                .font(.custom("Mojangles", size: 14)) // Adjusted size to fit inside the small button
                                                .foregroundColor(.white)
                                                .shadow(color: .black.opacity(0.5), radius: 1, x: 1, y: 1)
                                        }
                                    }
                                }
                                .buttonStyle(PlainButtonStyle())
                            }
            // Scrollable Block Carousel
            GeometryReader { geometry in
                ScrollViewReader { proxy in
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(alignment: .center, spacing: 16) {
                            // Unlocked blocks
                            ForEach(Array(blockController.unlockedBlocks.enumerated()), id: \.element.id) { index, block in
                                AsyncImage(url: URL(string: block.url)) { phase in
                                    switch phase {
                                    case .success(let image):
                                        image
                                            .resizable()
                                            .aspectRatio(contentMode: .fit)
                                            .frame(width: 60, height: 60)
                                    case .failure:
                                        Image(systemName: "photo")
                                            .foregroundColor(.gray)
                                            .frame(width: 60, height: 60)
                                    case .empty:
                                        ProgressView()
                                            .frame(width: 60, height: 60)
                                    @unknown default:
                                        EmptyView()
                                    }
                                }
                                .id(index)
                            }
                            
                            // Mystery block
                            if let mysteryBlock = blockController.mysteryBlock {
                                AsyncImage(url: URL(string: mysteryBlock.url)) { phase in
                                    switch phase {
                                    case .success(let image):
                                        image
                                            .resizable()
                                            .aspectRatio(contentMode: .fit)
                                            .frame(width: 60, height: 60)
                                    case .failure:
                                        Image(systemName: "photo")
                                            .foregroundColor(.gray)
                                            .frame(width: 60, height: 60)
                                    case .empty:
                                        ProgressView()
                                            .frame(width: 60, height: 60)
                                    @unknown default:
                                        EmptyView()
                                    }
                                }
                                .id("mystery")
                            }
                        }
                        .padding(.horizontal, (geometry.size.width - 60) / 2)
                    }
                    .onChange(of: blockController.unlockedBlocks) { blocks in
                        // Scroll to second to last block (last user unlocked block)
                        if blocks.count >= 2 {
                            let secondToLastIndex = blocks.count - 1
                            withAnimation {
                                proxy.scrollTo(secondToLastIndex, anchor: .center)
                            }
                        }
                    }
                }
            }
            // ***Changed this- Added top padding here to push the blocks down away from the title
                        .padding(.top, 20)
                        .frame(height: 80)
            
            // XP Bar and Level (Only visible when checked in)
            if isCheckedIn {
                            VStack(spacing: 4) {
                                Text("\(habit.level + 1)")
                                    .font(.custom("Mojangles", size: 16))
                                    .fontWeight(.semibold)
                                    .foregroundColor(.green)
                                    .frame(maxWidth: .infinity, alignment: .center)
                                
                                // ***Changed this- Implemented dynamic XP Bar animation using masking
                                ZStack(alignment: .leading) {
                                    // 1. Background: Empty Bar
                                    Image("xp_bar_empty")
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                    
                                    // 2. Foreground: Full Bar (Revealed by mask)
                                    Image("xp_bar_full")
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .mask(
                                            GeometryReader { geo in
                                                Rectangle()
                                                    // The width of the rectangle depends on xpFillAmount (0.0 to 1.0)
                                                    .frame(width: geo.size.width * xpFillAmount)
                                            }
                                        )
                                }
                                .frame(height: 20)
                            }
                            .transition(.opacity)
                            .onAppear {
                                // ***Changed this- Triggers the fill animation when the bar appears
                                withAnimation(.easeInOut(duration: 1.0)) {
                                    xpFillAmount = 1.0
                                }
                            }
                        }
                        
                        // "CHECK IN" Button (Only visible when NOT checked in)
                        if !isCheckedIn {
                            Button(action: {
                                withAnimation {
                                    isCheckedIn = true
                                }
                            }) {
                                ZStack {
                                    Image("Button 1")
                                        .renderingMode(.original)
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .frame(height: 44)
                                        .frame(maxWidth: .infinity)
                                    
                                    Text("CHECK IN")
                                        .font(.custom("Mojangles", size: 20))
                                        .foregroundColor(.white)
                                        .shadow(color: .black.opacity(0.5), radius: 1, x: 1, y: 1)
                                }
                            }
                            .buttonStyle(PlainButtonStyle())
                            .frame(maxWidth: .infinity)
                            .padding(.top, 8)
                        }
                    }
        // ***Changed this- Added specific top padding to push content down, while keeping other padding standard
                .padding(.top, 30)
                .padding(.horizontal, 40)
                .padding(.bottom, 20)
                .background(Image("HabitCard").resizable())
                .task {
                    await blockController.loadBlocksForHabit(habit)
        }
    }
    }


#Preview {
    HabitCardView(
        habit: HabitModel(
            id: UUID(),
            userId: UUID(),
            title: "Read Book",
            level: 25,
            createdAt: Date(),
            updatedAt: Date()
        )
    )
    .padding()
    .background(Color.black)
}
