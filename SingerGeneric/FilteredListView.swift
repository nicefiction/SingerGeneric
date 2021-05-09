// MARK: FilteredListView.swift

import SwiftUI
import CoreData



struct FilteredListView: View {
    
     // /////////////////
    //  MARK: PROPERTIES
    
    var fetchRequest: FetchRequest<Singer>
    
    
    
     // //////////////////////////
    //  MARK: COMPUTED PROPERTIES
    
    var singers: FetchedResults<Singer> {
        
        return fetchRequest.wrappedValue
    }
    
    
    var body: some View {
        
        List {
            ForEach(singers , id : \.self) { (singer: Singer) in
                Text("\(singer.wrappedFirstName) \(singer.wrappedLastName)")
            }
        }
    }
    
    
    
     // //////////////////////////
    //  MARK: INITIALIZER METHODS
    
    init(filter: String) {
        
        fetchRequest = FetchRequest(entity: Singer.entity() ,
                                    sortDescriptors: [] ,
                                    predicate: NSPredicate(format: "lastName BEGINSWITH %@" ,
                                                           filter))
    }
}





 // ///////////////
//  MARK: PREVIEWS

struct FilteredListView_Previews: PreviewProvider {
    
    static var previews: some View {
        FilteredListView(filter : "A")
    }
}
