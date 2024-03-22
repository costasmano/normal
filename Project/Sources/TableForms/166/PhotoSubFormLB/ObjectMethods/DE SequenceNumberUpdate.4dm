//Method: [LSS_Inspection];"Input_ITS".DE ApplySortBtn
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): CJ
	//User (4D) : Designer
	//Date and time: 01/23/20, 14:05:20
	// ----------------------------------------------------
	//Created : 
	Mods_2020_01_bug
	//Modfied way lss pictures are resequenced to follow model on tin images 
	//Modified by: CJ (1/23/20 16:35:21
	
End if 
//
//

If (False:C215)
	LSS_ResequenceInspPhotos
	
Else 
	NTI_ApplyImageSort
End if 

//OBJECT SET VISIBLE(*;"SequenceNumberUpdate";False)
LSS_GetImages
//End [LSS_Inspection].Input_ITS.DE ApplySortBtn