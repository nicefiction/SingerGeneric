// MARK: ContentView.swift
/**
 SOURCE :
 https://www.hackingwithswift.com/books/ios-swiftui/dynamically-filtering-fetchrequest-with-swiftui
 
 For more flexibility ,
 we could improve our `FilteredLisView`
 so that it works with any kind of entity ,
 and can filter on any field .
 To make this work properly ,
 we need to make a few changes :
 `1.`Rather than specifically referencing the `Singer` class ,
 we are going to use generics with a constraint
 that whatever is passed in
 must be an `NSManagedObject` .
 `2.`We need to accept a second parameter
 to decide which key name we want to filter on ,
 because we might be using an entity that doesn’t have a `lastName` attribute .
 `3.`Because we don’t know ahead of time what each entity will contain ,
 we are going to let our containing view decide .
 So , rather than just using a text view of a singer’s name ,
 we are instead going to ask for a closure
 that can be run to configure the view however they want .
 */

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
            // FilteredListView(filter : filteredLetter)
            FilteredListView(filterKey : "lastName" ,
                             /**
                             NOTICE how I have specifically used `(singer: Singer)` as the closure’s parameter
                             — this is required
                             so that Swift understands
                             how `FilteredListView` is being used .
                             Remember ,
                             we said it could be any type of `NSManagedObject` ,
                             but in order for Swift to know exactly what type of managed object it is
                             we need to be explicit .
                             */
                             filterValue : filteredLetter) { (singer: Singer) in
                Text("\(singer.wrappedFirstName) \(singer.wrappedLastName)")
            }
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
