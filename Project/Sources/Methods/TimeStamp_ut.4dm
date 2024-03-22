//%attributes = {"invisible":true}
//Procedure: TimeStamp_ut(pFile;pDateCreated;pTimeCreated;pDateMod;pTimeMod)
//Purpose:  This procedure fills in date and time created and modified
//$pFile:=$1 - Pointer to file
//$pdCreated:=$2 - Pointer to Date Created
//$phCreated:=$3 -  Pointer to Time Created
//$pdMod:=$4 - Pointer to Date Modified
//$phMod:=$5-  Pointer to Time Modified

If (False:C215)
	//Procedure: TimeStamp_ut(pFile;pDateCreated;pTimeCreated;pDateMod;pTimeMod)
	//ACI University Programming Classes
	//Generic ACI Shell Programming
	//Created By: Jim Steinman
	//Date:  10/1/95
	
	<>fGeneric:=False:C215
	<>f_Ver1x10:=False:C215
	<>f_Ver1x20:=False:C215
	<>fJ_Steinman:=False:C215
	
	//Modified: 10/5/95 To use variable offset to call server less
	<>fK_Wilbur:=False:C215
	
	C_POINTER:C301(TimeStamp_ut; $1; $2; $3; $4; $5)
	
	// Modified by: costasmanousakis-(Designer)-(1/22/08 12:32:28)
	Mods_2007_CM_5401
	//Replace After and Before with On validate and On Load
	
End if 

C_POINTER:C301($1; $2; $3; $4; $5)
C_POINTER:C301($pFile; $pdCreated; $phCreated; $pdMod; $phMod)

$pFile:=$1

Case of 
	: (Form event code:C388=On Validate:K2:3)
		If (Not:C34(Is new record:C668($pFile->)))
			$pdMod:=$4
			$phMod:=$5
			//$pdMod»:=Current date(*)
			//$phMod»:=Current time(*)
			$pdMod->:=Current date:C33(*)  //+◊LDifference  `Add the difference between the server date
			$phMod->:=Current time:C178(*)  //+◊hDifference  `Add the difference between the server time
		End if 
		
	: (Form event code:C388=On Load:K2:1)
		If (Is new record:C668($pFile->))
			$pdCreated:=$2
			$phCreated:=$3
			//$pdCreated»:=Current date(*)
			//$phCreated»:=Current time(*)
			$pdCreated->:=Current date:C33(*)  //+◊LDifference  `Add the difference between the server date
			$phCreated->:=Current time:C178(*)  //+◊hDifference  `Add the difference between the server time
		End if 
		
End case 