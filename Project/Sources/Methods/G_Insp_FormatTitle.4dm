//%attributes = {"invisible":true}
If (False:C215)
	//G_Insp_FormatTitle 
	//Created for uniform Inspection titles in [Inspection] print forms.
	//Assumes that Title object is named "Inspection Title" and
	// original text block size is width:218 points ; Font size:14
	
	// Modified by: costasmanousakis-(Designer)-(12/5/2005 11:36:40)
	Mods_2005_CM19
End if 

If ([Bridge MHD NBIS:1]Item8 Owner:208#"MBT")
	Case of 
		: (Length:C16(vInspTitlePr)>38)
			INSP_FormatTitle_new(30)
			//MOVE OBJECT(*;"Inspection Title";-56;2;112;-4)
			//FONT SIZE(*;"Inspection Title";11)
			
		: (Length:C16(vInspTitlePr)>28)
			INSP_FormatTitle_new(45)
			//MOVE OBJECT(*;"Inspection Title";-56;1;112;-2)
			//FONT SIZE(*;"Inspection Title";12)
			
			//: (Length(vInspTitlePr)>23)
		Else 
			INSP_FormatTitle_new(65)
			//MOVE OBJECT(*;"Inspection Title";-20;0;40;0)
	End case 
Else 
	C_LONGINT:C283($Margin_l)
	//$Margin_l:=65
	Case of 
		: (Length:C16(vInspTitlePr)>38)
			$Margin_l:=30
		: (Length:C16(vInspTitlePr)>28)
			$Margin_l:=45
		Else 
			//: (Length(vInspTitlePr)>23)
			$Margin_l:=65
	End case 
	INSP_FormatTitle_new($Margin_l)
End if 