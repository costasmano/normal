If (False:C215)
	//Form Method: [Activity Log];"Output" 
	Mods_2005_CM04
	Mods_2005_CM06
	// Modified by: costasmanousakis-(Designer)-(4/18/2006 10:54:29)
	Mods_2006_CMy1
	// Modified by: Costas Manousakis-(Designer)-(10/31/16 15:28:10)
	Mods_2016_10
	//  `made Local and Parent ID fields wider
	// Modified by: Costas Manousakis-(Designer)-(11/18/16 16:53:44)
	Mods_2016_11
	//  `changed most buttons to 3D buttons using resources
	// Modified by: Costas Manousakis-(Designer)-(5/18/18 16:23:02)
	Mods_2018_05
	//  `increased object sizes
	Mods_2018_12  //Add code to transfer Resource files
	//Modified by: Chuck Miller (12/4/18 15:15:04)
End if 

Case of 
	: (Form event code:C388=On Display Detail:K2:22)
		C_TEXT:C284(vArchData)
		Case of 
			: ([Activity Log:59]Activity Type:3="TRS")
				C_LONGINT:C283($Offset_L; $Blobexpanded_L; $BlobCompr_L)
				$Offset_L:=0
				C_TEXT:C284($Path_txt)
				C_BLOB:C604($Blob_blb; $Data_blb)
				vArchData:=""
				C_LONGINT:C283($Count_L; $Size_L)
				
				$Data_blb:=[Activity Log:59]Data:10
				BLOB PROPERTIES:C536($Data_blb; $BlobCompr_L; $Blobexpanded_L)
				If ($Blobexpanded_L#Is not compressed:K22:11)
					EXPAND BLOB:C535($Data_blb)
				End if 
				$Count_L:=0
				$Size_L:=0
				Repeat 
					BLOB TO VARIABLE:C533($Data_blb; $Path_txt; $Offset_L)
					If (OK=1)
						$Count_L:=$Count_L+1
						BLOB TO VARIABLE:C533($Data_blb; $Blob_blb; $Offset_L)
						$Size_L:=$Size_L+BLOB size:C605($Blob_blb)
					End if 
				Until (OK=0)
				vArchData:=String:C10($Count_L)+" / "+String:C10($Size_L)
				
			: ([Activity Log:59]Activity Type:3="GRP")
				vArchData:=fGrpBlob2Text([Activity Log:59]Data:10)
			: ([Activity Log:59]Activity Type:3="GRD")
				vArchData:=fGRDBlob2Text([Activity Log:59]Data:10)
			: (Position:C15([Activity Log:59]Activity Type:3; ";NRC;FLD;DRC;")>0)
				vArchData:=fBLOB_2_Text([Activity Log:59]Data:10; [Activity Log:59]Data Type:11)
			: ([Activity Log:59]Activity Type:3="LNK")
				vArchData:=fLNKBlob2Text
			Else 
				vArchData:="?????"
		End case 
		
	: (Form event code:C388=On Outside Call:K2:11)
		If (<>fQuit)
			CANCEL:C270
		End if 
		
	: (Form event code:C388=On Activate:K2:9)
		UpdatFilesPalet
	: (Form event code:C388=On Deactivate:K2:10)
		UpdatFilesPalet
		
End case 