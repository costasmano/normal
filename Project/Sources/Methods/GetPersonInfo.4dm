//%attributes = {"invisible":true}
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 04/20/06, 15:13:11
	// ----------------------------------------------------
	// Method: GetPersonInfo
	// Description
	// Get the info for a person. Use passed pointers to variables to fill them.
	// 
	// Parameters
	// $1 : job code
	// $2 : ptr to text V : Full Name+suffix
	// $3 : ptr to text V : Initials
	// $4 : ptr to text V : FirstI. Last
	// $5 : division : string (optional - default = 0440)
	// ----------------------------------------------------
	Mods_2006_CM04
End if 
C_LONGINT:C283($0; $ErrorCode)
C_LONGINT:C283($1; $JobCode)
C_POINTER:C301($2; $3; $4; $FullName_ptr; $Initials_ptr; $FirstILast_ptr)
C_TEXT:C284($5; $Division_s)  // Command Replaced was o_C_STRING length was 5

C_TEXT:C284($FullName_txt; $FirstILast_txt; $Name_txt; $Suffix_txt; $Inits_txt)
$JobCode:=$1
$FullName_ptr:=$2
$Initials_ptr:=$3
$FirstILast_ptr:=$4
If (Count parameters:C259=5)
	$Division_s:=$5
Else 
	$Division_s:="0440"
End if 
$ErrorCode:=0

READ ONLY:C145([Personnel:42])
QUERY:C277([Personnel:42]; [Personnel:42]Division No:7=$Division_s; *)
QUERY:C277([Personnel:42];  & ; [Personnel:42]Job Code:8=$JobCode)

If (Records in selection:C76([Personnel:42])>0)
	FIRST RECORD:C50([Personnel:42])
	If ([Personnel:42]Middle Name:4="")
		$Name_txt:=[Personnel:42]First Name:3+" "+[Personnel:42]Last Name:5
		$Inits_txt:=Substring:C12([Personnel:42]First Name:3; 1; 1)+Substring:C12([Personnel:42]Last Name:5; 1; 1)
	Else 
		$Name_txt:=[Personnel:42]First Name:3+" "+[Personnel:42]Middle Name:4+" "+[Personnel:42]Last Name:5
		$Inits_txt:=Substring:C12([Personnel:42]First Name:3; 1; 1)+Substring:C12([Personnel:42]Middle Name:4; 1; 1)+Substring:C12([Personnel:42]Last Name:5; 1; 1)
	End if 
	$FirstILast_txt:=Substring:C12([Personnel:42]First Name:3; 1; 1)+". "+[Personnel:42]Last Name:5
	$Suffix_txt:=[Personnel:42]Suffix:6
	UNLOAD RECORD:C212([Personnel:42])
	$FullName_txt:=$Name_txt+$Suffix_txt
	
	$FullName_ptr->:=$FullName_txt
	$Initials_ptr->:=$Inits_txt
	$FirstILast_ptr->:=$FirstILast_txt
	$ErrorCode:=1
End if 

READ WRITE:C146([Personnel:42])
$0:=$ErrorCode