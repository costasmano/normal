
//----------------------------------------------------
//User name (OS): administrator
//Date and time: 05/13/16, 11:37:46
//----------------------------------------------------
//Method: Form Method: ConvertPicture
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	Mods_2016_05  // 
	//Modified by: administrator (5/13/16 11:37:48)
	
End if 
Case of 
	: (Form event code:C388=On Load:K2:1)
		OBJECT SET VISIBLE:C603(*; "Button1"; False:C215)
		CNV_All_L:=1
		CNV_StandardPhotos_L:=1
		
		If (<>CNV_TraceRecordNumber_L<0)
			OBJECT SET VISIBLE:C603(*; "Text3"; True:C214)
			OBJECT SET VISIBLE:C603(*; "Text2"; False:C215)
			
		Else 
			OBJECT SET VISIBLE:C603(*; "Text3"; False:C215)
			OBJECT SET VISIBLE:C603(*; "Text2"; True:C214)
			
			
			
			
		End if 
		
		
		
End case 
//End Form Method: ConvertPicture

