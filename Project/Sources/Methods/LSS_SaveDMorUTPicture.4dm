//%attributes = {"invisible":true}
// Method: LSS_SaveDMorUTPicture
// Description
// Object method for the UT and DMeter picture variables on Inspection forms
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	
	// ----------------------------------------------------
	// User name (OS): Administrator
	// Date and time: 06/16/15, 14:57:44
	// ----------------------------------------------------
	// Modified by: Costas Manousakis-(Designer)-(9/17/15 12:42:19)
	Mods_2015_09_bug
	//  `compare blobs only when blob sizes are equal - otherwise update is true
	//  `added form events to handle drag and drop
	Mods_2015_12_bug  //Fix bug where accessibility records, ut records, dmeter recdords not updated all the time
	// Modified by: administrator (12/30/15 16:10:34)
	// Modified by: CJMIller-(Designer)-(3/22/16 11:47:19)
	Mods_2016_03_bug
	//  `Added missing FLushGrpChanges before the SAVE Record
	
	C_LONGINT:C283(LSS_SaveDMorUTPicture; $0)
	C_POINTER:C301(LSS_SaveDMorUTPicture; $1)
	Mods_2017_06_bug  ////Fix error where errors occur and tranaction not cancelled
	//Modified by: Chuck Miller (6/21/17 13:44:29)
	Mods_2018_04  //Remove ability to delete a UT or D-Meter sketch once record is created
	//Modified by: Chuck Miller (4/17/18 14:59:08)
	// Modified by: Costas Manousakis-(Designer)-(4/18/18 14:41:57)
	Mods_2018_04
	//  `added missing on err call($ErrorMethodCalled_txt)
End if 

C_LONGINT:C283($0)
$0:=0

C_POINTER:C301($1; $Pict_ptr)

$Pict_ptr:=$1
C_BLOB:C604($NewPicture_blb)

C_POINTER:C301($src_ptr; $mypic_ptr; $null_ptr)
C_LONGINT:C283($srcline; $srcproc; $tbl_L; $fld_L)
C_TEXT:C284($varname_txt)
C_BOOLEAN:C305(LSS_ThisPictureDrag_b)


Case of 
	: (Form event code:C388=On Begin Drag Over:K2:44)
		//ut_Message ("Begin drag "+String(Current time)+"  tick "+String(Tickcount)+Char(13))
		LSS_ThisPictureDrag_b:=True:C214
		//ut_Message ("Begin drag pointername="+$varname_txt+" source line "+String($srcline)+" source proc "+String($srcproc)+Char(13))
		
	: (Form event code:C388=On Drag Over:K2:13)
		//ut_Message ("Drag Over "+String(Current time)+"  tick "+String(Tickcount)+Char(13))
		//_O_DRAG AND DROP PROPERTIES($src_ptr; $srcline; $srcproc)
		//RESOLVE POINTER($src_ptr; $varname_txt; $tbl_L; $fld_L)
		////ut_Message ("Drag Over pointername="+$varname_txt+" source line "+String($srcline)+" source proc "+String($srcproc)+Char(13))
		//$mypic_ptr:=->Photo_pct
		//Case of 
		//: ($src_ptr=$null_ptr)
		////ut_Message ("Drag Over NULL "+String(Current time)+"  tick "+String(Tickcount)+Char(13))
		//$0:=-1
		//: ($src_ptr=$mypic_ptr) & ($srcproc=Current process)
		////ut_Message ("Drag Over SAME "+String(Current time)+"  tick "+String(Tickcount)+Char(13))
		//$0:=-1
		//End case 
		
	: (Form event code:C388=On Drop:K2:12)
		//ut_Message ("Drop "+String(Current time)+"  tick "+String(Tickcount)+Char(13))
		
	: (Form event code:C388=On After Edit:K2:43)
		C_BOOLEAN:C305($Update_b)
		If (Not:C34(LSS_ThisPictureDrag_b))
			If (Picture size:C356($Pict_ptr->)=0)
				C_TEXT:C284($ErrorMethodCalled_txt)
				$ErrorMethodCalled_txt:=Method called on error:C704
				ON ERR CALL:C155("LSS_ErrorMethod")
				$Update_b:=True:C214
				LSS_UpdateMany_B:=True:C214
				SET BLOB SIZE:C606([LSS_Photos:166]LSS_Photo_blb:5; 0)
				PushChange(5; ->[LSS_Photos:166]LSS_Photo_blb:5)
				FlushGrpChgs(5; ->[LSS_Photos:166]LSS_PhotoId_s:1; ->[LSS_Photos:166]LSS_PhotoId_s:1; ->[LSS_Photos:166]LSS_PhotoId_s:1; 0)
				SAVE RECORD:C53([LSS_Photos:166])
				ON ERR CALL:C155($ErrorMethodCalled_txt)
				
			Else 
				PICTURE TO BLOB:C692($Pict_ptr->; $NewPicture_blb; "JPEG")
				
				If (Is new record:C668([LSS_Photos:166]))
					$Update_b:=True:C214
				Else 
					
					If (BLOB size:C605($NewPicture_blb)=BLOB size:C605([LSS_Photos:166]LSS_Photo_blb:5))
						SHORT_MESSAGE("Please Wait....")
						$Update_b:=LSS_CompareBlobs([LSS_Photos:166]LSS_Photo_blb:5; $NewPicture_blb)
						CLOSE WINDOW:C154
					Else 
						$Update_b:=True:C214
					End if 
				End if 
				
				If ($Update_b)
					C_TEXT:C284($ErrorMethodCalled_txt)
					$ErrorMethodCalled_txt:=Method called on error:C704
					ON ERR CALL:C155("LSS_ErrorMethod")
					LSS_UpdateMany_B:=True:C214
					[LSS_Photos:166]LSS_Photo_blb:5:=$NewPicture_blb
					PushChange(5; ->[LSS_Photos:166]LSS_Photo_blb:5)
					FlushGrpChgs(5; ->[LSS_Photos:166]LSS_PhotoId_s:1; ->[LSS_Photos:166]LSS_PhotoId_s:1; ->[LSS_Photos:166]LSS_PhotoId_s:1; 0)
					SAVE RECORD:C53([LSS_Photos:166])
					ON ERR CALL:C155($ErrorMethodCalled_txt)
				End if 
			End if 
			LSS_UpdateMany_B:=$Update_b
		End if 
		LSS_ThisPictureDrag_b:=False:C215
End case 
LSS_SetSaveandDelete
//End LSS_SaveDMorUTPicture