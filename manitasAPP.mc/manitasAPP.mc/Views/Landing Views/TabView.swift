import SwiftUI

enum Tab: String, CaseIterable {
    case person
    case house
    case gear
}

struct MyTabBar: View {
      @Binding var selectedTab: Tab
      private var fillImage: String {
        selectedTab.rawValue + ".fill"
     }
     var body: some View {
        VStack {
           HStack {
             ForEach(Tab.allCases, id: \.rawValue) { tab in
                 Spacer()
                 Image(systemName: selectedTab == tab ? fillImage : tab.rawValue)
                     .scaleEffect(selectedTab == tab ? 1.25 : 1.0)
                     .foregroundColor(selectedTab == tab ? Color("manitasAzul") : .gray)
                     .font(.system(size: 22))
                     .onTapGesture {
                          withAnimation(.easeIn(duration: 0.1)){
                              selectedTab = tab
                          }
                     }
                 Spacer()
               }
            }
            .frame(width: nil, height: 60)
            .background(.thinMaterial)
            .cornerRadius(10)
       }
    }
}

struct MyTabBar_Previews: PreviewProvider {
     static var previews: some View {
         MyTabBar(selectedTab: .constant(.house))
     }
}
