//
//  CalendarView.swift
//  BlockByBlock
//

import SwiftUI
import UIKit

struct CalendarView: View {
    @State private var selectedDate: Date = Date()
    @EnvironmentObject var habitController: HabitController
    
    var filteredHabits: [HabitModel] {
        habitController.habits
    }
    
    var body: some View {

        ScrollView {
            ZStack {
                Image("CalendarBackground")
                    .resizable()
                    .aspectRatio(contentMode: .fill).frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
                        .edgesIgnoringSafeArea(.all)
                Color.black.opacity(0.4)
                                .ignoresSafeArea(.all)
                
                VStack {
                    Text("Overall")
                        .font(.custom("Mojangles", size: 36))
                        .foregroundColor(.white)
                        .shadow(color: .black, radius: 2, x: 2, y: 2)
                        .padding(.top, 50)
                    UIKitCalendar(selectedDate: $selectedDate)
                        .frame(height: 350)
                        .background(Color.white.opacity(0.9))
                        .cornerRadius(12)
                        .overlay(
                            RoundedRectangle(cornerRadius: 12)
                                .stroke(Color.white, lineWidth: 2)
                        )
                        .padding(.horizontal, 50) // Increased side padding
                        .padding(.bottom, 10)     // Added a little bottom spacing
                    
                    HabitStatsView(selectedDate: selectedDate, habits: filteredHabits)
                    
                    Spacer()
                }
            }
            .navigationTitle("")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}
    
    struct HabitStatsView: View {
        let selectedDate: Date
        let habits: [HabitModel]
        var overallRate: Int { 25 }
        var streak: Int { 1 }
        var habitsDone: Int { 0 }
        var body: some View {
            VStack(spacing: 24) {
                ZStack {
                    Circle()
                        .stroke(Color.white.opacity(0.3), lineWidth: 8)
                    Circle()
                        .trim(from: 0, to: CGFloat(overallRate) / 100)
                        .stroke(Color.green, style: StrokeStyle(lineWidth: 8, lineCap: .round))
                        .rotationEffect(.degrees(-90))
                    Text("\(overallRate)%\nOverall Rate")
                                        .multilineTextAlignment(.center)
                                        .font(.custom("Mojangles", size: 28))
                                        .foregroundColor(.white)
                                        .shadow(color: .black, radius: 1, x: 2, y: 2)
                }
                .frame(width: 180, height: 180)
                HStack(spacing: 40) {
                    VStack {
                        
                        Text("\(streak)")
                                                .font(.custom("Mojangles", size: 24))
                                                .foregroundColor(.green)
                                                .shadow(color: .black, radius: 1, x: 1, y: 1)
                                            
                                            Text("Streak")
                                                .font(.custom("Mojangles", size: 18))
                                                .foregroundColor(.white)
                                                .shadow(color: .black, radius: 1, x: 1, y: 1)
                                        }
                                        VStack {
                                            // ***Changed this- Updated Font to Mojangles
                                            Text("\(habitsDone)")
                                                .font(.custom("Mojangles", size: 24))
                                                .foregroundColor(.white)
                                                .shadow(color: .black, radius: 1, x: 1, y: 1)
                                            
                                            Text("Habits Done")
                                                .font(.custom("Mojangles", size: 18))
                                                .foregroundColor(.white)
                                                .shadow(color: .black, radius: 1, x: 1, y: 1)
                    }
                }
                .padding(.horizontal, 36)
                VStack(alignment: .leading, spacing: 8) {
                                Text("Done Today")
                                    .font(.custom("Mojangles", size: 18))
                                    .foregroundColor(.white)
                                    .shadow(color: .black, radius: 1, x: 1, y: 1)
                                    .padding(.bottom, 4)
                                
                                if habits.isEmpty {
                                    Text("No habits found")
                                        .font(.custom("Mojangles", size: 16))
                                        .foregroundColor(.gray)
                                } else {
                                    ForEach(habits) { habit in
                                        HStack {
                                            Image(systemName: "checkmark.square")
                                                .foregroundColor(.green)
                                            Text(habit.title)
                                                .font(.custom("Mojangles", size: 18))
                                                .foregroundColor(.white)
                                            Spacer()
                                        }
                                        .background(Color.white.opacity(0.1))
                                                                .cornerRadius(8)
                                                            }
                                                        }
                                                    }
                                                    .padding(16)
                                                    // ***Changed this- Black 85% opacity background with White Outline
                                                    .background(Color.black.opacity(0.85))
                                                    .cornerRadius(10)
                                                    .overlay(
                                                        RoundedRectangle(cornerRadius: 10)
                                                            .stroke(Color.white, lineWidth: 2)
                                                    )
                                                    .padding(.horizontal, 12)
                                                }
                                                .padding(.top)
                                            }
                                        }
    
    struct UIKitCalendar: UIViewRepresentable {
        @Binding var selectedDate: Date
        func makeUIView(context: Context) -> UICalendarView {
            let calendarView = UICalendarView()
            calendarView.calendar = .current
            calendarView.delegate = context.coordinator
            calendarView.selectionBehavior = UICalendarSelectionSingleDate(delegate: context.coordinator)
            return calendarView
        }
        func updateUIView(_ uiView: UICalendarView, context: Context) {
            // to implement: update UI if selectedDate changes
        }
        func makeCoordinator() -> Coordinator {
            Coordinator(self)
        }
        class Coordinator: NSObject, UICalendarViewDelegate, UICalendarSelectionSingleDateDelegate {
            var parent: UIKitCalendar
            init(_ parent: UIKitCalendar) {
                self.parent = parent
            }
            func dateSelection(_ selection: UICalendarSelectionSingleDate, didSelectDate dateComponents: DateComponents?) {
                if let date = dateComponents?.date {
                    parent.selectedDate = date
                }
            }
        }
    }

