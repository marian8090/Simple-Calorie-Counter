import SwiftUI

private let portions: [(label: String, multiplier: Double)] = [
    ("½", 0.5), ("¾", 0.75), ("1×", 1.0),
    ("1¼", 1.25), ("1½", 1.5), ("2×", 2.0),
]

struct PortionConfirmView: View {
    let food: ReferenceFood
    let onAdd: (String, Int, String) -> Void

    @Environment(\.dismiss) var dismiss
    @State private var portionIndex = 2   // default 1×

    var multiplier: Double { portions[portionIndex].multiplier }
    var adjustedCalories: Int { Int(Double(food.calories) * multiplier) }
    var portionLabel: String { portions[portionIndex].label }

    var body: some View {
        NavigationView {
            VStack(spacing: 24) {
                // Food summary
                HStack(spacing: 12) {
                    Text(food.emoji).font(.system(size: 48))
                    VStack(alignment: .leading, spacing: 4) {
                        Text(food.name).font(.title3.weight(.bold))
                        if portionIndex == 2 {
                            Text("\(adjustedCalories) kcal").foregroundStyle(.blue)
                        } else {
                            Text("\(food.calories) → \(adjustedCalories) kcal (\(portionLabel))")
                                .foregroundStyle(.blue)
                        }
                    }
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding()
                .background(Color(.secondarySystemBackground))
                .clipShape(RoundedRectangle(cornerRadius: 14))

                // Portion picker
                VStack(alignment: .leading, spacing: 10) {
                    Text("Portion size")
                        .font(.subheadline.weight(.semibold))
                        .foregroundStyle(.secondary)

                    LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 3), spacing: 10) {
                        ForEach(0..<portions.count, id: \.self) { i in
                            Button {
                                portionIndex = i
                            } label: {
                                Text(portions[i].label)
                                    .font(.body.weight(.semibold))
                                    .frame(maxWidth: .infinity)
                                    .padding(.vertical, 12)
                                    .background(portionIndex == i ? Color.blue : Color(.secondarySystemBackground))
                                    .foregroundStyle(portionIndex == i ? .white : .primary)
                                    .clipShape(RoundedRectangle(cornerRadius: 10))
                            }
                            .buttonStyle(.plain)
                        }
                    }
                }

                Spacer()

                Button {
                    let name = portionIndex != 2
                        ? "\(food.name) (\(portionLabel))"
                        : food.name
                    onAdd(name, adjustedCalories, "reference food")
                } label: {
                    Text("Add to Today")
                        .font(.body.weight(.bold))
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.blue)
                        .foregroundStyle(.white)
                        .clipShape(RoundedRectangle(cornerRadius: 14))
                }
            }
            .padding()
            .navigationTitle("Confirm")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Cancel") { dismiss() }
                }
            }
        }
        .presentationDetents([.medium])
    }
}
