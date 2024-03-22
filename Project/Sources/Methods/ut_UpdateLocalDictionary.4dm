//%attributes = {"invisible":true}
// ----------------------------------------------------
// ut_UpdateLocalDictionary
// User name (OS): charlesmiller
// Date and time: 12/30/10, 16:51:44
// ----------------------------------------------------
// Description
// This method will update local dictionary
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	Mods_2010_12  //r002 CJ Miller`12/30/10, 16:51:46      
	Mods_2011_06  // CJ Miller`06/20/11, 10:30:37      ` Type all local variables for v11
End if 

C_TEXT:C284($Path_txt)
$Path_txt:=Get 4D folder:C485(_o_Extras folder:K5:12)+"MHD_Dictionary.txt"

If (Test path name:C476($Path_txt)=Is a document:K24:1)
	C_BLOB:C604($Blob_blb)
	ARRAY TEXT:C222($WordArrays_atxt; 0)
	C_TEXT:C284($MyDictionaryPath_txt; $CR_txt; $word_txt; $Import_txt; $LF_Txt)
	C_LONGINT:C283($Position_l; $Loop_l)
	DOCUMENT TO BLOB:C525($Path_txt; $Blob_blb)
	BLOB TO VARIABLE:C533($Blob_blb; $WordArrays_atxt)
	C_TIME:C306($Doc)
	If (Application type:C494=4D Remote mode:K5:5)
		$MyDictionaryPath_txt:=Get 4D folder:C485(4D Client database folder:K5:13)
	Else 
		$MyDictionaryPath_txt:=Get 4D folder:C485(Database folder:K5:14)
	End if 
	
	
	C_BOOLEAN:C305($Complete_b)
	$Complete_b:=False:C215
	$Position_l:=Length:C16($MyDictionaryPath_txt)-1
	Repeat 
		Case of 
			: ($MyDictionaryPath_txt[[$Position_l]]="\\")
				$Complete_b:=True:C214
			: ($MyDictionaryPath_txt[[$Position_l]]=":")
				$Complete_b:=True:C214
			Else 
				$Position_l:=$Position_l-1
		End case 
	Until ($Complete_b)
	
	$MyDictionaryPath_txt:=Substring:C12($MyDictionaryPath_txt; 1; $Position_l)
	$CR_txt:=Char:C90(13)
	$LF_Txt:=Char:C90(10)
	If (Test path name:C476($MyDictionaryPath_txt+"perso69632.dic")=Is a document:K24:1)
		$Doc:=Open document:C264($MyDictionaryPath_txt+"perso69632.dic"; "dic")
		
		Repeat 
			RECEIVE PACKET:C104($Doc; $word_txt; $CR_txt)
			$word_txt:=Replace string:C233($word_txt; $CR_txt; "")
			$word_txt:=Replace string:C233($word_txt; $LF_Txt; "")
			
			If (OK=1)
				$Position_l:=Find in array:C230($WordArrays_atxt; $word_txt)
				If ($Position_l>0)
					If ($word_txt=$WordArrays_atxt{$Position_l})
						DELETE FROM ARRAY:C228($WordArrays_atxt; $Position_l; 1)
					End if 
				End if 
			End if 
		Until (OK=0)
		
	Else 
		$Doc:=Create document:C266($MyDictionaryPath_txt+"perso69632.dic"; "dic")
	End if 
	CLOSE DOCUMENT:C267($Doc)
	
	If (Size of array:C274($wordArrays_atxt)>0)
		
		$Doc:=Append document:C265($MyDictionaryPath_txt+"perso69632.dic"; "dic")
		$Import_txt:=""
		For ($Loop_l; 1; Size of array:C274($WordArrays_atxt))
			
			$Import_txt:=$Import_txt+$WordArrays_atxt{$Loop_l}+$CR_txt
			
			If (Length:C16($Import_txt)>25000)
				SEND PACKET:C103($doc; $Import_txt)
				$Import_txt:=""
			End if 
			
		End for 
		If (Length:C16($Import_txt)>0)
			SEND PACKET:C103($doc; $Import_txt)
			$Import_txt:=""
		End if 
		
		CLOSE DOCUMENT:C267($Doc)
	End if 
	
	
End if 
//End ut_UpdateLocalDictionary