//[Bridge MHD NBIS];"SI & A Print"
//Description for Item 44b

C_TEXT:C284(item44b)  // Command Replaced was o_C_STRING length was 2//This must not be a local variable!
C_TEXT:C284(vItem44b)  // Command Replaced was o_C_STRING length was 40

item44b:=Substring:C12([Bridge MHD NBIS:1]Item44:76; 2; 2)
vItem44b:=Get_Description(-><>aDesign; -><>aDesignCod; ->item44b)
