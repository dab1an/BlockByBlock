import SwiftUI

struct CalendarScreen: View {
    @State private var selectedDate: Date? = nil
    @State private var visibleMonth: DateComponents =
        Calendar.current.dateComponents([.year, .month], from: Date())

    // placeholders
    @State private var overallRate: Double = 0.25
    @State private var currentStreak: Int = 1
    @State private var habitsDoneToday: Int = 0
    @State private var doneToday: [String] = ["Workout"]

    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 20) {

                    Card {
                        CalendarView(selectedDate: $selectedDate,
                                     visibleMonth: $visibleMonth)
                            .frame(height: 330)
                            .padding(.vertical, 14)
                            .padding(.horizontal, 12)
                    }
                    .padding(.horizontal, 20)
                    .padding(.top, 12)

                    // --- PROGRESS RING ---
                    ProgressRing(progress: overallRate)
                        .frame(width: 220, height: 220)

                    // --- STATS ROW ---
                    HStack(spacing: 16) {
                        StatBlock(value: "\(currentStreak)", title: "Streak")
                        Divider().frame(height: 42)
                        StatBlock(value: "\(habitsDoneToday)", title: "Habits Done")
                    }
                    .padding(.horizontal, 40)

                    Card {
                        VStack(alignment: .leading, spacing: 0) {
                            Text("Done Today")
                                .font(.headline)
                                .padding(.horizontal, 16)
                                .padding(.top, 12)
                                .padding(.bottom, 10)

                            Divider()

                            VStack(spacing: 10) {
                                ForEach(doneToday, id: \.self) { item in
                                    HStack(spacing: 12) {
                                        Image(systemName: "checkmark.square.fill")
                                            .foregroundStyle(.green)
                                        Text(item)
                                        Spacer()
                                    }
                                    .padding(.horizontal, 16)
                                    .padding(.vertical, 10)
                                    .background(
                                        RoundedRectangle(cornerRadius: 10, style: .continuous)
                                            .fill(Color(.secondarySystemBackground))
                                    )
                                    .padding(.horizontal, 12)
                                }
                            }
                            .padding(.vertical, 12)
                        }
                    }
                    .padding(.horizontal, 20)
                    .padding(.bottom, 28)
                }
                .frame(maxWidth: .infinity)
            }
            .background(Color(.systemGroupedBackground))
            .navigationBarTitleDisplayMode(.inline)
            .navigationTitle("Overall")
        }
    }
}

// Helpers

private struct Card<Content: View>: View {
    @ViewBuilder var content: Content
    var body: some View {
        content
            .background(
                RoundedRectangle(cornerRadius: 16, style: .continuous)
                    .fill(Color(.systemBackground))
            )
            .overlay(
                RoundedRectangle(cornerRadius: 16, style: .continuous)
                    .stroke(Color(.separator), lineWidth: 0.5)
            )
            .shadow(color: .black.opacity(0.06), radius: 10, x: 0, y: 4)
    }
}

private struct ProgressRing: View {
    var progress: Double
    var body: some View {
        ZStack {
            Circle().stroke(Color.secondary.opacity(0.2), lineWidth: 12)
            Circle()
                .trim(from: 0, to: progress)
                .stroke(
                    LinearGradient(colors: [Color(.systemGray3), Color(.systemGreen)],
                                   startPoint: .leading, endPoint: .trailing),
                    style: StrokeStyle(lineWidth: 12, lineCap: .round)
                )
                .rotationEffect(.degrees(-90))
            VStack(spacing: 4) {
                Text("\(Int(progress * 100))%")
                    .font(.system(size: 36, weight: .bold, design: .rounded))
                Text("Overall Rate").font(.subheadline).foregroundStyle(.secondary)
            }
        }
    }
}

private struct StatBlock: View {
    let value: String
    let title: String
    var body: some View {
        VStack(spacing: 6) {
            Text(value).font(.system(size: 22, weight: .semibold, design: .rounded))
            Text(title).font(.footnote).foregroundStyle(.secondary)
        }
        .frame(maxWidth: .infinity)
    }
}
