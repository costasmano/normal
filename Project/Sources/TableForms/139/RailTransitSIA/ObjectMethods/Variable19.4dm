//[Bridge MHD NBIS];"SI & A Print"
//Description for Item 43b

C_TEXT:C284(item43b)  // Command Replaced was o_C_STRING length was 2//This must not be a local variable!
C_TEXT:C284(vItem43b)  // Command Replaced was o_C_STRING length was 40

item43b:=Substring:C12([Bridge MHD NBIS:1]Item43:75; 2; 2)
vItem43b:=Get_Description(-><>aDesign; -><>aDesignCod; ->item43b)
