//Method: Object Method: [LSS_Photos].Input.Photo_pct
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 06/12/15, 11:46:56
	// ----------------------------------------------------
	//Created : 
	Mods_2015_06
	// Modified by: Costas Manousakis-(Designer)-(9/17/15 12:35:38)
	Mods_2015_09_bug
	//  `Added code to handle dragging the picture and dropping it on itself
	// Modified by: Costas Manousakis-(Designer)-(2/17/16 17:44:50)
	Mods_2016_02_bug
	//  `removed "SAVE RECORD" after the PushChange (5;->[LSS_Photos]LSS_Photo_blb) Record is saved on the Save button
End if 
//

C_LONGINT:C283($0)
$0:=0

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
		//ut_Message ("After edit "+String(Current time)+"  tick "+String(Tickcount)+Char(13))
		//ut_Message ("After edit this picture drag "+Choose(LSS_ThisPictureDrag_b;"True";"False")+Char(13))
		If (Not:C34(LSS_ThisPictureDrag_b))
			//ut_Message ("After edit applying changes "+String(Current time)+"  tick "+String(Tickcount)+Char(13))
			PICTURE TO BLOB:C692(Photo_pct; $NewPicture_blb; "JPEG")
			C_BOOLEAN:C305($Update_b)
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
				[LSS_Photos:166]LSS_Photo_blb:5:=$NewPicture_blb
				PushChange(5; ->[LSS_Photos:166]LSS_Photo_blb:5)
				//SAVE RECORD([LSS_Photos])
			End if 
			//ut_Message ("After edit end changes "+String(Current time)+"  tick "+String(Tickcount)+Char(13))
			
		End if 
		LSS_ThisPictureDrag_b:=False:C215  //reset it
		
	: (Form event code:C388=On Clicked:K2:4)
		
End case 

//End Object Method: [LSS_Photos].Input.Photo_pct