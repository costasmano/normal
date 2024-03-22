If (False:C215)
	//Form Method: [Activity Log];"Input"
	Mods_2005_CM04
	Mods_2005_CM06
	// Modified by: costasmanousakis-(Designer)-(4/18/2006 10:53:34)
	Mods_2006_CMy1
	// Modified by: costasmanousakis-(Designer)-(4/21/2006 09:25:55)
	Mods_2006_CM04
	// Modified by: costasmanousakis-(Designer)-(8/9/2007 16:22:36)
	Mods_2007_CM12_5301
	// Modified by: Costas Manousakis-(Designer)-(10/28/13 09:27:53)
	Mods_2013_10
	//  `Changed fonts to all objects to Label10Plain
	// Modified by: Costas Manousakis-(Designer)-(4/8/15 12:58:53)
	Mods_2015_04
	//  `increased size of ID fields on page 2 to properly fit 20 chars
	// Modified by: Costas Manousakis-(Designer)-(5/18/18 16:39:41)
	Mods_2018_05
	//  `made variables on form not editable; property adjustments to owners incl subform 
	Mods_2018_12  //Add code to transfer Resource files
	//Modified by: Chuck Miller (12/4/18 15:16:34)
	Mods_2018_12  //Add ability to view pictures/text/and 4d write areas form activity log input form
	//Modified by: Chuck Miller (12/11/18 13:53:23)
	// Modified by: Costas Manousakis-(Designer)-(2/26/21 12:14:37)
	Mods_2021_02
	//  `get vLogData last, otherwise the vars v_59_010_blb;v_59_027_blb are cleared from the call to get vOldLogData
	//  `enabled On unload event on form, and added code to clear the v_59_010_blb;v_59_027_blb blob vars
End if 

Case of 
	: (Form event code:C388=On Load:K2:1)
		C_TEXT:C284(vTableName; vTableNameLoc; vTableNameParent; vfNameLoc; vfNameParent)  // Command Replaced was o_C_STRING length was 80
		vTableName:=""
		vTableNameLoc:=""
		vTableNameParent:=""
		vfNameLoc:=""
		vfNameParent:=""
		C_POINTER:C301($pField)
		If ([Activity Log:59]File Number:7>0)
			vTableName:=Table name:C256([Activity Log:59]File Number:7)
		End if 
		If ([Activity Log:59]FileID Local:24>0)
			vTableNameLoc:=Table name:C256([Activity Log:59]FileID Local:24)
			$pField:=Field:C253([Activity Log:59]FileID Local:24; [Activity Log:59]FieldID Local:25)
			vfNameLoc:=myFieldName($pField)
		End if 
		If ([Activity Log:59]FileID Parent:22>0)
			vTableNameParent:=Table name:C256([Activity Log:59]FileID Parent:22)
			$pField:=Field:C253([Activity Log:59]FileID Local:24; [Activity Log:59]FieldID Parent:23)
			vfNameParent:=myFieldName($pField)
		End if 
		C_TEXT:C284(vFtypeData; vFtypeLocal; vFtypeParent; vSizeData; vOldSizeData)  // Command Replaced was o_C_STRING length was 80
		vFtypeData:=fGetDataType([Activity Log:59]Data Type:11)
		vFtypeLocal:=fGetDataType([Activity Log:59]Local Type:18)
		vFtypeParent:=fGetDataType([Activity Log:59]Type Parent:17)
		
		C_LONGINT:C283($vlBlobCompr; $vlBlobexpanded)
		vSizeData:=String:C10(BLOB size:C605([Activity Log:59]Data:10); "(##,###,##0 b)")
		BLOB PROPERTIES:C536([Activity Log:59]Data:10; $vlBlobCompr; $vlBlobexpanded)
		If ($vlBlobCompr#Is not compressed:K22:11)
			vSizeData:=vSizeData+"/"+String:C10($vlBlobexpanded; "(##,###,##0 b)")
		End if 
		
		vOldSizeData:=String:C10(BLOB size:C605([Activity Log:59]Old Data:27); "(##,###,##0 b)")
		BLOB PROPERTIES:C536([Activity Log:59]Old Data:27; $vlBlobCompr; $vlBlobexpanded)
		If ($vlBlobCompr#Is not compressed:K22:11)
			vOldSizeData:=vOldSizeData+"/"+String:C10($vlBlobexpanded; "(##,###,##0 b)")
		End if 
		
		C_BLOB:C604(v_59_010_blb; v_59_027_blb)
		C_TEXT:C284(vLogData; vOldLogData)
		Case of 
			: ([Activity Log:59]Activity Type:3="TRS")
				C_LONGINT:C283($Offset_L)
				$Offset_L:=0
				C_TEXT:C284($Path_txt)
				C_BLOB:C604($Blob_blb; $Data_blb)
				vLogData:=""
				vOldLogData:="Not Applicable"
				$Data_blb:=[Activity Log:59]Data:10
				BLOB PROPERTIES:C536($Data_blb; $vlBlobCompr; $vlBlobexpanded)
				If ($vlBlobCompr#Is not compressed:K22:11)
					EXPAND BLOB:C535($Data_blb)
				End if 
				Repeat 
					BLOB TO VARIABLE:C533($Data_blb; $Path_txt; $Offset_L)
					If (OK=1)
						BLOB TO VARIABLE:C533($Data_blb; $Blob_blb; $Offset_L)
						vLogData:=vLogData+$Path_txt+" size is "+String:C10(BLOB size:C605($Blob_blb))+Char:C90(Carriage return:K15:38)
					End if 
					
				Until (OK=0)
				
			: ([Activity Log:59]Activity Type:3="GRP")
				fGrpBlob2Text_2
			: (Position:C15([Activity Log:59]Activity Type:3; ";NRC;FLD;DRC;")>0)
				vOldLogData:=fBLOB_2_Text([Activity Log:59]Old Data:27; [Activity Log:59]Data Type:11)
				vLogData:=fBLOB_2_Text([Activity Log:59]Data:10; [Activity Log:59]Data Type:11)
			: ([Activity Log:59]Activity Type:3="GRD")
				fGRDBlob2Text_2
			: ([Activity Log:59]Activity Type:3="LNK")
				fLNKBlob2Text_2
				//    [Activity Log]Data)
				//   vOldLogData:=fGrpBlob2Text ([Activity Log]Old Data)
			Else 
				vLogData:="Don't Know about Activity type "+[Activity Log:59]Activity Type:3
				vOldLogData:="Don't Know about Activity type "+[Activity Log:59]Activity Type:3
		End case 
		
		OBJECT SET VISIBLE:C603(*; "View_Data"; (([Activity Log:59]Activity Type:3="FLD") | ([Activity Log:59]Activity Type:3="GRP")) & (BLOB size:C605(v_59_010_blb)>0))
		
	: (Form event code:C388=On Unload:K2:2)
		//clear the blobs
		SET BLOB SIZE:C606(v_59_010_blb; 0)
		SET BLOB SIZE:C606(v_59_027_blb; 0)
		
End case 