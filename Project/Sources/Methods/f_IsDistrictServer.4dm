//%attributes = {"invisible":true}
If (False:C215)
	//f_IsDistrictServer
	//Created to determine whether we are working with a District Server 
	//Database
	// Modified by: costasmanousakis-(Designer)-(4/21/09 20:11:32)
	Mods_2009_04
	//Removed the .comp at the District X BMS.comp string.
End if 

C_TEXT:C284($0; $vsDistrNo)  // Command Replaced was o_C_STRING length was 10
$vsDistrNo:=""
C_TEXT:C284($StructFile_txt)
$StructFile_txt:=Structure file:C489
If (Current user:C182="District@ Server")
	$vsDistrNo:=Substring:C12(Current user:C182; 9; 1)
End if 
If (($StructFile_txt="District @ BMS@") & (Application type:C494=4D Remote mode:K5:5))
	$vsDistrNo:=Substring:C12($StructFile_txt; 10; 1)
End if 
If (Application type:C494=4D Volume desktop:K5:2)  //standalone app
	C_TEXT:C284($vsAppfolder)  // Command Replaced was o_C_STRING length was 255
	C_LONGINT:C283($i)
	$vsAppfolder:=GetPath(Application file:C491)
	ARRAY TEXT:C222($asFiles; 0)  //Command Replaced was o_ARRAY string length was 255
	DOCUMENT LIST:C474($vsAppfolder; $asFiles)
	$i:=Find in array:C230($asFiles; "District @ BMS@")
	If ($i>0)
		$vsDistrNo:=Substring:C12($asFiles{$i}; 10; 1)
	End if 
End if 

$0:=$vsDistrNo