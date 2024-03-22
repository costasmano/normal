If (False:C215)
	Mods_2004_CM03
	Mods_2004_CM06
	Mods_2005_CM03
	Mods_2005_CM12
	// Modified by: costasmanousakis-(Designer)-(12/13/2005 15:58:04)
	Mods_2005_CM20
	// Modified by: costasmanousakis-(Designer)-(4/21/09 20:11:32)
	Mods_2009_04
	//Place WildCard around "MHD BMS External" for new .4Dx extensions 
	Mods_2009_10  //v451 r001 CJ Miller`10/22/09, 11:50:43   `Add check to make sure triggers run only on inside data base
	Mods_2013_10  //r001 ` ` Set up for maximo updates
	//Modified by: Charles Miller (10/8/13 15:27:27)
	// Modified by: Costas Manousakis-(Designer)-(11/1/13 07:48:34)
	Mods_2013_11
	//  `Move the trace if designer here from the Startup method
	// Modified by: Costas Manousakis-(Designer)-(4/6/18 11:40:06)
	Mods_2018_04
	//  `added call to NTI_UpdateDBonStartup
	Mods_2019_06  //Add a new group called SingleSignOn. If user is in that group check for other logins and if found quit
	//Modified by: Chuck Miller (6/4/19 16:36:53)
	// Modified by: Costas Manousakis-(Designer)-(8/28/20 10:17:25)
	Mods_2020_08_bug
	//  `cleared up code
	// Modified by: Costas Manousakis-(Designer)-(2022-01-20T00:00:00 17:27:49)
	Mods_2022_01
	//  `for non-client make sure there is a preferences record
	// Modified by: Costas Manousakis-(Designer)-(2022-11-21 15:13:35)
	Mods_2022_11
	//  `load 4DPop only for Design Access users and move after call to Startup
	
End if 

//If (User in group(Current user; "Design Access Group"))
//TRACE
//End if 
C_LONGINT:C283($ref)

If (Application type:C494=4D Local mode:K5:1)
	$ref:=Open form window:C675("__logIn"; Movable form dialog box:K39:8)
	DIALOG:C40("__logIn")
	CLOSE WINDOW:C154($ref)
Else 
	OK:=1
End if 

If (OK=1)
	ut_SetTimeOuts
	ARRAY LONGINT:C221(<>NextNumberArray_al; 100)
	C_LONGINT:C283($Loop_l)
	For ($Loop_l; 1; 100)
		<>NextNumberArray_al{$Loop_l}:=-9
	End for 
	C_TEXT:C284(<>DatabaseStructureName_txt)
	C_BOOLEAN:C305($LogInEnabled_b)
	$LogInEnabled_b:=True:C214
	
	If (Application type:C494=4D Remote mode:K5:5)
		$LogInEnabled_b:=CA_fAllowLogins
	End if 
	If ($LogInEnabled_b)  //users can log in
		clone_CheckSQLVariables
		C_TEXT:C284($StructFile; $DataFile)  // old C_STRING length 255
		C_LONGINT:C283($appType)  // **Replaced C_LONGINT()//Command Replaced was o_C_INTEGER
		C_BOOLEAN:C305($compiledapp)
		C_TEXT:C284($msg)
		//TRACE
		$appType:=Application type:C494
		$compiledapp:=Is compiled mode:C492
		$StructFile:=Structure file:C489
		$DataFile:=Data file:C490
		
		//check for locked data file only if not running client
		Startup_PL
		If ($AppType#4D Remote mode:K5:5)
			SET CURSOR:C469(128)
			SHORT_MESSAGE("Checking Locked Status of Data File...")
			If (bDataFileLocked)
				SET CURSOR:C469(0)
				CLOSE WINDOW:C154
				$msg:="Data file "+$DataFile+" is in use by another application, possibly 4D Server."+Char:C90(13)
				$msg:=$msg+"  Application exiting..."
				ALERT:C41($msg)
				QUIT 4D:C291
			End if 
			CLOSE WINDOW:C154
			SET CURSOR:C469(0)
			If (Records in table:C83([Preferences:57])>0)
			Else 
				CREATE RECORD:C68([Preferences:57])
				SAVE RECORD:C53([Preferences:57])
			End if 
		Else 
			//Register client for 4D Client connections
			ARRAY TEXT:C222($ConnectUsers_atxt; 0)
			ARRAY LONGINT:C221($Methods_aL; 0)
			C_LONGINT:C283($pos_L)
			
			C_TEXT:C284($CurrentUser_txt; $CurrentUserPlus_txt)
			$CurrentUserPlus_txt:=Current user:C182+"~"+Current machine:C483+"~"+Current system user:C484
			$CurrentUser_txt:=Current user:C182+"~@"
			If (User in group:C338(Current user:C182; "SingleSignOn"))
				GET REGISTERED CLIENTS:C650($ConnectUsers_atxt; $Methods_aL)
				$pos_L:=Find in array:C230($ConnectUsers_atxt; $CurrentUser_txt)
				If ($pos_L>0)
					ARRAY TEXT:C222($Parts_atxt; 0)
					ut_NewTextToArray($ConnectUsers_atxt{$pos_L}; ->$Parts_atxt; "~")
					
					ut_MessageDia("MADOT BMS User name "+Current user:C182+" is already in use by "+$Parts_atxt{3}+" on machine "+$Parts_atxt{2}+". The application will now quit!"; "Single Sign On Duplicate Logon"; 1; 1)
					
					QUIT 4D:C291
				Else 
					UNREGISTER CLIENT:C649
					REGISTER CLIENT:C648($CurrentUserPlus_txt)
					
				End if 
			Else 
				
				UNREGISTER CLIENT:C649
				REGISTER CLIENT:C648($CurrentUserPlus_txt)
			End if 
			
		End if 
		//if structure file contains the word test then this is a test version
		If ($StructFile="@test@")
			
			If ((Current user:C182="Designer") | (Current user:C182="Administrator"))
				//This message is just for designer or administrator    
				$msg:="App : "+String:C10($appType)+Char:C90(13)
				$msg:=$msg+"S : "+$StructFile+Char:C90(13)
				$msg:=$msg+"D : "+$DataFile+Char:C90(13)
				$msg:=$msg+"C : "+f_Boolean2String($compiledapp; "YN")
				ALERT:C41($msg)
			End if 
			
			$msg:="This is a Test version of the MHD BMS database!!!"+Char:C90(13)
			$msg:=$msg+"It is meant for testing purposes only!!!!"+Char:C90(13)
			$msg:=$msg+"If you do not want to take part of the test , you should quit!!!!"
			
			CONFIRM:C162(Uppercase:C13($msg); "Quit"; "Continue Test")
			If (Ok=1)
				QUIT 4D:C291
			End if 
			
		End if 
		
		NTI_UpdateDBonStartup
		Startup
		
		If (Not:C34(Is compiled mode:C492))
			If (User in group:C338(Current user:C182; "Design Access Group"))
				ARRAY TEXT:C222($Components_atxt; 0)
				COMPONENT LIST:C1001($Components_atxt)
				If (Find in array:C230($Components_atxt; "4DPop")>0)
					EXECUTE METHOD:C1007("4DPop_Palette")
				End if 
				
			End if 
		End if 
		
		If (($appType=4D Remote mode:K5:5) & ($StructFile="@MHD BMS External@") & (Current user:C182="BMSEXternal Server"))
			Launch_CtrlClientProc
		End if 
	Else 
		QUIT 4D:C291
	End if 
Else 
	QUIT 4D:C291
End if 