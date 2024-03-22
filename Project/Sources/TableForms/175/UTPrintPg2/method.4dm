
//----------------------------------------------------
//Method: Form Method: [LSS_UT];"UTPrintPg2" 
//Description
// copied from [LSS_UT]UTPrint 
// Parameters
// ----------------------------------------------------
If (False:C215)
	// Modified by: Costas Manousakis-(Designer)-(1/7/16 15:47:17)
	Mods_2016_01_bug
	//  `to Allow printing  of more than 11 rod results per UT inspection
	// Modified by: Costas Manousakis-(Designer)-(10/12/18 11:38:00)
	Mods_2018_10
	//  `changed headers of ut results and re-arranged columns to match page1 of ut
	
End if 
Case of 
	: (Form event code:C388=On Printing Detail:K2:18)
		vPageNo:=vPageNo+1
		USE SET:C118("UMeterPhotoSet")
		
		BLOB TO PICTURE:C682([LSS_Photos:166]LSS_Photo_blb:5; LSS_UTPicture_pct)
		LSS_UTPictureDesc_txt:=[LSS_Photos:166]LSS_Photo_txt:4
		C_POINTER:C301($Col1_ptr; $Col2_ptr; $Col3_ptr; $Col4_ptr; $Col5_ptr; $Col6_ptr)
		C_LONGINT:C283($Loop_l)
		For ($Loop_L; 1; 18)
			GOTO SELECTED RECORD:C245([LSS_UtResult:176]; $Loop_L)
			
			$Col1_ptr:=Get pointer:C304("LSS_PostBolt_L"+String:C10($Loop_L; "##"))
			$Col2_ptr:=Get pointer:C304("LSS_Indication_txt"+String:C10($Loop_L; "##"))
			$Col3_ptr:=Get pointer:C304("LSS_Location_txt"+String:C10($Loop_L; "##"))
			$Col4_ptr:=Get pointer:C304("LSS_Accept_b"+String:C10($Loop_L; "##"))
			$Col5_ptr:=Get pointer:C304("LSS_Reject_b"+String:C10($Loop_L; "##"))
			$Col6_ptr:=Get pointer:C304("LSS_Remarks_txt"+String:C10($Loop_L; "##"))
			
			Case of 
				: ($Loop_L<=Records in selection:C76([LSS_UtResult:176]))
					$Col1_ptr->:=[LSS_UtResult:176]LSS_RodNo_L:3
					$Col2_ptr->:=[LSS_UtResult:176]LSS_IndicationAndLocation_txt:4
					$Col3_ptr->:=[LSS_UtResult:176]LSS_Location_txt:5
					$Col4_ptr->:=[LSS_UtResult:176]LSS_Accept_b:6
					$Col5_ptr->:=[LSS_UtResult:176]LSS_Reject_b:7
					$Col6_ptr->:=[LSS_UtResult:176]LSS_Remarks_txt:8
					
				Else 
					OBJECT SET VISIBLE:C603($Col1_ptr->; False:C215)
					OBJECT SET VISIBLE:C603($Col2_ptr->; False:C215)
					OBJECT SET VISIBLE:C603($Col3_ptr->; False:C215)
					OBJECT SET VISIBLE:C603($Col4_ptr->; False:C215)
					OBJECT SET VISIBLE:C603($Col5_ptr->; False:C215)
					OBJECT SET VISIBLE:C603($Col6_ptr->; False:C215)
					
			End case 
			
			
		End for 
End case 
