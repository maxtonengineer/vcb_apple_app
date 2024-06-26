//
//  ListView.swift
//  navigationview
//
//  Created by Billy Cole on 6/21/24.
//
import SwiftUI


struct motorPerameters: Identifiable {
    
    let id = UUID()
    var name: String
    var value: String
}

struct motorPerameInputs: Identifiable {
    
    let id = UUID()
    var name: String
    var value: String
}
struct instuctions: Identifiable {
    
    let id = UUID()
    var name: String
    var value: String
}

struct stausVCB: Identifiable {
    
    let id = UUID()
    var name: String
    var value: String
}




var motorArr = [
motorPerameters(name: "Flow (GPM)", value: "(408) 555-4301"),
motorPerameters(name: "Piston Diameter", value: "(919) 775-5341"),
motorPerameters(name: "Contract Speed", value: "(919) 775-5341")
]


var motorPramInpArr = [
motorPerameters(name: "Flow Rate GPM", value: "(408) 555-4301"),
motorPerameters(name: "Piston Diameter", value: "(919) 775-5341"),
motorPerameters(name: "Contract Speed", value: "(919) 775-5341")
]




struct DecscriptionView: View {
    var body: some View {
       
        List{
            ForEach(motorArr) { handle in
                Text(handle.name)
                    //.font(.largeTitle)
                    //.frame(width: 400, height: 100)
                   
                
            }// end foreach
            
        } // end List
    }
}// end struct DecscriptionView: View

struct learnScreensetup: View {
   
    // MARK: - Private Propertives
    
    @State var flowRate: Int = 10
    @State var contractSpeed: Int = 50
    @State var  pistonDiameter: Int = 5
    
    
    
    @FocusState var focus: FormFieldFocus?
    
    var body: some View {
 

        VStack(spacing: -10) {
            
            
            
            
                Text("Flow                                            \(flowRate) (GPM)")
                    .frame(width: 700,height: 30, alignment: .leading)
                    .font(.largeTitle)
                    .textFieldStyle(.roundedBorder)
                    .padding()

            
            
            Divider()
                .frame(width: 700,alignment: .leading)
                .frame(height: 1)
                .overlay(.black)
                .padding()
            
            
            Text("Piston Diameter                           \(pistonDiameter) in")
                .frame(width: 700,height: 30, alignment: .leading)
                .font(.largeTitle)
                .textFieldStyle(.roundedBorder)
                .padding()

            
            Divider()
                .frame(width: 700,alignment: .leading)
                .frame(height: 1)
                .overlay(.black)
                .padding()

            Text("Contract Speed                        \(contractSpeed) ft/sec")
                .frame(width: 700,height: 30, alignment: .leading)
                .font(.largeTitle)
                .textFieldStyle(.roundedBorder)
                .padding()
        }
        
        
        .frame(width: 750,height: 230,  alignment: .top)
        .background(Color.clear)
        .border(.black, width: 5)
        
  /*      Rectangle()
            .fill(Color.red)
            .frame(width: 700,height: 500)
   */
           

    } // end var body: some View
    
    
    
    enum FormFieldFocus: Hashable {
        case firstname, lastname
        
    }
    
}// end struct DecscriptionView: View




struct DecscriptionView_Previews: PreviewProvider {
    static var previews: some View {
       // DecscriptionView()
        learnScreensetup()
    }
}


//.frame(width: 400, height: 100)

/*
 
 var body: some View {


     VStack(spacing: -10) {
         
         
         
         
         
         // MARK: - TextField -  1
         Text("Flow (GPM)")
          
             .font(.largeTitle)
             .textFieldStyle(.roundedBorder)
             .padding()
             .onSubmit {
                 print("hello")
                 focus = .lastname
             }
             .focused($focus, equals: .firstname)
            // .padding(.bottom, -700)
         
         
         Divider()
             .frame(width: 700,alignment: .leading)
             .frame(height: 1)
             .overlay(.black)
             .padding()
         
         // MARK: - TextField -  2
         TextField("Piston Diameter", text: $textInput2)
             .font(.largeTitle)
             .textFieldStyle(.roundedBorder)
             .padding()
             .onSubmit {
                 print(textInput2)
             }
             .focused($focus, equals: .lastname)
         Divider()
             .frame(width: 700,alignment: .leading)
             .frame(height: 1)
             .overlay(.black)
             .padding()

         
         
         
         // MARK: - TextField -  3
         
         TextField("Contract Speed", text: $pistonDiameter)
             .font(.largeTitle)
             .textFieldStyle(.roundedBorder)
             .padding()
             .onSubmit {
                 print(textInput2)
             }
             .focused($focus, equals: .lastname)
       
         
     }// end VStack
     .onAppear {
         focus = .firstname
     } // end body
     
     
     .frame(width: 750,height: 400,  alignment: .top)
     .background(Color.clear)
     .border(.black)
/*      Rectangle()
         .fill(Color.red)
         .frame(width: 700,height: 500)
*/
        

 }
 
 enum FormFieldFocus: Hashable {
     case firstname, lastname
     
 }
 
}// end struct DecscriptionView: View


 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 List{
    
    ForEach(motorPramInpArr) { handle in
   
        
        TextField("place hoder", text: $textInput)
            .textFieldStyle(.roundedBorder)
            .padding()
            .onSubmit {
                print("hello")
            }
            //.frame(width: 400, height: 100)
           
        
    }// end foreach
    
} // end List
*/
