//%attributes = {"invisible":true}
//Method: NTI_OpenNBEInfo
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 04/22/16, 13:15:35
	// ----------------------------------------------------
	//Created : 
	Mods_2016_NTE
	// Modified by: Costas Manousakis-(Designer)-(11/1/17 10:20:31)
	Mods_2017_11_bug
	//  `Corrected resource subfolder to "TIN"
	// Modified by: Costas Manousakis-(Designer)-(5/25/20 10:13:58)
	Mods_2020_05
	//  `modified to use RES_OpenResourceFile
End if 
//
C_OBJECT:C1216($file_o)

C_OBJECT:C1216($file_o)
OB SET:C1220($file_o; "FileName"; "TIN/NTI Elements.pdf"; "Description"; "NTI Elements Info document")
RES_OpenResourceFile($file_o)

//End NTI_OpenNBEInfo