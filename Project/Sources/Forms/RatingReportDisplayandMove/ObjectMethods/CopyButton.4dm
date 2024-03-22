//Method: RatingReportDisplayandMove.Button
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Chuck Miller
	//User (4D) : Designer
	//Date and time: 11/14/17, 15:44:18
	// ----------------------------------------------------
	//Created : 
	Mods_2017_11  //Add code to allow for moving/copying rating reports to directory structure
	//Modified by: Chuck Miller (11/16/17 16:22:20)
	Mods_2020_05  //Modified Ratings display so mount and movement can be from windows as well as macs
	//Modified by: Chuck Miller (05/11/20 16:22:20)
End if 
//
C_TEXT:C284($NewFileName_txt)

$NewFileName_txt:=OBJECT Get title:C1068(*; "FileName")+".pdf"

If (Test path name:C476(RatingRPTBDEPTFolder_txt+$NewFileName_txt)=Is a document:K24:1)
	If (MR_CheckandResetDocumentLock(RatingRPTBDEPTFolder_txt+$NewFileName_txt; False:C215))
		CONFIRM:C162("Are you sure you wish to replace "+RatingRPTBDEPTFolder_txt+$NewFileName_txt)
	Else 
		OK:=0
	End if 
Else 
	CONFIRM:C162("Are you sure you wish to copy \r"+CopyFrom_txt+Char:C90(Carriage return:K15:38)+"to\r"+RatingRPTBDEPTFolder_txt+$NewFileName_txt)
End if 
If (OK=1)
	4DError_b:=False:C215
	ON ERR CALL:C155("4D_Errors")
	COPY DOCUMENT:C541(CopyFrom_txt; RatingRPTBDEPTFolder_txt+$NewFileName_txt; *)
	
	If (4DError_b)
		ALERT:C41("4D error occured First description line is "+SQL_InternalDescriptions_atxt{1}+" Notify MADOT BMS Support")
		4DError_b:=False:C215
	Else 
		If (MR_CheckandResetDocumentLock(RatingRPTBDEPTFolder_txt+$NewFileName_txt; True:C214))
		End if 
		ARRAY TEXT:C222($Parts_atxt; 0)
		
		ut_NewTextToArray(CopyFrom_txt; ->$Parts_atxt; Folder separator:K24:12)
		C_TEXT:C284($Copyto_txt)
		$Copyto_txt:=""
		C_LONGINT:C283($Loop_l)
		For ($Loop_l; 1; Size of array:C274($Parts_atxt)-1)
			$Copyto_txt:=$Copyto_txt+$Parts_atxt{$Loop_l}+Folder separator:K24:12
		End for 
		$Copyto_txt:=$Copyto_txt+$NewFileName_txt
	End if 
	APPEND TO ARRAY:C911(v_65_035_atxt; $NewFileName_txt)
	APPEND TO ARRAY:C911(v_65_035_atxt; CopyFrom_txt)
	APPEND TO ARRAY:C911(v_65_035_atxt; $Copyto_txt)
	
	CANCEL:C270
End if 
//End RatingReportDisplayandMove.Button