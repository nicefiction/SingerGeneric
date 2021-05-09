// MARK: ContentView.swift

import SwiftUI
import CoreData



struct ContentView: View {
    
     // ////////////////////////
    //  MARK: PROPERTY WRAPPERS
    
    @Environment(\.managedObjectContext) var managedObjectContext
    
    @State private var filteredLetter: String = "A"
    
    
    
     // //////////////////////////
    //  MARK: COMPUTED PROPERTIES

    var body: some View {
        
        VStack(spacing : 10) {
            FilteredListView(filter : filteredLetter)
            Group {
                Button("Create Singers") {
                    let taylor = Singer(context : managedObjectContext)
                    taylor.firstName = "Taylor"
                    taylor.lastName = "Swift"
                    
                    let ed = Singer(context : managedObjectContext)
                    ed.firstName = "Ed"
                    ed.lastName = "Sheeran"

                    let adele = Singer(context : managedObjectContext)
                    adele.firstName = "Adele"
                    adele.lastName = "Adkins"
                    
                    try? managedObjectContext.save()
                }
                Button("Filter A") {
                    self.filteredLetter = "A"
                }
                Button("Filter S") {
                    self.filteredLetter = "S"
                }
            }
            .font(.title)
        }
    }
}





 // ///////////////
//  MARK: PREVIEWS

struct ContentView_Previews: PreviewProvider {
    
    static var previews: some View {
        
        ContentView()
    }
}
