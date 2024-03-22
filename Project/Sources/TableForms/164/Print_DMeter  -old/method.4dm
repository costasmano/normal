
//----------------------------------------------------
//User name (OS): administrator
//Date and time: 03/10/15, 12:01:47
//----------------------------------------------------
//Method: Form Method: [LSS_Inspection];"Print_DMeter"
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	Mods_2014_Lighting  // 
	//Modified by: administrator (3/10/15 12:01:49)
	// Modified by: Costas Manousakis-(Designer)-(1/15/16 14:08:59)
	Mods_2016_01_bug
	//  `moved title ,pict, desc and notes up by 10, increased NOTES ht by 10 to accommodate some future changes
End if 
Case of 
	: (Form event code:C388=On Printing Detail:K2:18)
		vPageNo:=vPageNo+1
		USE SET:C118("DMeterPhotoSet")
		BLOB TO PICTURE:C682([LSS_Photos:166]LSS_Photo_blb:5; LSS_DMeterPicture_pct)
		LSS_PhotoDescription_txt:=[LSS_Photos:166]LSS_Photo_txt:4
		C_POINTER:C301($Col1_ptr; $Col2_ptr; $Col3_ptr; $Col4_ptr; $Col5_ptr; $Col6_ptr; $Col7_ptr)
		C_LONGINT:C283($Loop_l)
		For ($Loop_L; 1; 12)
			GOTO SELECTED RECORD:C245([LSS_DMeter:161]; $Loop_L)
			
			$Col1_ptr:=Get pointer:C304("LSS_Date_d"+String:C10($Loop_L; "##"))
			$Col2_ptr:=Get pointer:C304("LSS_Location_txt"+String:C10($Loop_L; "##"))
			$Col3_ptr:=Get pointer:C304("LSS_A_txt"+String:C10($Loop_L; "##"))
			$Col4_ptr:=Get pointer:C304("LSS_B_txt"+String:C10($Loop_L; "##"))
			$Col5_ptr:=Get pointer:C304("LSS_C_txt"+String:C10($Loop_L; "##"))
			$Col6_ptr:=Get pointer:C304("LSS_D_txt"+String:C10($Loop_L; "##"))
			$Col7_ptr:=Get pointer:C304("LSS_Reference_txt"+String:C10($Loop_L; "##"))
			
			Case of 
				: ($Loop_L<=Records in selection:C76([LSS_DMeter:161]))
					$Col1_ptr->:=[LSS_DMeter:161]LSS_DMeterDate_d:9
					$Col2_ptr->:=[LSS_DMeter:161]LSS_Location_s:3
					$Col3_ptr->:=[LSS_DMeter:161]LSS_A_s:4
					$Col4_ptr->:=[LSS_DMeter:161]LSS_B_s:5
					$Col5_ptr->:=[LSS_DMeter:161]LSS_C_s:6
					$Col6_ptr->:=[LSS_DMeter:161]LSS_D_s:7
					$Col7_ptr->:=[LSS_DMeter:161]LSS_Reference_s:8
				Else 
					OBJECT SET VISIBLE:C603($Col1_ptr->; False:C215)
					OBJECT SET VISIBLE:C603($Col2_ptr->; False:C215)
					OBJECT SET VISIBLE:C603($Col3_ptr->; False:C215)
					OBJECT SET VISIBLE:C603($Col4_ptr->; False:C215)
					OBJECT SET VISIBLE:C603($Col5_ptr->; False:C215)
					OBJECT SET VISIBLE:C603($Col6_ptr->; False:C215)
					OBJECT SET VISIBLE:C603($Col7_ptr->; False:C215)
					
			End case 
			
			
		End for 
End case 

//End Form Method: [LSS_Inspection]Print_DMeter

