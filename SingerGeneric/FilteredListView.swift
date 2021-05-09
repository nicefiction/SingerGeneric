// MARK: FilteredListView.swift

import SwiftUI
import CoreData



// struct FilteredListView: View {
/**
 ⭐️
 Rather than specifically referencing the Singer class ,
 we are going to use generics with a constraint
 that whatever is passed in
 must be an `NSManagedObject` :
 */
struct FilteredListView<T: NSManagedObject , Content: View>: View {
    
     // /////////////////
    //  MARK: PROPERTIES
    
    // var fetchRequest: FetchRequest<Singer>
    var fetchRequest: FetchRequest<T>
    
    /**
     ⭐️
     Because we don’t know ahead of time what each entity will contain ,
     we are going to let our containing view decide .
     So , rather than just using a Text view of a singer’s name ,
     we are instead going to ask for a closure
     that can be run to configure the view however they want .
     */
    let content: (T) -> Content
    
    
    
     // //////////////////////////
    //  MARK: COMPUTED PROPERTIES
    
    // var singers: FetchedResults<Singer> {
    var singers: FetchedResults<T> {
        
        return fetchRequest.wrappedValue
    }
    
    
    var body: some View {
        
        List {
            ForEach(singers , id : \.self) { (singer: T) in
                // Text("\(singer.wrappedFirstName) \(singer.wrappedLastName)")
                self.content(singer)
                /**
                 This is our `content` closure ;
                 we will call this once
                 for each item in the list .
                 */
            }
        }
    }
    
    
    
     // //////////////////////////
    //  MARK: INITIALIZER METHODS
    
    init(filterKey: String ,
         filterValue: String ,
         @ViewBuilder content : @escaping (T) -> Content) {
        
        fetchRequest = FetchRequest<T>(entity: T.entity() ,
                                       sortDescriptors: [] ,
                                       // predicate: NSPredicate(format : "lastName BEGINSWITH %@" ,
                                       /**
                                        ⭐️
                                        We need to accept a second parameter
                                        to decide which key name we want to filter on ,
                                        because we might be using an entity that doesn’t have a `lastName` attribute .
                                        */
                                       predicate: NSPredicate(format : "%K BEGINSWITH %@" ,
                                                              /**
                                                              `NSPredicate` has a special symbol
                                                              that can be used to replace attribute names: `%K` ,
                                                              for “key” .
                                                              This will insert values we provide ,
                                                              but won’t add quote marks around them .
                                                              */
                                                              filterKey ,
                                                              filterValue))
        self.content = content
    }
}





 // ///////////////
//  MARK: PREVIEWS

//struct FilteredListView_Previews: PreviewProvider {
//
//    static var previews: some View {
//        FilteredListView(filter : "A")
//    }
//}
