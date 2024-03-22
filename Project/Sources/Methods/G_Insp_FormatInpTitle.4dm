//%attributes = {"invisible":true}
//G_Insp_FormatInpTitle
//Adjust the size of the inspection title in Input forms.

Case of 
	: (Length:C16(vInspTitle)>50)
		OBJECT SET FONT SIZE:C165(vInspTitle; 13)
	: (Length:C16(vInspTitle)>40)
		OBJECT SET FONT SIZE:C165(vInspTitle; 14)
	: (Length:C16(vInspTitle)>30)
		OBJECT SET FONT SIZE:C165(vInspTitle; 16)
	Else 
		OBJECT SET FONT SIZE:C165(vInspTitle; 18)
End case 