//
//  ChangeCityView.swift
//  WeatherApp
//
//  Created by Adam Mhal on 8/12/24.
//

import SwiftUI

struct ChangeCityView: View {
    
    @FocusState private var focusedTextField: FocusTextField?
    
    enum FocusTextField {
        case city
    }
    
    let cityNamespace: Namespace.ID
    @State var ogName: String
    @ObservedObject var vm: MainWeatherViewModel
    
    var body: some View {
        VStack {
            
            Rectangle()
                .opacity(0.001)
                .onTapGesture {
                    validateCoords()
                }
            
            HStack(alignment:.center){
                TextEditor(text: $vm.combinedName)
                    .matchedGeometryEffect(id: "city", in: cityNamespace)
                    .scrollContentBackground(.hidden)
                    .frame(height: 100)
                    .multilineTextAlignment(.center)
                    .focused($focusedTextField, equals: .city)
                    .font(.system(size: 32,weight:.medium))
                    .foregroundStyle(vm.isNight ? Color.white : Color.black)
                    .padding()
                    .onChange(of: vm.combinedName) {
                        if !vm.combinedName.filter({ $0.isNewline }).isEmpty {
                            focusedTextField = nil
                            validateCoords()
                        }
                    }
                    .submitLabel(.done)
                
                
            }
            .onAppear {
                focusedTextField = .city
            }
            
            Rectangle()
                .opacity(0.0001)
                .onTapGesture {
                    validateCoords()
                }
        }
        .alert(item: $vm.alertItem) { alertItem in
            Alert(title: alertItem.title,
                  message: alertItem.message,
                  dismissButton: alertItem.dismissButton)
        }
        
    }
    
    func validateCoords() {
        if ogName != vm.combinedName {
            Task {
                do {
                    try await vm.getCurrentCoords()
                    vm.locationFound = true
                    withAnimation {
                        vm.isShowingCityView = false
                    }
                } catch {
                    vm.alertItem = AlertContext.unknownLocation
                }
            }
        } else {
            withAnimation {
                vm.isShowingCityView = false
            }
        }
    }
}

//#Preview {
//    ChangeCityView(isNight: false)
//}
