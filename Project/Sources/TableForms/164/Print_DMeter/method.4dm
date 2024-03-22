
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
	// Modified by: Costas Manousakis-(Designer)-(4/7/16 15:43:08)
	Mods_2016_04_bug
	//  `copy from Print_DMeter  to allow entry for Notes -added code to fit the Skech Notes
End if 
Case of 
	: (Form event code:C388=On Printing Detail:K2:18)
		
		FORM_FixHairLine
		C_LONGINT:C283(vPageNo)
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
		ut_FitPrintFormObjectbyName("LSS_DMeterSkecthNotes"; 8; 6; 0; 0)
		
End case 

//End Form Method: [LSS_Inspection]Print_DMeter