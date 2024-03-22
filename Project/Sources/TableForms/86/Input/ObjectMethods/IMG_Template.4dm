If (False:C215)
	//Object Method: IMG_Template 
	// Modified by: costasmanousakis-(Designer)-(5/24/11 11:37:40)
	Mods_2011_06
	
End if 
C_REAL:C285($w; $h)
Case of 
	: (Form event code:C388=On Load:K2:1)
		
	: (Form event code:C388=On Data Change:K2:15)
		
		
		VARIABLE TO BLOB:C532(IMG_Template; [Templates:86]Template_:3)
		PICTURE PROPERTIES:C457(IMG_Template; $w; $h)
		PushChange(1; ->[Templates:86]Template_:3)
		PicDims:=String:C10($w)+"x"+String:C10($h)
		Template_Size_L:=BLOB size:C605([Templates:86]Template_:3)
	: (Form event code:C388=On Clicked:K2:4)
		If ((Right click:C712) | (Macintosh control down:C544))
			C_TEXT:C284($PopMenuCmds_txt)
			
			$PopMenuCmds_txt:=".. "
			$PopMenuCmds_txt:=$PopMenuCmds_txt+<>sCR+"Copy"
			$PopMenuCmds_txt:=$PopMenuCmds_txt+<>sCR+"Paste"
			$PopMenuCmds_txt:=$PopMenuCmds_txt+<>sCR+"Load from File"
			$PopMenuCmds_txt:=$PopMenuCmds_txt+<>sCR+"Save to File"
			$PopMenuCmds_txt:=$PopMenuCmds_txt+<>sCR+"Make Editable"
			$PopMenuCmds_txt:=$PopMenuCmds_txt+<>sCR+"Make NonEditable"
			
			C_LONGINT:C283($Ret_L)
			$Ret_L:=Pop up menu:C542($PopMenuCmds_txt)
			Case of 
				: ($Ret_L=2)
					If (Picture size:C356(IMG_Template)>0)
						SET PICTURE TO PASTEBOARD:C521(IMG_Template)
					Else 
						ALERT:C41("There is no image to copy!")
					End if 
					
				: ($Ret_L=3)
					If (Pasteboard data size:C400("PICT")>0)
						GET PICTURE FROM PASTEBOARD:C522(IMG_Template)
						VARIABLE TO BLOB:C532(IMG_Template; [Templates:86]Template_:3)
						PICTURE PROPERTIES:C457(IMG_Template; $w; $h)
						PushChange(1; ->[Templates:86]Template_:3)
						PicDims:=String:C10($w)+"x"+String:C10($h)
						Template_Size_L:=BLOB size:C605([Templates:86]Template_:3)
					Else 
						ALERT:C41("There is no picture in the Clipboard!")
					End if 
					
				: ($Ret_L=6)
					OBJECT SET ENTERABLE:C238(IMG_Template; True:C214)
				: ($Ret_L=7)
					OBJECT SET ENTERABLE:C238(IMG_Template; False:C215)
				: ($Ret_L=4)
					C_TIME:C306($picfile_t)
					$picfile_t:=Open document:C264(""; ""; Get pathname:K24:6)
					If (OK=1)
						C_TEXT:C284($pictfile_txt)
						$pictfile_txt:=Document
						DOCUMENT TO BLOB:C525($pictfile_txt; [Templates:86]Template_:3)
						BLOB TO PICTURE:C682([Templates:86]Template_:3; IMG_Template)
						VARIABLE TO BLOB:C532(IMG_Template; [Templates:86]Template_:3)
						REDRAW:C174(IMG_Template)
						PICTURE PROPERTIES:C457(IMG_Template; $w; $h)
						PicDims:=String:C10($w)+"x"+String:C10($h)
						Template_Size_L:=BLOB size:C605([Templates:86]Template_:3)
						PushChange(1; ->[Templates:86]Template_:3)
						CLOSE DOCUMENT:C267($picfile_t)
					End if 
					
				: ($Ret_L=5)
					If (Picture size:C356(IMG_Template)>0)
						C_BLOB:C604($tempBlob__)
						
						PICTURE TO BLOB:C692(IMG_Template; $tempBlob__; "jpg2")
						C_TIME:C306($NewPicFile_t)
						C_TEXT:C284($NewPicFile_txt)
						$NewPicFile_t:=Create document:C266(""; "JPEG")
						If (OK=1)
							$NewPicFile_txt:=Document
							CLOSE DOCUMENT:C267($NewPicFile_t)
							BLOB TO DOCUMENT:C526($NewPicFile_txt; $tempBlob__)
							//_ O _SET DOCUMENT TYPE($NewPicFile_txt;"JPEG")
							//_ O _SET DOCUMENT CREATOR($NewPicFile_txt;"????")
						End if 
						SET BLOB SIZE:C606($tempBlob__; 0)
					Else 
						ALERT:C41("There is nothing to save to file!!")
					End if 
					
			End case 
			
		End if 
		
End case 