// MARK: FilteredListView.swift

import SwiftUI
import CoreData



// struct FilteredListView: View {
struct FilteredListView<T: NSManagedObject , Content: View>: View {
    
     // /////////////////
    //  MARK: PROPERTIES
    
    // var fetchRequest: FetchRequest<Singer>
    var fetchRequest: FetchRequest<T>
    /**
     This is our content closure ;
     we'll call this once for each item in the list :
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
