//%attributes = {"invisible":true}
// Method: GRP_GetGroupMembInfo
// Description
// ` Get the member infor for a group
// 
// Parameters
// $0 : $PersonID_L
// $1 : $GroupName_txt
// $2 : $Name_ptr
// $3 : $Initial_ptr
// $4 : $Suffix_ptr
// $5 : $Phone_ptr (optional)
// $6 : $Email_ptr (optional)
// $7 : $Acting_ptr (optional)
// $8 : $CellPhone_ptr (optional)
// $9 : $FILastName_ptr (optional)

// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 09/27/11, 08:32:13
	// ----------------------------------------------------
	Mods_2011_09
	// Modified by: Costas Manousakis-(Designer)-(4/18/12 )
	Mods_2012_04
	//  `Added parameter for cell phone
	// Modified by: Costas Manousakis-(Designer)-(1/11/17 17:27:51)
	Mods_2017_01
	//  `added param for 1stInitLastName
	// Modified by: Costas Manousakis-(Designer)-(5/7/18 16:34:59)
	Mods_2018_05
	//  `added use of new field [PERS_Groups]PERS_ActingTitle
End if 
C_LONGINT:C283($0; $PersonID_L)
$PersonID_L:=-9999
C_TEXT:C284($1; $GroupName_txt)
$GroupName_txt:=$1
C_POINTER:C301($2; $3; $4; $5; $6; $7; $8; $9)
C_POINTER:C301($Name_ptr; $Initial_ptr; $Suffix_ptr; $Phone_ptr; $Email_ptr; $Acting_ptr; $CellPhone_ptr; $FILastName_ptr)

C_BOOLEAN:C305($GrpRO_b; $GrpMemRO_b; $PersRO_b)
$GrpRO_b:=Read only state:C362([PERS_Groups:109])
$GrpMemRO_b:=Read only state:C362([PERS_GroupMembers:110])
$PersRO_b:=Read only state:C362([Personnel:42])
READ ONLY:C145([PERS_Groups:109])
READ ONLY:C145([Personnel:42])
READ ONLY:C145([PERS_GroupMembers:110])

$Name_ptr:=$2
$Initial_ptr:=$3
$Suffix_ptr:=$4
C_TEXT:C284($Email_txt; $Phone_txt; $Acting_txt; $CellPhone_txt; $FILastName_txt)
$Phone_ptr:=->$Phone_txt
$Email_ptr:=->$Email_txt
$Acting_ptr:=->$Acting_txt
$CellPhone_ptr:=->$CellPhone_txt
$FILastName_ptr:=->$FILastName_txt
If (Count parameters:C259>4)
	$Phone_ptr:=$5
End if 
If (Count parameters:C259>5)
	$Email_ptr:=$6
End if 
If (Count parameters:C259>6)
	$Acting_ptr:=$7
End if 
If (Count parameters:C259>7)
	$CellPhone_ptr:=$8
End if 
If (Count parameters:C259>8)
	$CellPhone_ptr:=$9
End if 

$Name_ptr->:=""
$Initial_ptr->:=""
$Suffix_ptr->:=""
$Phone_ptr->:=""
$Email_ptr->:=""
$Acting_ptr->:=""
$CellPhone_ptr->:=""
$FILastName_ptr->:=""

QUERY:C277([PERS_Groups:109]; [PERS_Groups:109]PERS_GroupName_s:2=$GroupName_txt)
Case of 
	: (Records in selection:C76([PERS_Groups:109])=1)
		FIRST RECORD:C50([PERS_Groups:109])
		LOAD RECORD:C52([PERS_Groups:109])
		Case of 
			: ([PERS_Groups:109]PERS_Primary:4>0)
				$PersonID_L:=[PERS_Groups:109]PERS_Primary:4
			: ([PERS_Groups:109]PERS_Acting:3>0)
				$PersonID_L:=[PERS_Groups:109]PERS_Acting:3
				If ([PERS_Groups:109]PERS_ActingTitle:6#"")
					$Acting_ptr->:=[PERS_Groups:109]PERS_ActingTitle:6+" "
				Else 
					$Acting_ptr->:="Acting "
				End if 
				
			Else 
				QUERY:C277([PERS_GroupMembers:110]; [PERS_GroupMembers:110]GroupID_I:1=[PERS_Groups:109]PERS_GroupID_I:1)
				FIRST RECORD:C50([PERS_GroupMembers:110])
				$PersonID_L:=[PERS_GroupMembers:110]PersonID_I:2
				
		End case 
		
		QUERY:C277([Personnel:42]; [Personnel:42]Person ID:1=$PersonID_L)
		FIRST RECORD:C50([Personnel:42])
		If ([Personnel:42]Middle Name:4="")
			$Name_ptr->:=[Personnel:42]First Name:3+" "+[Personnel:42]Last Name:5
			$Initial_ptr->:=Substring:C12([Personnel:42]First Name:3; 1; 1)+Substring:C12([Personnel:42]Last Name:5; 1; 1)
			$Suffix_ptr->:=[Personnel:42]Suffix:6
		Else 
			$Name_ptr->:=[Personnel:42]First Name:3+" "+Replace string:C233([Personnel:42]Middle Name:4; " "; "")+" "+[Personnel:42]Last Name:5
			$Initial_ptr->:=Substring:C12([Personnel:42]First Name:3; 1; 1)+Substring:C12([Personnel:42]Middle Name:4; 1; 1)+Substring:C12([Personnel:42]Last Name:5; 1; 1)
			$Suffix_ptr->:=[Personnel:42]Suffix:6
		End if 
		$Phone_ptr->:=[Personnel:42]Phone_s:13  //Get the DBIE phone from the personnel record as a check
		$Email_ptr->:=[Personnel:42]EmailAddress_s:14
		$CellPhone_ptr->:=[Personnel:42]CellPhone_s:15
		$FILastName_ptr->:=Substring:C12([Personnel:42]First Name:3; 1; 1)+". "+[Personnel:42]Last Name:5
		
	: (Records in selection:C76([PERS_Groups:109])=0)
		$PersonID_L:=0
	: (Records in selection:C76([PERS_Groups:109])>1)
		$PersonID_L:=-1
		
End case 

If (Not:C34($GrpRO_b))
	READ WRITE:C146([PERS_Groups:109])
End if 
If (Not:C34($GrpMemRO_b))
	READ WRITE:C146([PERS_GroupMembers:110])
End if 
If (Not:C34($PersRO_b))
	READ WRITE:C146([Personnel:42])
End if 

$0:=$PersonID_L