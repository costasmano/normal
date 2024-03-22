//%attributes = {"invisible":true}
//M_GetNBIS
//  `made to handle most searches in the Records menu of BridgeList.
//  //Uses the parameter in the menu item 
If (False:C215)
	//Reduce current seletion to NBIS bridges only
	
	// Modified by: costasmanousakis-(Designer)-(4/4/08 16:56:05)
	Mods_2008_CM_5403  //Apply sort
	// Modified by: Costas Manousakis-(Designer)-(11/20/17 17:24:44)
	Mods_2017_11
	//  `made to handle most searches in the Records menu of BridgeList.
	//  //Uses the parameter in the menu item 
	//  //Added options for ONNHS and OFFNHS - added On NHS and Off NHS in the Records menu
	// Modified by: Costas Manousakis-(Designer)-(2021-10-18T00:00:00 10:45:50)
	Mods_2021_10
	//  `added search for STAIRS and RANDOM selection
End if 
C_TEXT:C284($Menuparam_txt)
$Menuparam_txt:=Get selected menu item parameter:C1005

Case of 
	: ($Menuparam_txt="NBIS")
		QUERY SELECTION:C341(pFile->; [Bridge MHD NBIS:1]FHWARecord:174=True:C214)
	: ($Menuparam_txt="NONNBIS")
		QUERY SELECTION:C341(pFile->; [Bridge MHD NBIS:1]FHWARecord:174=False:C215)
	: ($Menuparam_txt="MHDNBI")
		QUERY SELECTION:C341(pfile->; [Bridge MHD NBIS:1]FHWARecord:174=True:C214; *)
		QUERY SELECTION:C341(pfile->;  & ; [Bridge MHD NBIS:1]Item8 Owner:208="DOT")
	: ($Menuparam_txt="MHDNONNBI")
		QUERY SELECTION:C341(pfile->; [Bridge MHD NBIS:1]FHWARecord:174=False:C215; *)
		QUERY SELECTION:C341(pfile->;  & ; [Bridge MHD NBIS:1]Item8 Owner:208="DOT")
		
	: ($Menuparam_txt="ONSYSTEM")
		QUERY SELECTION BY FORMULA:C207([Bridge MHD NBIS:1]; bOnSystem([Bridge MHD NBIS:1]Item26:120)=True:C214)
		
	: ($Menuparam_txt="OFFSYSTEM")
		QUERY SELECTION BY FORMULA:C207([Bridge MHD NBIS:1]; bOffSystem([Bridge MHD NBIS:1]Item26:120)=True:C214)
		
	: ($Menuparam_txt="SD")
		ALERT:C41("The bridges in this list may not have up to date information!")
		QUERY SELECTION:C341([Bridge MHD NBIS:1]; [Bridge MHD NBIS:1]StructDef:103=True:C214)
		
	: ($Menuparam_txt="FO")
		ALERT:C41("The bridges in this list may not have up to date information!")
		QUERY SELECTION:C341([Bridge MHD NBIS:1]; [Bridge MHD NBIS:1]FunctObs:106=True:C214)
		
	: ($Menuparam_txt="ELIGIBLE")
		QUERY SELECTION BY FORMULA:C207([Bridge MHD NBIS:1]; bNBISBridge([Bridge MHD NBIS:1]Item5:59; [Bridge MHD NBIS:1]Item49:93; [Bridge MHD NBIS:1]Item42:85)=True:C214)
		
	: ($Menuparam_txt="NOTELIGIBLE")
		QUERY SELECTION BY FORMULA:C207([Bridge MHD NBIS:1]; bNBISBridge([Bridge MHD NBIS:1]Item5:59; [Bridge MHD NBIS:1]Item49:93; [Bridge MHD NBIS:1]Item42:85)=False:C215)
		
	: ($Menuparam_txt="CARRYHWY")
		
		QUERY SELECTION:C341(pFile->; [Bridge MHD NBIS:1]Item8 BridgeCat:207#"DUM@"; *)  //x
		QUERY SELECTION:C341(pFile->;  & ; [Bridge MHD NBIS:1]Item8 BridgeCat:207#"REM@"; *)  //x
		QUERY SELECTION:C341(pFile->;  & ; [Bridge MHD NBIS:1]Item8 BridgeCat:207#"BKY@"; *)
		QUERY SELECTION:C341(pFile->;  & ; [Bridge MHD NBIS:1]Item8 BridgeCat:207#"CLO@"; *)
		QUERY SELECTION:C341(pFile->;  & ; [Bridge MHD NBIS:1]Item8 BridgeCat:207#"CLP@"; *)
		QUERY SELECTION:C341(pFile->;  & ; [Bridge MHD NBIS:1]Item8 BridgeCat:207#"BLD@"; *)
		QUERY SELECTION:C341(pFile->;  & ; [Bridge MHD NBIS:1]Item8 BridgeCat:207#"UTL@"; *)
		QUERY SELECTION:C341(pFile->;  & ; [Bridge MHD NBIS:1]Item8 BridgeCat:207#"PED@"; *)
		QUERY SELECTION:C341(pFile->;  & ; [Bridge MHD NBIS:1]Item8 BridgeCat:207#"RRO@"; *)
		QUERY SELECTION:C341(pFile->;  & ; [Bridge MHD NBIS:1]Item8 BridgeCat:207#"WRA@"; *)
		QUERY SELECTION:C341(pFile->;  & ; [Bridge MHD NBIS:1]Item8 BridgeCat:207#"TRO@"; *)
		QUERY SELECTION:C341(pFile->;  & ; [Bridge MHD NBIS:1]Item8 BridgeCat:207#"DES@")  //x
		
	: ($Menuparam_txt="TUNNELS")
		QUERY SELECTION:C341(pFile->; [Bridge MHD NBIS:1]Item8 BridgeCat:207="TNL@"; *)  //x
		QUERY SELECTION:C341(pFile->;  | ; [Bridge MHD NBIS:1]Item8 BridgeCat:207="BTS@")  //x
		
	: ($Menuparam_txt="CARRYRAIL")
		QUERY SELECTION:C341(pFile->; [Bridge MHD NBIS:1]Item8 BridgeCat:207="RRO@"; *)  //x
		QUERY SELECTION:C341(pFile->;  | ; [Bridge MHD NBIS:1]Item8 BridgeCat:207="TRO@")  //x
		
	: ($Menuparam_txt="BRIDGESONLY")
		QUERY SELECTION:C341(pFile->; [Bridge MHD NBIS:1]Item8 BridgeCat:207#"DUM"; *)
		QUERY SELECTION:C341(pFile->;  & ; [Bridge MHD NBIS:1]Item8 BridgeCat:207#"CLO"; *)
		QUERY SELECTION:C341(pFile->;  & ; [Bridge MHD NBIS:1]Item8 BridgeCat:207#"BKY"; *)
		QUERY SELECTION:C341(pFile->;  & ; [Bridge MHD NBIS:1]Item8 BridgeCat:207#"UTL"; *)
		QUERY SELECTION:C341(pFile->;  & ; [Bridge MHD NBIS:1]Item8 BridgeCat:207#"BLD"; *)
		QUERY SELECTION:C341(pFile->;  & ; [Bridge MHD NBIS:1]Item8 BridgeCat:207#"REM"; *)
		QUERY SELECTION:C341(pFile->;  & ; [Bridge MHD NBIS:1]Item8 BridgeCat:207#"DES")
		
	: ($Menuparam_txt="STATEONLYMASTER")
		QUERY SELECTION:C341(pFile->; [Bridge MHD NBIS:1]FHWARecord:174=False:C215; *)
		QUERY SELECTION:C341(pFile->;  & ; [Bridge MHD NBIS:1]Item8 BridgeCat:207#"DUM@"; *)
		QUERY SELECTION:C341(pFile->;  & ; [Bridge MHD NBIS:1]Item8 BridgeCat:207#"REM@"; *)
		QUERY SELECTION:C341(pFile->;  & ; [Bridge MHD NBIS:1]Item8 BridgeCat:207#"DES@")
		
	: ($Menuparam_txt="MHSFUND")
		QUERY SELECTION:C341(pFile->; [Bridge MHD NBIS:1]FundingSource:228="MHS")
		
	: ($Menuparam_txt="ONNHS")
		QUERY SELECTION:C341(pFile->; [Bridge MHD NBIS:1]Item104:119=True:C214)
		
	: ($Menuparam_txt="OFFNHS")
		QUERY SELECTION:C341(pFile->; [Bridge MHD NBIS:1]Item104:119=False:C215)
		
	: ($Menuparam_txt="STAIRS")
		QUERY SELECTION:C341(pFile->; [BridgeStairs:192]BIN:2>"")
		
	: ($Menuparam_txt="RANDOM")
		C_LONGINT:C283($num)
		C_TEXT:C284($num_txt)
		$num_txt:=Request:C163("# of random records to select")
		$num:=Num:C11($num_txt)
		If (Position:C15("%"; $num_txt)>0)
			$num:=($num*Records in selection:C76(pFile->))/100
		End if 
		If ($num>0)
			CreateRandomSelection(pfile; $num)
		End if 
End case 

C_TEXT:C284(GEN_SORTLISTCMD_txt)
If (GEN_SORTLISTCMD_txt#"")
	EXECUTE FORMULA:C63(GEN_SORTLISTCMD_txt)
End if 
RegionTitle