import SwiftUI
import UIKit

struct CalendarView: UIViewRepresentable {
    @Binding var selectedDate: Date?
    @Binding var visibleMonth: DateComponents

    func makeUIView(context: Context) -> UICalendarView {
        let v = UICalendarView()
        v.calendar = .current
        v.locale   = .current
        v.visibleDateComponents = visibleMonth
        v.delegate  = context.coordinator
        v.selectionBehavior = UICalendarSelectionSingleDate(delegate: context.coordinator)
        return v
    }

    func updateUIView(_ uiView: UICalendarView, context: Context) {
        if uiView.visibleDateComponents != visibleMonth {
            uiView.visibleDateComponents = visibleMonth
        }
    }

    func makeCoordinator() -> Coordinator { Coordinator(self) }
    final class Coordinator: NSObject, UICalendarSelectionSingleDateDelegate, UICalendarViewDelegate {
        var parent: CalendarView
        init(_ parent: CalendarView) { self.parent = parent }
        func dateSelection(_ selection: UICalendarSelectionSingleDate, didSelectDate comps: DateComponents?) {
            parent.selectedDate = comps.flatMap { Calendar.current.date(from: $0) }
        }
    }
}
