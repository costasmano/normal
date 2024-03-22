//%attributes = {"invisible":true}
If (False:C215)
	//GP M_EZSearch
	//Copyright © 1998, Thomas D. Nee, All Rights Reserved.
	
	//pFile, a pointer to the file to be searched,
	//must be set prior to this procedure.
	//(In MHD BMS, it is set in InitProcessVar).
	
	// Modified by: costasmanousakis-(Designer)-(4/2/08 12:37:12)
	Mods_2008_CM_5403  //Added sorting...
End if 
C_TEXT:C284($Argument)
C_LONGINT:C283($NumSch; $i)  //Command Replaced was o_C_INTEGER
C_POINTER:C301(pFile; pFileOld)  //pFile should already be set.
C_BOOLEAN:C305($SetFile)

//TRACE

If (Current process:C322=1)
	//"User/Runtime process"
	//In user mode.  Must detect which file, but how?  
	$SetFile:=True:C214
	If (Is nil pointer:C315(pFile))
		pFile:=Table:C252(1)
	End if 
	MainTitle:=""
End if 

//Declare the array to store the file names
ARRAY TEXT:C222(aFileNames; 0)  //Command Replaced was o_ARRAY string length was 32
//Declare the array to store pointers to the files
ARRAY POINTER:C280(apFiles; 0)
FilesToArray(->aFileNames; ->apFiles)

NewWindow(500; 405; 0; Plain window:K34:13; "Easy Search Editor"; "")
//If (Current user="Tom Nee")
//  TRACE
//End if 
DIALOG:C40([zDialogs:68]; "EasySearch")
CLOSE WINDOW:C154

If (OK=1)
	
	If ($SetFile)
		pFile:=Table:C252(Table:C252(apShowFlds{1}))
	End if 
	
	pFileOld:=pFile  //Remember the file to determine if it is necessary to clear the arrays.
	
	//ckWithin and ckAddTo should not both be 1 (controlled by button scripts).
	If (ckAddTo=1)
		CREATE SET:C116(pFile->; "Start Set")
	End if 
	//TRACE
	If (ckWithin=0)
		If (Current process:C322=1)
			ALL RECORDS:C47(pFile->)  //This is generic.
		Else 
			USE NAMED SELECTION:C332("UserRegionA")  //This is not generic; it is specific to the MHD BMS.
		End if 
		//  Else   `ckWithin=1, Just use the initial selection.
	End if 
	$NumSch:=Size of array:C274(asConjunct)
	Case of 
		: ($NumSch=1)
			Case of 
				: (asShowRel{1}="Starts With")
					$Argument:=asShowData{1}+"@"
				: ((asShowRel{1}="Contains") | (asShowRel{1}="Does Not Contain"))
					$Argument:="@"+asShowData{1}+"@"
				Else 
					$Argument:=asShowData{1}
			End case 
			QUERY SELECTION:C341(pFile->; apShowFlds{1}->; EZGetRelation(asShowRel{1}); $Argument)
			
		: ($NumSch>1)
			For ($i; 1; $NumSch)
				Case of 
					: (asShowRel{$i}="Starts With")
						$Argument:=asShowData{$i}+"@"
					: ((asShowRel{$i}="Contains") | (asShowRel{$i}="Does Not Contain"))
						$Argument:="@"+asShowData{$i}+"@"
					Else 
						$Argument:=asShowData{$i}
				End case 
				Case of 
					: ($i=1)  //First
						QUERY SELECTION:C341(pFile->; apShowFlds{$i}->; EZGetRelation(asShowRel{$i}); $Argument; *)
						
					: ($i<$NumSch)  //Middle
						Case of 
							: (asConjunct{$i}="And")
								QUERY SELECTION:C341(pFile->;  & ; apShowFlds{$i}->; EZGetRelation(asShowRel{$i}); $Argument; *)
							: (asConjunct{$i}="Or")
								QUERY SELECTION:C341(pFile->;  | ; apShowFlds{$i}->; EZGetRelation(asShowRel{$i}); $Argument; *)
							: (asConjunct{$i}="Except")
								QUERY SELECTION:C341(pFile->; #; apShowFlds{$i}->; EZGetRelation(asShowRel{$i}); $Argument; *)
						End case 
						
					Else   //Last
						Case of 
							: (asConjunct{$i}="And")
								QUERY SELECTION:C341(pFile->;  & ; apShowFlds{$i}->; EZGetRelation(asShowRel{$i}); $Argument)
							: (asConjunct{$i}="Or")
								QUERY SELECTION:C341(pFile->;  | ; apShowFlds{$i}->; EZGetRelation(asShowRel{$i}); $Argument)
							: (asConjunct{$i}="Except")
								QUERY SELECTION:C341(pFile->; #; apShowFlds{$i}->; EZGetRelation(asShowRel{$i}); $Argument)
						End case 
						
				End case 
			End for 
			
	End case 
	If (ckAddTo=1)
		CREATE SET:C116(pFile->; "Found Set")
		UNION:C120("Start Set"; "Found Set"; "Found Set")
		USE SET:C118("Found Set")
		CLEAR SET:C117("Found Set")
		CLEAR SET:C117("Start Set")
	End if 
	C_TEXT:C284(GEN_SORTLISTCMD_txt)
	If (GEN_SORTLISTCMD_txt#"")
		EXECUTE FORMULA:C63(GEN_SORTLISTCMD_txt)
	End if 
	
	RegionTitle
End if 