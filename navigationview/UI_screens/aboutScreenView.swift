//
//  aboutView.swift
//  navigationview
//
//  Created by Billy Cole on 6/28/24.
//

import SwiftUI



struct AboutView: View {
    
    @State public var Labout: String = "185"
    @FocusState var focus2: FormFieldFocus?
    @State var EMV185Data: String = ""
    @State var LdeviceAddress: String = ""
    
    
    
    enum FormFieldFocus: Hashable {
        case EdeviceName
        case EdeviceAddress
        case EsoftwareVersion
        case EfirmwareVersion
        
    }

    
    
    var body: some View {
        
        
        //Spacer()
        VStack{
            
            HStack(spacing: -210) {
                Text("Device Name")
                    .frame(width: 700,height: 30, alignment: .leading)
                    .font(.largeTitle)
                    .textFieldStyle(.roundedBorder)
                    .padding()
               
                TextField("EMV185", text: $EMV185Data)
                 
                    .font(.largeTitle)
                    .textFieldStyle(.roundedBorder)
                    .padding()
                    .onSubmit {
                        print(EMV185Data)
                        focus2 = .EdeviceName
                    }
                    .focused($focus2, equals: .EdeviceAddress)
                   // .padding(.bottom, -700)
                 }// end Hstack
  
        
        
        Divider()
            .frame(width: 700,alignment: .leading)
            .frame(height: 1)
            .overlay(.black)
            //.padding()
        
        
            HStack(spacing: -210) {
                Text("Device Address")
                    .frame(width: 700,height: 30, alignment: .leading)
                    .font(.largeTitle)
                    .textFieldStyle(.roundedBorder)
                    .padding()
               
                TextField("1234567", text: $EMV185Data)
                 
                    .font(.largeTitle)
                    .textFieldStyle(.roundedBorder)
                    //.padding()
                    .onSubmit {
                        print(EMV185Data)
                        focus2 = .EdeviceName
                    }
                    .focused($focus2, equals: .EdeviceAddress)
                   // .padding(.bottom, -700)
                 }// end Hstack

        }
        .padding()
        .frame(width: 750,height: 200,  alignment: .top)
        .background(Color.clear)
        .border(.black, width: 2)

 
    }
}








struct aboutScreenView: View {
    
    @State var bkcolU: Color = Color.white
    @State var bkcolUL: Color = Color.white
    @State var bkcolD: Color = Color.white
    @State var bkcolDL: Color = Color.white
    @State var startBtnFrame: Color = Color.green
    @State var startBtn: Color = Color.green
    @State var  isSelected: Bool = false
    @State var LmotorPeramInp = learnScreensetup()
    @State var Llearnmodetextfield = learnmodetextfield()
    @State var LInstructionsView = InstructionsView()
    @Environment(\.dismiss) private var dismiss
    let LmodelObj: Model = modelObj
    
    
    
    
    
    
    var body: some View {
        
        
        
        
        VStack(alignment: .center, spacing: 30){
              
            Text("Maxton")
                .font(.system(size: 30, weight: .bold, design: .default))
                .foregroundColor(.white)
                .frame(maxWidth: .infinity)
                .frame(height: 50)
                .background(Color.blue)
                .padding(.top, 450)   //<-----------
            
            
            
            Text("Setup Mode")
                .font(.title)
                .frame(maxWidth: .infinity)
                .background(Color.green)
                .padding(.top, -20)
            ////////////////////////////////////////////////////////////////////////////////////////////////

            HStack(spacing: 30){
                
                Text("U")
                    .font(.title)
                    .frame(width:40,height:40,alignment: .center)
                    .background(bkcolU)
                //Text("U").background(Color.red)
                
                Text("UL")
                    .font(.title)
                    .frame(width:40,height:40,alignment: .center)
                    .background(bkcolUL)
                
                //.foregroundColor(.black)
                Text("D")
                    .font(.title)
                    .frame(width:40,height:40,alignment: .center)
                    .background(bkcolD)
                
                
                Text("DL")
                    .font(.title)
                    .frame(width:40,height:40,alignment: .center)
                    .background(bkcolDL)
                
            } // end HStack(spacing: 30)
            .padding(.top, 10.0)
              
            Text("About")
                .font(.title)
                .padding(.top, -20.0)
            
        
            AboutView()
                    .padding(.top, 300)
            
           // Spacer()
                .padding(.top, -100.0)
            Button {
                dismiss()
            } label: {
                Text("go home")
                    .font(.largeTitle)
                
            }
            
            .frame(width: 400,height: 50)
            .padding(.top, 200.0)
            
            
            
          }// end outer VStack(alignment: .center, spacing: 30)
        .padding(.top, -520.0)
 
        
           // .padding(.top, -520.0)
    }
}








struct aboutView_Previews: PreviewProvider {
    static var previews: some View {
        aboutScreenView()
    }
}
