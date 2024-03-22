//%attributes = {"invisible":true}
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 03/01/07, 10:13:07
	// ----------------------------------------------------
	// Method: CM_GetStrMntEngrs
	// Description
	// get the Struct maint engineers for a list of districts
	// 
	// Parameters
	// $0 : $StrMntEngrs_txt
	// $1 : $DistrList_txt (list of districts separated by ; and ending with a ;)
	// ----------------------------------------------------
	Mods_2007_CM07
End if 
C_TEXT:C284($0; $StrMntEngrs_txt)
C_TEXT:C284($1; $DistrList_txt)
$DistrList_txt:=$1
C_TEXT:C284($Distr_txt; $StrMntEngrName_txt)
$Distr_txt:=""
$StrMntEngrs_txt:=""
C_LONGINT:C283($delimiterpos_L; $DistrNo_L)
READ ONLY:C145([Personnel:42])
While ($DistrList_txt#"")
	$delimiterpos_L:=Position:C15(";"; $DistrList_txt)
	If ($delimiterpos_L>0)
		$Distr_txt:=Substring:C12($DistrList_txt; 1; ($delimiterpos_L-1))
		$DistrList_txt:=Substring:C12($DistrList_txt; ($delimiterpos_L+1))
	Else 
		$Distr_txt:=$DistrList_txt
	End if 
	$DistrNo_L:=Num:C11($Distr_txt)
	If ($DistrNo_L>0)
		$StrMntEngrName_txt:=""
		QUERY:C277([Personnel:42]; [Personnel:42]Division No:7=("044"+String:C10($DistrNo_L)))
		QUERY SELECTION:C341([Personnel:42]; [Personnel:42]Job Code:8=17)  //str.mnt engr
		If (Records in selection:C76([Personnel:42])>0)
			FIRST RECORD:C50([Personnel:42])
			
			If ([Personnel:42]Middle Name:4="")
				$StrMntEngrName_txt:=[Personnel:42]First Name:3+" "+[Personnel:42]Last Name:5
			Else 
				$StrMntEngrName_txt:=[Personnel:42]First Name:3+" "+[Personnel:42]Middle Name:4+" "+[Personnel:42]Last Name:5
			End if 
			$StrMntEngrName_txt:=$StrMntEngrName_txt+[Personnel:42]Suffix:6
		End if 
		If ($StrMntEngrs_txt#"")
			$StrMntEngrs_txt:=$StrMntEngrs_txt+<>sCR+Char:C90(Tab:K15:37)
		End if 
		$StrMntEngrs_txt:=$StrMntEngrName_txt+", District "+String:C10($DistrNo_L)+" Structures Maintenance Engineer"
	End if 
	
End while 
If ($StrMntEngrs_txt="")  //did not find anything
	$StrMntEngrs_txt:="District # Structures Maintenance Engineer"
End if 


READ WRITE:C146([Personnel:42])
$0:=$StrMntEngrs_txt