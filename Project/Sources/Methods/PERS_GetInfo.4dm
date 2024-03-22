//%attributes = {"invisible":true}
// ----------------------------------------------------
// Method: PERS_GetInfo
// Description :
//  ` Get info about a person return it in a variable passed as a pointer in pairs of "INFO" ; VarPtr.
//  ` Usage :
//  ` PERS_GetInfo( PID; "EMAIL";->$EmailVar_txt; "EMPLOYER"; ->$EmplVar_txt)
// 
// Parameters
// $1 : $PersID_L
// $2 : $Type1_txt ("EMAI:" | "EMPLOYER" | "FIRSTLAST" | "FULLNAME" 
// $3 : $Var1_ptr
// $4 : $Type2_txt
// $5 : $Var2_ptr
// etc...
// ----------------------------------------------------

If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 12/05/11, 09:53:37
	// First Release
	Mods_2011_12
	Mods_2012_01
	//Modified by: Kenny Yang-(Designer) `01/26/12, 17:11:59   `\ 
	//update VdiveMaster for the Flood damage form
	// Modified by: Costas Manousakis-(Designer)-(6/24/20 20:37:19)
	Mods_2020_06
	//  `initialize the variables passed in to blanks
End if 
C_LONGINT:C283($1; $PersID_L)
$PersID_L:=$1
C_BOOLEAN:C305($OK_b)
$OK_b:=True:C214
ARRAY TEXT:C222($Tasks_atxt; 0)
ARRAY POINTER:C280($VarPtrs_aptr; 0)
If (Count parameters:C259>=3)
	C_TEXT:C284($2)
	C_POINTER:C301($3)
	APPEND TO ARRAY:C911($Tasks_atxt; $2)
	APPEND TO ARRAY:C911($VarPtrs_aptr; $3)
End if 
If (Count parameters:C259>=5)
	C_TEXT:C284($4)
	C_POINTER:C301($5)
	APPEND TO ARRAY:C911($Tasks_atxt; $4)
	APPEND TO ARRAY:C911($VarPtrs_aptr; $5)
End if 
If (Count parameters:C259>=7)
	C_TEXT:C284($6)
	C_POINTER:C301($7)
	APPEND TO ARRAY:C911($Tasks_atxt; $6)
	APPEND TO ARRAY:C911($VarPtrs_aptr; $7)
End if 
If (Count parameters:C259>=9)
	C_TEXT:C284($8)
	C_POINTER:C301($9)
	APPEND TO ARRAY:C911($Tasks_atxt; $8)
	APPEND TO ARRAY:C911($VarPtrs_aptr; $9)
End if 
If (Count parameters:C259>=11)
	C_TEXT:C284($10)
	C_POINTER:C301($11)
	APPEND TO ARRAY:C911($Tasks_atxt; $10)
	APPEND TO ARRAY:C911($VarPtrs_aptr; $11)
End if 
If (Count parameters:C259>=13)
	C_TEXT:C284($12)
	C_POINTER:C301($13)
	APPEND TO ARRAY:C911($Tasks_atxt; $12)
	APPEND TO ARRAY:C911($VarPtrs_aptr; $13)
End if 
If (Count parameters:C259>=15)
	C_TEXT:C284($14)
	C_POINTER:C301($15)
	APPEND TO ARRAY:C911($Tasks_atxt; $14)
	APPEND TO ARRAY:C911($VarPtrs_aptr; $15)
End if 

C_LONGINT:C283($numPairs_L; $Loop_L)
$numPairs_L:=(Count parameters:C259-1)/2
//blank out the pointers
C_LONGINT:C283($loop_L)
For ($loop_L; 1; Size of array:C274($VarPtrs_aptr))
	$Var_ptr:=$VarPtrs_aptr{$loop_L}
	$Var_ptr->:=""
End for 

C_BOOLEAN:C305($PersRO_b)
$PersRO_b:=Read only state:C362([Personnel:42])
If (Not:C34($PersRO_b))
	READ ONLY:C145([Personnel:42])
End if 
QUERY:C277([Personnel:42]; [Personnel:42]Person ID:1=$PersID_L)
If (Records in selection:C76([Personnel:42])=1)
	C_TEXT:C284($Info_txt)
	C_POINTER:C301($Var_ptr)
	C_LONGINT:C283($TxtCount_L; $PtrCount_L)
	For ($Loop_L; 1; $numPairs_L)
		$TxtCount_L:=(2*$Loop_L-1)
		$PtrCount_L:=(1+(2*$Loop_L))
		$Info_txt:=$Tasks_atxt{$Loop_L}
		$Var_ptr:=$VarPtrs_aptr{$Loop_L}
		Case of 
			: ($Info_txt="EMAIL")
				$Var_ptr->:=[Personnel:42]EmailAddress_s:14
			: ($Info_txt="EMPLOYER")
				$Var_ptr->:=[Personnel:42]Employer:9
			: ($Info_txt="FIRSTLAST")
				$Var_ptr->:=[Personnel:42]First Name:3+" "+[Personnel:42]Last Name:5
			: ($Info_txt="FULLNAME")
				If ([Personnel:42]Middle Name:4#"")
					$Var_ptr->:=[Personnel:42]First Name:3+" "+[Personnel:42]Middle Name:4+" "+[Personnel:42]Last Name:5
				Else 
					$Var_ptr->:=[Personnel:42]First Name:3+" "+[Personnel:42]Last Name:5
				End if 
				If ([Personnel:42]Suffix:6#"")
					$Var_ptr->:=$Var_ptr->+[Personnel:42]Suffix:6
				End if 
			: ($Info_txt="PHONE")
				$Var_ptr->:=[Personnel:42]Phone_s:13
			: ($Info_txt="CELL")
				$Var_ptr->:=[Personnel:42]CellPhone_s:15
			: ($Info_txt="INITIAL")
				If ([Personnel:42]Middle Name:4#"")
					$Var_ptr->:=Substring:C12([Personnel:42]First Name:3; 1; 1)+Substring:C12([Personnel:42]Middle Name:4; 1; 1)+Substring:C12([Personnel:42]Last Name:5; 1; 1)
				Else 
					$Var_ptr->:=Substring:C12([Personnel:42]First Name:3; 1; 1)+Substring:C12([Personnel:42]Last Name:5; 1; 1)
				End if 
				
			: ($Info_txt="FILASTNAME")
				$Var_ptr->:=Substring:C12([Personnel:42]First Name:3; 1; 1)+". "+[Personnel:42]Last Name:5
			: ($Info_txt="LASTNAMEFI")
				$Var_ptr->:=[Personnel:42]Last Name:5+" "+Substring:C12([Personnel:42]First Name:3; 1; 1)+". "
		End case 
		
	End for 
	
End if 

If (Not:C34($PersRO_b))
	READ WRITE:C146([Personnel:42])
End if 