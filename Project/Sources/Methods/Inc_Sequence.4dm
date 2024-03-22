//%attributes = {"invisible":true}
//GP: Inc_Sequence
//Copyright © 1995-1996,  Albert S. Leung, All Rights Reserved.
//Use this procedure if a new record is generated procedurally and will be saved
//Do not use this if sequences must be contiguous. Gaps will occur when a person 
//cancels out of making a new record.

//Accesses the [Sequences] file to set the next ID number.
//$1 - $SeqName:  name in sequence record.
//$2 - $ptr_id:  pointer to id field.
//Modified 12 March 2004 by CJ Miller as follows:
If (False:C215)
	Mods_2004_CJM01
	// Modified by: costasmanousakis-(Designer)-(3/9/09 16:28:47)
	Mods_2009_03
	//  `Changed Semaphore to be a local one $GetCounter instead of GetCounter
	//  `Also removed the DELAY Process and use a Wait for the ◊ut_NextCounterNumber_l 
	//  `to become not zero- which is set by method ut_AssignNextNumber when it is done
	//Ugrade to v11
	//Modified by: Charles Miller (4/29/11 15:00:50)
	// Modified by: Costas Manousakis-(Designer)-(4/8/14 11:41:27)
	Mods_2014_04_bug
	//  `added code to create a record in [ONSQLAuthenticationErrors] if sequence name is blank
	// Modified by: CJ Miller-(Designer)-(10/21/14 15:31:25)
	Mods_2014_10_bug
	//  `Changed stack size of call to ut_AssignNextNumber   to 256 from 64. maybe  avoid memory allocation errors during runtime
	// Modified by: Charles Miller-(Designer)-(10/20/16 )
	Mods_2016_10
	//  `Increased Delay process to 60 when not in transaction; Added IDLE ; and a message when the sequence is locked
	//  `Increased Delay process to 15 when in transaction; Added IDLE before and after delay process
	// Modified by: Costas Manousakis-(Designer)-(2023-04-07 14:29:29)
	Mods_2023_04
	//  `use tickcount parament in Semaphore-Use IDLE as shown in https://doc.4d.com/4Dv18/4D/18.4/Semaphore.301-5233674.en.html
	//  // Removed IDLE from other places
End if 

C_TEXT:C284($SeqName)  // Command Replaced was o_C_STRING length was 40
C_POINTER:C301($ptr_id)

$SeqName:=$1
$ptr_id:=$2

If ($SeqName="")
	//Log this in the [ONSQLAuthenticationErrors] for now for debugging reasons
	C_TEXT:C284($ProcNanme_txt; $varname_txt; $Tbl_txt; $field_txt; $reason_txt)
	C_LONGINT:C283($procnum_L; $procState_L; $procTime_L; $procuniq_L; $procorigin_L; $tbl_L; $fld_L)
	C_BOOLEAN:C305($procVis_b)
	RESOLVE POINTER:C394($ptr_id; $varname_txt; $tbl_L; $fld_L)
	$procnum_L:=Current process:C322
	PROCESS PROPERTIES:C336($procnum_L; $ProcNanme_txt; $procState_L; $procTime_L; $procVis_b; $procuniq_L; $procorigin_L)
	
	$reason_txt:="<User : "+Current user:C182+">  <Process info  num : "+String:C10($procnum_L)+", name : "+$ProcNanme_txt
	$reason_txt:=$reason_txt+", state : "+String:C10($procState_L)+", ticks : "+String:C10($procTime_L)+", vis : "+f_Boolean2String($procVis_b; "YN")
	$reason_txt:=$reason_txt+", uniqueID : "+String:C10($procuniq_L)+", origin : "+String:C10($procorigin_L)+" > "
	$reason_txt:=$reason_txt+"  <current machine  : "+Current machine:C483+", machine owner : "+Current system user:C484+">"
	$reason_txt:=$reason_txt+"  <In transaction : "+f_Boolean2String(In transaction:C397; "YN")
	$reason_txt:=$reason_txt+">   <Pointer   varname : ["+$varname_txt+"],  tablenum : "+String:C10($tbl_L)
	$reason_txt:=$reason_txt+", fieldnum : "+String:C10($fld_L)
	
	If (Is field number valid:C1000($tbl_L; $fld_L))
		$reason_txt:=$reason_txt+", field name ["+Table name:C256($tbl_L)+"]"+Field name:C257($tbl_L; $fld_L)
	End if 
	$reason_txt:=$reason_txt+">"
	
	CREATE RECORD:C68([ONSQLAuthenticationErrors:146])
	[ONSQLAuthenticationErrors:146]UserName_s:1:="BlankSequence"
	[ONSQLAuthenticationErrors:146]LastLogin_d:4:=Current date:C33(*)
	[ONSQLAuthenticationErrors:146]LastLogin_tm:5:=Current time:C178(*)
	[ONSQLAuthenticationErrors:146]Reason_txt:3:=$reason_txt
	
	SAVE RECORD:C53([ONSQLAuthenticationErrors:146])
	UNLOAD RECORD:C212([ONSQLAuthenticationErrors:146])
	
End if 
If (In transaction:C397)  //Begin changes  ```Mods_2004_CJM01
	C_LONGINT:C283($ArrayPosition_l)
	Repeat 
		While (Semaphore:C143("$GetArrayPosition"; 15))
			IDLE:C311
		End while 
		$ArrayPosition_l:=-1
		Repeat 
			$ArrayPosition_l:=Find in array:C230(<>NextNumberArray_al; -9)
			If ($ArrayPosition_l>0)
				<>NextNumberArray_al{$ArrayPosition_l}:=-1
			Else 
				DELAY PROCESS:C323(Current process:C322; 15)
			End if 
		Until ($ArrayPosition_l>0)
	Until ($ArrayPosition_l>0)
	CLEAR SEMAPHORE:C144("$GetArrayPosition")
	
	C_LONGINT:C283($INCSequenceNextNumber_l)
	
	C_TEXT:C284($SemaphoreName_txt)
	$SemaphoreName_txt:="$"+$SeqName
	While (Semaphore:C143($SemaphoreName_txt; 15))
		IDLE:C311
		//DELAY PROCESS(Current process;15)
		//IDLE
	End while 
	
	$INCSequenceNextNumber_l:=0  //make sure always starts at 0
	C_LONGINT:C283($ID)
	
	$ID:=New process:C317("ut_AssignNextNumber"; 0; $SeqName; $SeqName; $ArrayPosition_l)
	
	Repeat 
		//IDLE
		DELAY PROCESS:C323(Current process:C322; 15)
		//IDLE
	Until (<>NextNumberArray_al{$ArrayPosition_l}>0)
	$INCSequenceNextNumber_l:=<>NextNumberArray_al{$ArrayPosition_l}
	$ptr_id->:=$INCSequenceNextNumber_l
	$INCSequenceNextNumber_l:=-1
	<>NextNumberArray_al{$ArrayPosition_l}:=-9
	//Until ($Currentname_txt#$SemaphoreName_txt) | ($State_l<0)
	CLEAR SEMAPHORE:C144($SemaphoreName_txt)
	
	
	//end changes ``Mods_2004_CJM01
Else 
	//not in transaction
	READ WRITE:C146([Sequences:28])
	QUERY:C277([Sequences:28]; [Sequences:28]Name:1=$SeqName)
	
	If (Records in selection:C76([Sequences:28])=0)
		CREATE RECORD:C68([Sequences:28])  //This is the first time for this sequence.
		[Sequences:28]Name:1:=$SeqName
		[Sequences:28]Value:2:=1  //Starting number.
	Else 
		//Get the next sequence
		LOAD RECORD:C52([Sequences:28])  //``Mods_2004_CJM01
		C_TEXT:C284($user_txt; $Session; $Name_txt)
		C_LONGINT:C283($Process_L; $Count_L; $Win_L)
		$Count_L:=0
		C_BOOLEAN:C305($WindowOpened_B)
		$WindowOpened_B:=False:C215
		While (Locked:C147([Sequences:28]))  //Another process is getting a number
			//IDLE
			DELAY PROCESS:C323(Current process:C322; 60)  //1 second
			//IDLE
			$Count_L:=$Count_L+1
			If (($Count_L%5)=0) & (Not:C34($WindowOpened_B))
				LOCKED BY:C353([Sequences:28]; $Process_L; $user_txt; $Session; $Name_txt)
				$Count_L:=0
				If (Application type:C494=4D Remote mode:K5:5)
					$WindowOpened_B:=True:C214
					$Win_L:=ut_OpenNewWindow(800; 200; 0; Plain window:K34:13; "Locked Sequence")
					MESSAGE:C88("[Sequences] table record "+[Sequences:28]Name:1+" locked by "+$user_txt+" in process "+$Name_txt)
				Else 
					
				End if 
			End if 
			UNLOAD RECORD:C212([Sequences:28])
			LOAD RECORD:C52([Sequences:28])
		End while 
		If ($WindowOpened_B)
			CLOSE WINDOW:C154($Win_L)
		End if 
		[Sequences:28]Value:2:=[Sequences:28]Value:2+1  //Increment the sequence value
		
	End if 
	
	$ptr_id->:=[Sequences:28]Value:2  //Set the ID field
	SAVE RECORD:C53([Sequences:28])
	UNLOAD RECORD:C212([Sequences:28])
	REDUCE SELECTION:C351([Sequences:28]; 0)  // clear slelection
	READ ONLY:C145([Sequences:28])
End if 