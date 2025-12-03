//
//  WeekView.swift
//  BlockByBlock
//
//  Created on 12/2/25.
//

import SwiftUI

struct WeekView: View {
    @State private var currentDate = Date()
    @State private var selectedDate: Date?
    
    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .bottom) {
                Image("grass_bg")
                    .resizable()
                    .scaledToFill()
                    .frame(width: geometry.size.width)
                    .ignoresSafeArea(edges: .top)
                
                HStack(spacing: 0) {
                    ForEach(weekDays, id: \.self) { day in
                        Button(action: {
                            selectedDate = day
                            print("🔘 Selected: \(dayOfWeekString(for: day)) \(Calendar.current.component(.day, from: day))")
                        }) {
                            VStack(spacing: 0) {
                                Text(dayOfWeekString(for: day))
                                    .font(.custom("Mojangles", size: 15))
                                    .foregroundColor(isToday(day) ? .black : .white)
                                
                                Text("\(Calendar.current.component(.day, from: day))")
                                    .font(.custom("Mojangles", size: 15))
                                    .foregroundColor(isToday(day) ? .black : .white)
                                    .frame(width: 32, height: 32)
                                    .padding(.top, -5)
                            }
                            .padding(.horizontal, 4)
                            .padding(.vertical, 4)
                            .background(
                                RoundedRectangle(cornerRadius: 4)
                                    .strokeBorder(isToday(day) ? Color.black : Color.clear, lineWidth: 2)
                            )
                            .frame(width: geometry.size.width / 7)
                        }
                    }
                }
                .frame(maxWidth: .infinity)
                .padding(.bottom, 5)
            }
        }
        .frame(height: 100)
    }
    
    private var weekDays: [Date] {
        var calendar = Calendar.current
        calendar.firstWeekday = 2
        
        let today = currentDate
        let weekday = calendar.component(.weekday, from: today)
        let daysFromMonday = (weekday + 5) % 7
        
        guard let monday = calendar.date(byAdding: .day, value: -daysFromMonday, to: today) else {
            return []
        }
        
        return (0..<7).compactMap { dayOffset in
            calendar.date(byAdding: .day, value: dayOffset, to: monday)
        }
    }
    
    private func dayOfWeekString(for date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "EEE"
        return formatter.string(from: date)
    }
    
    private func isToday(_ date: Date) -> Bool {
        Calendar.current.isDate(date, inSameDayAs: currentDate)
    }
}

#Preview {
    WeekView()
}


