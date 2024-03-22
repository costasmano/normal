//%attributes = {"invisible":true}
If (False:C215)
	// ----------------------------------------------------
	// PreviewCurrentPhoto
	// User name (OS): cjmiller
	// Date and time: 03/29/05, 16:14:14
	// ----------------------------------------------------
	// Description
	// 
	//
	// Parameters
	// ----------------------------------------------------
	
	//PreviewCurrentPhoto  
	//Print the curent photo associated with inspection
	
	Mods_2004_VN04
	Mods_2005_CJM02  //03/29/05, 16:14:07
	// Modified by: costasmanousakis-(Designer)-(8/22/2007 11:44:13)
	Mods_2007_CM12_5301
	// Parameters
	// $1 : $Option_txt (ONE | NEXT | PREVIOUS)
	// Modified by: costasmanousakis-(Designer)-(9/12/2007 11:33:41)
	Mods_2007_CM12_5301
	// Modified by: Costas Manousakis-(Designer)-(3/11/13 12:00:36)
	Mods_2013_03
	//  `Added missing  ":"  at the end of the Photo numbers
End if 
C_TEXT:C284($1; $Option_txt)
If (Count parameters:C259>0)
	$Option_txt:=$1
Else 
	$Option_txt:="ONE"
End if 

C_PICTURE:C286(vPicture1; vPicture2)
C_TEXT:C284(vTitle1; vTitle2)
C_TEXT:C284(vPhotoNum1; vPhotoNum2)  // Command Replaced was o_C_STRING length was 255
C_PICTURE:C286($MyEmptyPicture)

G_PrintOptions

If (Not:C34([Standard Photos:36]Portrait:4))
	//one photo per page layout
	vPicture1:=[Standard Photos:36]Std Photo:3
	vTitle1:=[Standard Photos:36]Description:2
	vPhotoNum1:="Photo "+String:C10([Standard Photos:36]SeqNum:6)+":"
	Print form:C5([Standard Photos:36]; "PrintPhotoSingle")
Else 
	Case of 
		: ($Option_txt="ONE")
			vPicture1:=[Standard Photos:36]Std Photo:3
			vTitle1:=[Standard Photos:36]Description:2
			vPhotoNum1:="Photo "+String:C10([Standard Photos:36]SeqNum:6)+":"
			vTitle2:=""
			vPhotoNum2:=""
		: ($Option_txt="NEXT")
			vPicture1:=[Standard Photos:36]Std Photo:3
			vTitle1:=[Standard Photos:36]Description:2
			vPhotoNum1:="Photo "+String:C10([Standard Photos:36]SeqNum:6)+":"
			//get next photo
			NEXT RECORD:C51([Standard Photos:36])
			//Make sure the next record is loaded
			If (Is record loaded:C669([Standard Photos:36]))
				vPicture2:=[Standard Photos:36]Std Photo:3
				vTitle2:=[Standard Photos:36]Description:2
				vPhotoNum2:="Photo "+String:C10([Standard Photos:36]SeqNum:6)+":"
				//get back to the current record
				PREVIOUS RECORD:C110([Standard Photos:36])
			End if 
		: ($Option_txt="PREVIOUS")
			vPicture2:=[Standard Photos:36]Std Photo:3
			vTitle2:=[Standard Photos:36]Description:2
			vPhotoNum2:="Photo "+String:C10([Standard Photos:36]SeqNum:6)+":"
			//get previous photo
			PREVIOUS RECORD:C110([Standard Photos:36])
			//Make sure the previous record is loaded
			If (Is record loaded:C669([Standard Photos:36]))
				vPicture1:=[Standard Photos:36]Std Photo:3
				vTitle1:=[Standard Photos:36]Description:2
				vPhotoNum1:="Photo "+String:C10([Standard Photos:36]SeqNum:6)+":"
				//Get back to the current record
				NEXT RECORD:C51([Standard Photos:36])
			End if 
			
	End case 
	
	Print form:C5([Standard Photos:36]; "PrintPhoto")
	
End if 

//Blank the picture variables
vPicture1:=$MyEmptyPicture*0
vPicture2:=$MyEmptyPicture*0