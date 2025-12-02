import SwiftUI

struct HabitCardView: View {
    let habit: HabitModel
    @StateObject private var blockController = BlockController()
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            // Habit Title
            Text(habit.title)
                .font(.custom("Mojangles", size: 24))
                .fontWeight(.bold)
                .foregroundColor(.white)
            
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
                                            .frame(width: 80, height: 80)
                                    case .failure:
                                        Image(systemName: "photo")
                                            .foregroundColor(.gray)
                                            .frame(width: 80, height: 80)
                                    case .empty:
                                        ProgressView()
                                            .frame(width: 80, height: 80)
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
                                            .frame(width: 80, height: 80)
                                    case .failure:
                                        Image(systemName: "photo")
                                            .foregroundColor(.gray)
                                            .frame(width: 80, height: 80)
                                    case .empty:
                                        ProgressView()
                                            .frame(width: 80, height: 80)
                                    @unknown default:
                                        EmptyView()
                                    }
                                }
                                .id("mystery")
                            }
                        }
                        .padding(.horizontal, (geometry.size.width - 80) / 2)
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
            .frame(height: 100)
            
            // Level and XP Bar
            VStack(spacing: 4) {
                // Level number
                Text("\(habit.level)")
                    .font(.custom("Mojangles", size: 16))
                    .fontWeight(.semibold)
                    .foregroundColor(.green)
                    .frame(maxWidth: .infinity, alignment: .center)
                
                // XP Bar
                Image("xp_bar")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(height: 20)
            }
        }
        .padding()
        .background(Color.gray.opacity(0.2))
        .cornerRadius(12)
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
