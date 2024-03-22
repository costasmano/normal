//%attributes = {"invisible":true}
//ut_executeMethod 
// Parameters
// $1 (Optional) : $methodname
// $2 (Optional) : ("S" | anything or blank ) "S" indicates execute on server
// $3-9 (Optional) : text parameters for the method 

If (False:C215)
	// Modified by: costasmanousakis-(Designer)-(7/26/2006 17:59:02)
	Mods_2006_CMy6
	// Modified by: costasmanousakis-(Designer)-(10/25/2007 10:59:21)
	Mods_2007_CM12_5302
	// Modified by: costasmanousakis-(Designer)-(9/22/08 15:05:47)
	Mods_2008_CM_5404  // ("SELECTLIST")
	//  `Save the last method / command in  a global var
	// Modified by: costasmanousakis-(Designer)-(7/23/10 )
	Mods_2010_07
	//  `Added optional parameters and better handling of executing on server - to serve as a generic execute method.
	// Parameters
	// $1 (Optional) : $methodname
	// $2 (Optional) : ("S" | anything or blank ) "S" indicates execute on server
	// $3-9 (Optional) : text parameters for the method 
	// Modified by: costasmanousakis-(Designer)-(8/31/10 15:49:25)
	Mods_2010_08
	//  `Fixed a bug in the assigning of parameters Param(1...7)_txt
	// Modified by: costasmanousakis-(Designer)-(10/26/10 08:33:29)
	Mods_2010_10
	//  `Changes to remember list of commands between sessions. The list is stored as
	//  ` a Blob in file UTEXEC_Command_file.txt in the active 4D folder.
	//  `Also can "pass" parameters to the method when executed locally, by concatenating them 
	//  `in the command executed. 
	Mods_2011_05  //r002 CJ Miller`05/23/11, 10:25:17    
	//Modify so when compiled we can use parameters in execute
	Mods_2011_06  // CJ Miller`06/13/11, 16:54:56      ` Type all local variables for v11
	// Modified by: costasmanousakis-(Designer)-(12/12/11 09:17:09)
	Mods_2011_12
	//  `sort the array of commands before storing them; remove if(FALSE) code block
	// Modified by: Costas Manousakis-(Designer)-(1/22/14 18:10:47)
	Mods_2014_01
	//  `Added ability to execute on a registered client
	// Modified by: Costas Manousakis-(Designer)-(7/6/15 10:26:01)
	Mods_2015_07_bug
	//  `fixed error in the execute on client call - parameters were not getting passed correctly ; the stacksize was passed first (not needed)
End if 

If (User in group:C338(Current user:C182; "Design Access Group"))
	C_LONGINT:C283($pid)
	ARRAY TEXT:C222(<>UTEXEC_Command_atxt; 0)
	C_TEXT:C284(<>UTEXEC_Command; $UTEXEC_Command_file_txt; $msg; $methodname)
	Startup_PL
	C_BLOB:C604($TempBlob_x)
	C_LONGINT:C283($offset_L)
	C_BOOLEAN:C305($DoCmd_b)
	$UTEXEC_Command_file_txt:=Get 4D folder:C485(Active 4D Folder:K5:10)+"UTEXEC_Command_file.txt"
	If (Test path name:C476($UTEXEC_Command_file_txt)=Is a document:K24:1)
		DOCUMENT TO BLOB:C525($UTEXEC_Command_file_txt; $TempBlob_x)
		$offset_L:=0
		BLOB TO VARIABLE:C533($TempBlob_x; <>UTEXEC_Command_atxt; $offset_L)
		BLOB TO VARIABLE:C533($TempBlob_x; <>UTEXEC_Command; $offset_L)
	Else 
		C_TIME:C306($docref)
		$docref:=Create document:C266($UTEXEC_Command_file_txt)
		CLOSE DOCUMENT:C267($docref)
		ARRAY TEXT:C222(<>UTEXEC_Command_atxt; 1)
		<>UTEXEC_Command_atxt{1}:=""
	End if 
	$methodname:=""
	$DoCmd_b:=False:C215
	
	If (Count parameters:C259>0)
		C_TEXT:C284($1)
		$methodname:=$1
		$DoCmd_b:=True:C214
	End if 
	If ($methodname="")
		$msg:="Select a Command to execute, or enter a new one. "
		$methodname:=ut_Request($msg; -><>UTEXEC_Command_atxt; <>UTEXEC_Command; ""; ""; 2)
		$DoCmd_b:=(OK=1)
	End if 
	
	If ($DoCmd_b)
		<>UTEXEC_Command:=$methodname
		
		C_BOOLEAN:C305($LocalExec_b; $DoRun_b)
		C_LONGINT:C283($loop_L; $ParamCount_L)
		$LocalExec_b:=True:C214
		$DoRun_b:=True:C214
		C_TEXT:C284($ClientName_txt)
		$ClientName_txt:=""
		//Local or on Server?
		C_BOOLEAN:C305($Newprocess_b; $OnClient_b)
		$Newprocess_b:=False:C215
		$OnClient_b:=False:C215
		If (Count parameters:C259>1)
			C_TEXT:C284($2)
			$LocalExec_b:=($2#"S")
		Else 
			If (Application type:C494=4D Remote mode:K5:5)
				ARRAY TEXT:C222($Choises_atxt; 0)
				ARRAY LONGINT:C221($Methods_aL; 0)
				GET REGISTERED CLIENTS:C650($Choises_atxt; $Methods_aL)
				INSERT IN ARRAY:C227($Choises_atxt; 1; 2)
				$Choises_atxt{1}:="Local"
				$Choises_atxt{2}:="Server"
				//CONFIRM("Execute local or on server?";"Local";"Server")
				C_LONGINT:C283($Choise_L)
				$Choise_L:=G_PickFromList(->$Choises_atxt; "Select Where to Execute the method")
				$LocalExec_b:=False:C215
				Case of 
					: ($Choise_L=1)
						$LocalExec_b:=True:C214
					: ($Choise_L=2)
						
					: ($Choise_L>2)
						$ClientName_txt:=$Choises_atxt{$Choise_L}
						$LocalExec_b:=False:C215
						$OnClient_b:=True:C214
				End case 
				
				//$LocalExec_b:=(OK=1)
			End if 
			If (Application type:C494#4D Server:K5:6) & ($LocalExec_b) & Not:C34($OnClient_b)
				CONFIRM:C162("Execute as a new process?"; "Yes"; "No")
				$Newprocess_b:=(OK=1)
			End if 
		End if 
		
		//get parameters if passed
		C_TEXT:C284($Paramtxt; Param1_txt; Param2_txt; Param3_txt; Param4_txt; Param5_txt; Param6_txt; Param7_txt)
		Param1_txt:=""
		Param2_txt:=""
		Param3_txt:=""
		Param4_txt:=""
		Param5_txt:=""
		Param6_txt:=""
		Param7_txt:=""
		C_POINTER:C301($Param_ptr)
		C_LONGINT:C283($parcounter)
		$parcounter:=0
		C_BOOLEAN:C305($getParams_b)
		$getParams_b:=True:C214  //if there were parameters passed we will not ask for any
		$parcounter:=0
		If (Count parameters:C259>2)
			C_TEXT:C284(${3})
			If (Count parameters:C259>9)
				CONFIRM:C162("More than 9 parameters passed! Only the first 7 will be used! Do you wish to cont"+"inue?")
				$DoRun_b:=(Ok=1)
			Else 
				$DoRun_b:=True:C214
			End if 
			If ($DoRun_b)
				$ParamCount_L:=MinNum(Count parameters:C259; 9)
				For ($loop_L; 3; $ParamCount_L)
					$Param_ptr:=Get pointer:C304("Param"+String:C10($loop_L-2)+"_txt")
					$Param_ptr->:=${$loop_L}
					$parcounter:=$parcounter+1
				End for 
				$getParams_b:=False:C215  //Do not ask for parameters when executing on server
			End if 
			
		End if 
		If ($DoRun_b)  //Maybe canceled in the GETPARAMETERS check above
			
			If ($LocalExec_b)
				If ($Newprocess_b)
					If ($getParams_b)
						$parcounter:=1
						While ($getParams_b)
							$Paramtxt:=Request:C163("Enter parameter #"+String:C10($parcounter))
							If (OK=1)
								$Param_ptr:=Get pointer:C304("Param"+String:C10($parcounter)+"_txt")
								$Param_ptr->:=$Paramtxt
								$parcounter:=$parcounter+1
							Else 
								$getParams_b:=False:C215
							End if 
							If ($parcounter>7)
								$getParams_b:=False:C215
							End if 
						End while 
						$parcounter:=$parcounter-1
					End if 
					
					Case of 
						: ($parcounter=0)
							$pid:=New process:C317($methodname; <>LStackSize; $methodname)
							
						: ($parcounter=1)
							$pid:=New process:C317($methodname; <>LStackSize; $methodname; Param1_txt)
							
						: ($parcounter=2)
							$pid:=New process:C317($methodname; <>LStackSize; $methodname; Param1_txt; Param2_txt)
							
						: ($parcounter=3)
							$pid:=New process:C317($methodname; <>LStackSize; $methodname; Param1_txt; Param2_txt; Param3_txt)
							
						: ($parcounter=4)
							$pid:=New process:C317($methodname; <>LStackSize; $methodname; Param1_txt; Param2_txt; Param3_txt; Param4_txt)
							
						: ($parcounter=5)
							$pid:=New process:C317($methodname; <>LStackSize; $methodname; Param1_txt; Param2_txt; Param3_txt; Param4_txt; Param5_txt)
							
						: ($parcounter=6)
							$pid:=New process:C317($methodname; <>LStackSize; $methodname; Param1_txt; Param2_txt; Param3_txt; Param4_txt; Param5_txt; Param6_txt)
							
						: ($parcounter=7)
							$pid:=New process:C317($methodname; <>LStackSize; $methodname; Param1_txt; Param2_txt; Param3_txt; Param4_txt; Param5_txt; Param6_txt; Param7_txt)
							
					End case 
				Else 
					//`Execute Locally
					If ($parcounter>0)  //if there were no parameters passed we don;t ask for any when local - maybe that should change
						//add parameters to the call
						$Param_ptr:=Get pointer:C304("Param1_txt")
						$methodname:=$methodname+"("+<>sQu+Param1_txt+<>sQu  //open paren
						For ($loop_L; 2; $parcounter)
							$Param_ptr:=Get pointer:C304("Param"+String:C10($loop_L)+"_txt")
							$methodname:=$methodname+";"+<>sQu+$Param_ptr->+<>sQu
						End for 
						$methodname:=$methodname+")"  //close paren
					End if 
					
					EXECUTE FORMULA:C63($methodname)
				End if 
			Else 
				//`Execute on Server or another client
				//we'll ask for parameters if there were not any passed
				If ($getParams_b)
					$parcounter:=1
					While ($getParams_b)
						$Paramtxt:=Request:C163("Enter parameter #"+String:C10($parcounter))
						If (OK=1)
							$Param_ptr:=Get pointer:C304("Param"+String:C10($parcounter)+"_txt")
							$Param_ptr->:=$Paramtxt
							$parcounter:=$parcounter+1
						Else 
							$getParams_b:=False:C215
						End if 
						If ($parcounter>7)
							$getParams_b:=False:C215
						End if 
					End while 
					$parcounter:=$parcounter-1
				End if 
				If ($ClientName_txt="")
					//execute on server
					Case of 
						: ($parcounter=0)
							$pid:=Execute on server:C373($methodname; <>LStackSize; $methodname)
							
						: ($parcounter=1)
							$pid:=Execute on server:C373($methodname; <>LStackSize; $methodname; Param1_txt)
							
						: ($parcounter=2)
							$pid:=Execute on server:C373($methodname; <>LStackSize; $methodname; Param1_txt; Param2_txt)
							
						: ($parcounter=3)
							$pid:=Execute on server:C373($methodname; <>LStackSize; $methodname; Param1_txt; Param2_txt; Param3_txt)
							
						: ($parcounter=4)
							$pid:=Execute on server:C373($methodname; <>LStackSize; $methodname; Param1_txt; Param2_txt; Param3_txt; Param4_txt)
							
						: ($parcounter=5)
							$pid:=Execute on server:C373($methodname; <>LStackSize; $methodname; Param1_txt; Param2_txt; Param3_txt; Param4_txt; Param5_txt)
							
						: ($parcounter=6)
							$pid:=Execute on server:C373($methodname; <>LStackSize; $methodname; Param1_txt; Param2_txt; Param3_txt; Param4_txt; Param5_txt; Param6_txt)
							
						: ($parcounter=7)
							$pid:=Execute on server:C373($methodname; <>LStackSize; $methodname; Param1_txt; Param2_txt; Param3_txt; Param4_txt; Param5_txt; Param6_txt; Param7_txt)
							
					End case 
				Else 
					//execute on client $ClientName_txt
					Case of 
						: ($parcounter=0)
							EXECUTE ON CLIENT:C651($ClientName_txt; $methodname)
							
						: ($parcounter=1)
							EXECUTE ON CLIENT:C651($ClientName_txt; $methodname; Param1_txt)
							
						: ($parcounter=2)
							EXECUTE ON CLIENT:C651($ClientName_txt; $methodname; Param1_txt; Param2_txt)
							
						: ($parcounter=3)
							EXECUTE ON CLIENT:C651($ClientName_txt; $methodname; Param1_txt; Param2_txt; Param3_txt)
							
						: ($parcounter=4)
							EXECUTE ON CLIENT:C651($ClientName_txt; $methodname; Param1_txt; Param2_txt; Param3_txt; Param4_txt)
							
						: ($parcounter=5)
							EXECUTE ON CLIENT:C651($ClientName_txt; $methodname; Param1_txt; Param2_txt; Param3_txt; Param4_txt; Param5_txt)
							
						: ($parcounter=6)
							EXECUTE ON CLIENT:C651($ClientName_txt; $methodname; Param1_txt; Param2_txt; Param3_txt; Param4_txt; Param5_txt; Param6_txt)
							
						: ($parcounter=7)
							EXECUTE ON CLIENT:C651($ClientName_txt; $methodname; Param1_txt; Param2_txt; Param3_txt; Param4_txt; Param5_txt; Param6_txt; Param7_txt)
							
					End case 
					
				End if 
				
				//$pid:=Execute on server($methodname;◊LStackSize;Substring($methodname;1;30);Param1_txt;Param2_txt;Param3_txt;Param4_txt;Param5_txt;Param6_txt;Param7_txt)
			End if 
			If (Find in array:C230(<>UTEXEC_Command_atxt; <>UTEXEC_Command)>0)
			Else 
				INSERT IN ARRAY:C227(<>UTEXEC_Command_atxt; 0; 1)
				<>UTEXEC_Command_atxt{1}:=<>UTEXEC_Command
			End if 
			
			SET BLOB SIZE:C606($TempBlob_x; 0)
			SORT ARRAY:C229(<>UTEXEC_Command_atxt)
			VARIABLE TO BLOB:C532(<>UTEXEC_Command_atxt; $TempBlob_x)
			VARIABLE TO BLOB:C532(<>UTEXEC_Command; $TempBlob_x; *)
			BLOB TO DOCUMENT:C526($UTEXEC_Command_file_txt; $TempBlob_x)
			SET BLOB SIZE:C606($TempBlob_x; 0)
			
		End if 
		
	End if 
	
End if 