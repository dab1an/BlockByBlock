import SwiftUI

struct BlockCarouselView: View {
    @Binding var currentHabit: HabitModel
    @ObservedObject var blockController: BlockController
    
    var body: some View {
        GeometryReader { geometry in
            ScrollViewReader { proxy in
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 16) {
                        ForEach(Array(blockController.unlockedBlocks.enumerated()), id: \.element.id) { index, block in
                            BlockImageView(url: block.url).id(index)
                        }
                        if let mysteryBlock = blockController.mysteryBlock {
                            BlockImageView(url: mysteryBlock.url).id("mystery")
                        }
                    }
                    .padding(.horizontal, (geometry.size.width - 60) / 2)
                }
                .onChange(of: blockController.unlockedBlocks) { blocks in
                    if blocks.count >= 2 {
                        withAnimation { proxy.scrollTo(blocks.count - 1, anchor: .center) }
                    }
                }
            }
        }
        .padding(.top, 20)
        .frame(height: 80)
    }
}

struct BlockImageView: View {
    let url: String
    var body: some View {
        AsyncImage(url: URL(string: url)) { phase in
            switch phase {
            case .success(let image):
                image.resizable().aspectRatio(contentMode: .fit).frame(width: 60, height: 60)
            case .failure:
                Image(systemName: "photo").foregroundColor(.gray).frame(width: 60, height: 60)
            case .empty:
                ProgressView().frame(width: 60, height: 60)
            @unknown default:
                EmptyView()
            }
        }
    }
}
