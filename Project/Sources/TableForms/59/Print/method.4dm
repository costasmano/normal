If (False:C215)
	// Form Method : [Activity Log];"Print"
	Mods_2005_CM04
	Mods_2005_CM06
	// Modified by: costasmanousakis-(Designer)-(11/5/2007 13:57:31)
	Mods_2007_CM12_5302  //combine new and old data in one display..
	// Modified by: costasmanousakis-(Designer)-(7/23/10 )
	Mods_2010_07
	//  `Replaced Parent ID and Local ID fields with text vars that combine them with the Destination ones.
	// Modified by: costasmanousakis-(Designer)-(9/15/10 15:15:51)
	Mods_2010_09
	//  `Changed form to add the destination Parent and Local IDs ; cleaned up so that it prints better
	//  `had to move the Data variable lower
	// Modified by: Costas Manousakis-(Designer)-(3/9/16 15:56:23)
	Mods_2016_03_bug
	//  `removed extra text in the ACTLOG_LocalKey_txt calculation 
	//  ` removed CRs from the key texts ; made font of ACTLOG_ParentKey_txt and ACTLOG_LocalKey_txt Arial6
	// Modified by: Costas Manousakis-(Designer)-(4/25/16 13:47:03)
	Mods_2016_04_bug
	//  `changed font of data to Arial6
	Mods_2018_12  //Add code to transfer Resource files
	//Modified by: Chuck Miller (12/4/18 16:03:33)
End if 
Case of 
	: (Form event code:C388=On Load:K2:1)
		C_TEXT:C284(vDateTime_S; vPageNo_s)
		C_TEXT:C284(vLogData; vOldLogData)
		C_TEXT:C284(ACTLOG_ParentKey_txt; ACTLOG_LocalKey_txt)  // Command Replaced was o_C_STRING length was 80
		vDateTime_S:=String:C10(Current date:C33(*))+" - "+String:C10(Current time:C178(*))
	: (Form event code:C388=On Printing Detail:K2:18)
		ACTLOG_ParentKey_txt:=""
		ACTLOG_LocalKey_txt:=""
		If ([Activity Log:59]Parent ID:14#"")
			ACTLOG_ParentKey_txt:=[Activity Log:59]Parent ID:14+"->"
			If ([Activity Log:59]Dest ID parent:16="")
				ACTLOG_ParentKey_txt:=ACTLOG_ParentKey_txt+"  ?"
			Else 
				ACTLOG_ParentKey_txt:=ACTLOG_ParentKey_txt+[Activity Log:59]Dest ID parent:16
			End if 
		End if 
		If ([Activity Log:59]Local ID:15#"")
			ACTLOG_LocalKey_txt:=[Activity Log:59]Local ID:15+"->"
			If ([Activity Log:59]Dest ID local:19="")
				ACTLOG_LocalKey_txt:=ACTLOG_LocalKey_txt+"  ?"
			Else 
				ACTLOG_LocalKey_txt:=ACTLOG_LocalKey_txt+[Activity Log:59]Dest ID local:19
			End if 
		End if 
		C_TEXT:C284(vOldLogData_S)  // Command Replaced was o_C_STRING length was 255
		Case of 
			: ([Activity Log:59]Activity Type:3="TRS")
				C_LONGINT:C283($Offset_L; $Blobexpanded_L; $BlobCompr_L)
				$Offset_L:=0
				C_TEXT:C284($Path_txt)
				C_BLOB:C604($Blob_blb; $Data_blb)
				vLogData:=""
				vOldLogData:="Not Applicable"
				$Data_blb:=[Activity Log:59]Data:10
				BLOB PROPERTIES:C536($Data_blb; $BlobCompr_L; $Blobexpanded_L)
				If ($Blobexpanded_L#Is not compressed:K22:11)
					EXPAND BLOB:C535($Data_blb)
				End if 
				Repeat 
					BLOB TO VARIABLE:C533($Data_blb; $Path_txt; $Offset_L)
					If (OK=1)
						BLOB TO VARIABLE:C533($Data_blb; $Blob_blb; $Offset_L)
						vLogData:=vLogData+$Path_txt+" size is "+String:C10(BLOB size:C605($Blob_blb))+Char:C90(Carriage return:K15:38)
					End if 
					
				Until (OK=0)
			: (Position:C15([Activity Log:59]Activity Type:3; ";NRC;FLD;DRC;LNK;")>0)
				vLogData:=fBLOB_2_Text([Activity Log:59]Data:10; [Activity Log:59]Data Type:11)
				vOldLogData:=fBLOB_2_Text([Activity Log:59]Old Data:27; [Activity Log:59]Data Type:11)
			: ([Activity Log:59]Activity Type:3="GRP")
				fGrpBlob2Text_2
			: ([Activity Log:59]Activity Type:3="GRD")
				fGRDBlob2Text_2
			Else 
				vLogData:="Don't Know about Activity type "+[Activity Log:59]Activity Type:3
				vOldLogData:="Don't Know about Activity type "+[Activity Log:59]Activity Type:3
		End case 
		If (Length:C16(vOldLogData)>254)
			vOldLogData_S:=Substring:C12(vOldLogData; 1; 250)+" ..."
		Else 
			vOldLogData_S:=vOldLogData
		End if 
		//  vOldLogData:=""
		vLogData:=vLogData+Char:C90(13)+"OLDDATA"+Char:C90(13)+vOldLogData
	: (Form event code:C388=On Validate:K2:3)
		
End case 