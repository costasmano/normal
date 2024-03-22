//%attributes = {"invisible":true}
//Method: dev_convertPicLibToJPEG
//Description
//convert picture library pictures to png for upgrade to v16 - set transparent background
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 09/18/15, 13:04:04
	// ----------------------------------------------------
	//Created : 
	Mods_2015_09
	// Modified by: Costas Manousakis-(Designer)-(4/20/16 11:53:46)
	Mods_2016_04_bug
	//  `added 6662, 10383, 10396
	
	// Modified by: Costas Manousakis (3/27/17)
	Mods_2017_03
	//  // do the whole library, use hmfree to check for picts
	// Modified by: Costas Manousakis-(Designer)-(8/4/20 09:33:11)
	Mods_2020_08
	//  `added Gif - seems v17 complains about those too.
	// Modified by: Costas Manousakis-(Designer)-(2021-09-27T00:00:00 14:05:50)
	Mods_2021_09
	//  `remove hmfree commands -use GET PICTURE FORMATS
End if 
//
If (User in group:C338(Current user:C182; "Design Access Group"))
	ARRAY LONGINT:C221($picRefs_aL; 0)
	ARRAY TEXT:C222($PicNames_atxt; 0)
	
	PICTURE LIBRARY LIST:C564($picRefs_aL; $PicNames_atxt)
	C_LONGINT:C283($loop_L)
	C_PICTURE:C286($pic_pic)
	//If (hmFree_IsLicensed >=0)
	//Else 
	//$loop_L:=hmFree_Register ("rLhAA-YcUAGWAAAAJCAMoBksABRAD+AGtAJbF-+")
	//End if 
	C_TEXT:C284($CurrFolder_txt; $msg_txt)
	$CurrFolder_txt:=""
	If (Application type:C494=4D Remote mode:K5:5)
		$CurrFolder_txt:=System folder:C487(Documents folder:K41:18)+Structure file:C489+"PictLibrary:"
	Else 
		$CurrFolder_txt:=GetPath(Structure file:C489)+"PictLibrary:"
	End if 
	
	If (Test path name:C476($CurrFolder_txt)=Is a folder:K24:2)
	Else 
		CREATE FOLDER:C475($CurrFolder_txt)
	End if 
	C_BLOB:C604($picBlob_x)
	
	CONFIRM:C162("Reload picture library from "+$CurrFolder_txt+" folder?"; "Reload"; "LeaveAsIs")
	
	If (OK=1)
		
		For ($loop_L; 1; Size of array:C274($picRefs_aL))
			If (Test path name:C476($CurrFolder_txt+String:C10($picRefs_aL{$loop_L}; "0000000000")+".4pct")=Is a document:K24:1)
				DOCUMENT TO BLOB:C525($CurrFolder_txt+String:C10($picRefs_aL{$loop_L}; "0000000000")+".4pct"; $picBlob_x)
				BLOB TO VARIABLE:C533($picBlob_x; $pic_pic)
				SET PICTURE TO LIBRARY:C566($pic_pic; $picRefs_aL{$loop_L}; $PicNames_atxt{$loop_L})
				
			End if 
		End for 
		
	End if 
	
	For ($loop_L; 1; Size of array:C274($picRefs_aL))
		ARRAY TEXT:C222($TypesFound_atxt; 0)
		GET PICTURE FROM LIBRARY:C565($picRefs_aL{$loop_L}; $pic_pic)
		//hmFree_GET PICTURE TYPES ($pic_pic;$TypesFound_atxt)
		GET PICTURE FORMATS:C1406($pic_pic; $TypesFound_atxt)
		If (Size of array:C274($TypesFound_atxt)>0)
			If (($TypesFound_atxt{1}="@pict@") | ($TypesFound_atxt{1}="@gif@"))
				//convert to png
				$msg_txt:=$msg_txt+"Change pic "+String:C10($picRefs_aL{$loop_L})+"/"+$PicNames_atxt{$loop_L}+" from size "+String:C10(Picture size:C356($pic_pic))
				VARIABLE TO BLOB:C532($pic_pic; $picBlob_x)
				BLOB TO DOCUMENT:C526($CurrFolder_txt+String:C10($picRefs_aL{$loop_L}; "0000000000")+".4pct"; $picBlob_x)
				CONVERT PICTURE:C1002($pic_pic; "image/png")
				TRANSFORM PICTURE:C988($pic_pic; Transparency:K61:11; 0x00FFFFFF)
				
				$msg_txt:=$msg_txt+"  to new png size "+String:C10(Picture size:C356($pic_pic))+Char:C90(Carriage return:K15:38)
				SET PICTURE TO LIBRARY:C566($pic_pic; $picRefs_aL{$loop_L}; $PicNames_atxt{$loop_L})
				
			Else 
				$msg_txt:=$msg_txt+"pic "+String:C10($picRefs_aL{$loop_L})+"/"+$PicNames_atxt{$loop_L}+" is type "+$TypesFound_atxt{1}+Char:C90(Carriage return:K15:38)
				
			End if 
			
		End if 
	End for 
	ut_BigAlert($msg_txt; "Messages")
	
	
	If (False:C215)
		ARRAY LONGINT:C221($picrefs_aL; 0)
		ARRAY TEXT:C222($picNames_atxt; 0)
		PICTURE LIBRARY LIST:C564($picrefs_aL; $picNames_atxt)
		
		C_PICTURE:C286($libpict)
		
		ARRAY LONGINT:C221($pictomod_aL; 0)
		APPEND TO ARRAY:C911($pictomod_aL; 6657)
		APPEND TO ARRAY:C911($pictomod_aL; 6671)
		APPEND TO ARRAY:C911($pictomod_aL; 6669)
		APPEND TO ARRAY:C911($pictomod_aL; 6660)
		APPEND TO ARRAY:C911($pictomod_aL; 10065)
		APPEND TO ARRAY:C911($pictomod_aL; 6662)
		APPEND TO ARRAY:C911($pictomod_aL; 10383)
		APPEND TO ARRAY:C911($pictomod_aL; 10396)
		
		C_LONGINT:C283($loop_L; $indx_L)
		C_TEXT:C284($msg_txt)
		For ($loop_L; 1; Size of array:C274($pictomod_aL))
			$indx_L:=Find in array:C230($picrefs_aL; $pictomod_aL{$loop_L})
			GET PICTURE FROM LIBRARY:C565($pictomod_aL{$loop_L}; $libpict)
			$msg_txt:="Change pic "+String:C10($pictomod_aL{$loop_L})+"/"+$picNames_atxt{$indx_L}+" from size "+String:C10(Picture size:C356($libpict))
			CONVERT PICTURE:C1002($libpict; "image/jpeg")
			$msg_txt:=$msg_txt+"  to new jpeg size "+String:C10(Picture size:C356($libpict))
			SET PICTURE TO LIBRARY:C566($libpict; $pictomod_aL{$loop_L}; $picNames_atxt{$indx_L})
			ALERT:C41($msg_txt)
		End for 
		
	End if 
	
End if 

//End dev_convertPicLibToJPEG