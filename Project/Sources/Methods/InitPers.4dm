//%attributes = {"invisible":true}
If (False:C215)
	//GP InitPers
	//Copyright © 1997, Albert S. Leung and Thomas D. Nee, All Rights Reserved.
	
	//Initialize Personnel Arrays.
	
	Mods_2005_CM05
	Mods_2005_CM12
	// Modified by: costasmanousakis-(Designer)-(1/19/2006 16:26:53)
	Mods_2006_CM03
	// Modified by: costasmanousakis-(Designer)-(2/9/2006 09:44:28)
	Mods_2006_CM03
	// Modified by: costasmanousakis-(Designer)-(9/11/2007 16:16:18)
	Mods_2007_CM12_5301
	// Modified by: costasmanousakis-(Designer)-(11/26/07 10:00:58)
	Mods_2007_CM_5401
	// Modified by: costasmanousakis-(Designer)-(11/28/07 11:12:32)
	Mods_2007_CM_5401
	// Modified by: costasmanousakis-(Designer)-(10/22/10 09:33:47)
	Mods_2010_10
	//  `Changed 'Dive Division' to 0449, and  ($distNum<9)) instead of <6- increased ◊aDBIEUnames to array(;6);
	//  `Use field [Personnel]UserID_4D to get the 4D username
	// Modified by: costasmanousakis-(Designer)-(5/4/11 14:33:06)
	Mods_2011_05
	//Removed code run for TOM NEE user.  Replaced by new method ut_UpdateEmployerList
	// Modified by: costasmanousakis-(Designer)-(10/6/11 10:05:05)
	Mods_2011_10
	//  `Adjusted code to include both MHD Underwater and Mass Highway employees in team leader / member lists
	// Modified by: Costas Manousakis-(Designer)-(12/17/12 11:02:07)
	Mods_2012_12
	//  `Discontinued calculating array ◊aDBIEUnames. Set array size to 0 to avoid problems in the blob storage sequence.
	// Modified by: Costas Manousakis-(Designer)-(6/6/13 13:52:16)
	Mods_2013_06
	//  `Added code to modify the  aAgency array to include employers of active inspectors from the personnel table
	//  `Don't change RO state of  [Personnel] table if already read only
	// Modified by: Costas Manousakis-(Designer)-(4/6/15 16:14:34)
	Mods_2015_04_bug
	//  `for the apeople array, if the name is all spaces - change it to blank  string ("")
	// Modified by: Costas Manousakis-(Designer)-(9/25/17 16:47:57)
	Mods_2017_09
	//  `for UOE engineer drop down look only under division = 0449
	// Modified by: Costas Manousakis-(Designer)-(3/15/19 16:54:12)
	Mods_2019_03_bug
	//  `use "@" when searching for Tunnel Eng and Insp Eng groups
	// Modified by: Costas Manousakis-(Designer)-(6/2/20 16:28:51)
	Mods_2020_06
	//  `use method INSP_addTeamLeaders to add to the list of TL members of BRI or FRZ 
	//  // TeamLeader personnel groups for non-NBI inspections and/or FRZ inspection types - for CallReference #714
	// Modified by: Costas Manousakis-(Designer)-(7/9/20 15:25:42)
	Mods_2020_07
	//  `use method INSP_addTeamLeaders to add to the list of TL members for Inventory photo inspections  
	// Modified by: Costas Manousakis-(Designer)-(2/26/21 14:36:53)
	Mods_2021_02
	//  `use method INSP_addTeamLeaders to add to the list of TL members for Tunnel (TIN) inspections  
	//  `adjusted call to get project managers depending on inspection table  
	
End if 

C_BOOLEAN:C305($ResetAll; $ReturnBlob)
C_TEXT:C284($Agency)  // **Replaced old C_STRING length 30
C_LONGINT:C283($i; $k)  // **replaced _ o _C_INTEGER()
$ReturnBlob:=False:C215
Case of 
	: (Count parameters:C259=0)
		//No agency specified.   Reset all personnel arrays.
		//This should be the case for the first time through InitPers.
		$ResetAll:=True:C214
		$Agency:=""
	: ($1="1")  //special case to save values to a blob
		$ResetAll:=True:C214
		$Agency:=""
		C_BLOB:C604($0; $Return_blb)
		SET BLOB SIZE:C606($Return_blb; 0)
		C_LONGINT:C283($OffSet_l)
		$OffSet_l:=0
		$ReturnBlob:=True:C214
		
	Else 
		//An agency has been specified.   Only the team leader and team
		//member arrays will be set up (using that agency's personnel).
		$Agency:=$1
		$ResetAll:=False:C215
End case 

C_BOOLEAN:C305($PersRO_b)
$PersRO_b:=Read only state:C362([Personnel:42])
If (Not:C34($PersRO_b))
	READ ONLY:C145([Personnel:42])
End if 

//Set up the local arrays.
ARRAY TEXT:C222($firstname; 0)  // **Replaced old _ o _ARRAY STRING length 44
ARRAY TEXT:C222($midname; 0)  // **Replaced old _ o _ARRAY STRING length 20
ARRAY TEXT:C222($lastname; 0)  // **Replaced old _ o _ARRAY STRING length 24
ARRAY TEXT:C222($aDivNo; 0)  // **Replaced old _ o _ARRAY STRING length 4
ARRAY INTEGER:C220($aPersonID; 0)
ARRAY LONGINT:C221($a4DUserID; 0)
C_POINTER:C301($p)
C_LONGINT:C283($tablenum; $fldnum; $distNum)  // **replaced _ o _C_INTEGER()
C_TEXT:C284($pname)  // **Replaced old C_STRING length 40

If ($ResetAll)
	//Set up the agency array.
	ARRAY TEXT:C222(aAgency; 0)  // **Replaced old _ o _ARRAY STRING length 80
	ARRAY TEXT:C222(aJob; 0)  // **Replaced old _ o _ARRAY STRING length 80
	
	LIST TO ARRAY:C288("Employers"; aAgency)
	
	ARRAY TEXT:C222($PersEmployers_as; 0)  // **Replaced old _ o _ARRAY STRING length 80
	QUERY:C277([Personnel:42]; [Personnel:42]Active:11=True:C214)  //get all active inspectors
	DISTINCT VALUES:C339([Personnel:42]Employer:9; $PersEmployers_as)  //get the employers
	C_LONGINT:C283($loop_L; $EmplExist_L)
	For ($loop_L; 1; Size of array:C274($PersEmployers_as))  //Check if the employer exists in the array from the list, if not add to list and sort it
		
		If ($PersEmployers_as{$loop_L}#"")
			If (Find in array:C230(aAgency; $PersEmployers_as{$loop_L})<0)
				APPEND TO ARRAY:C911(aAgency; $PersEmployers_as{$loop_L})
			End if 
			
		End if 
	End for 
	SORT ARRAY:C229(aAgency)
	If ($ReturnBlob)
		VARIABLE TO BLOB:C532(aAgency; $Return_blb; *)
	End if 
	
	//Set up the job code arrays.
	LIST TO ARRAY:C288("Jobs"; aJob)
	ARRAY INTEGER:C220(aJobCode; Size of array:C274(aJob))
	For ($i; 1; Size of array:C274(aJob))
		aJobCode{$i}:=$i
	End for 
	
	If ($ReturnBlob)
		VARIABLE TO BLOB:C532(aJob; $Return_blb; *)
		VARIABLE TO BLOB:C532(aJobCode; $Return_blb; *)
	End if 
	
	//Array for personnel files
	ARRAY TEXT:C222(aPeople; 0)  // **Replaced old _ o _ARRAY STRING length 44
	ARRAY INTEGER:C220(aPeople_ID; 0)
	ARRAY TEXT:C222(aBIE; 0)  // **Replaced old _ o _ARRAY STRING length 44
	ARRAY INTEGER:C220(aBIE_ID; 0)
	ARRAY TEXT:C222(aUOE; 2)  //only one Underwater Engr to start ` **Replaced old _ o _ARRAY STRING length 44
	ARRAY INTEGER:C220(aUOEID; 2)
	ARRAY TEXT:C222(aDiveMaster; 0)  // **Replaced old _ o _ARRAY STRING length 44
	ARRAY INTEGER:C220(aDiveMasterID; 0)
	ARRAY TEXT:C222(aTeamLeader; 0)  // **Replaced old _ o _ARRAY STRING length 44
	ARRAY INTEGER:C220(aTeamLdrID; 0)
	ARRAY TEXT:C222(aTeamMbr; 0)  // **Replaced old _ o _ARRAY STRING length 44
	ARRAY INTEGER:C220(aTeamMbrID; 0)
	
	//The name and ID of the Underwater Operations Engineer
	C_TEXT:C284(<>UOEName)  // **Replaced old C_STRING length 44
	C_LONGINT:C283(<>UOEID)  // **replaced _ o _C_INTEGER()
	//variables for usernames of UOE and DBIEs
	C_TEXT:C284(<>UOEUname; <>DBIED1Uname; <>DBIED2Uname; <>DBIED3Uname; <>DBIED4Uname; <>DBIED5Uname)  // **Replaced old C_STRING length 44
	ARRAY TEXT:C222(<>aDBIEUnames; 0)  // **Replaced old _ o _ARRAY STRING length 44
	
	//Build arrays for all personnel.
	ALL RECORDS:C47([Personnel:42])
	ORDER BY:C49([Personnel:42]; [Personnel:42]Last Name:5; [Personnel:42]First Name:3; [Personnel:42]Middle Name:4)
	SELECTION TO ARRAY:C260([Personnel:42]First Name:3; $firstname; [Personnel:42]Middle Name:4; $midname; [Personnel:42]Last Name:5; $lastname; [Personnel:42]Person ID:1; $aPersonID)
	
	For ($i; 1; Records in selection:C76([Personnel:42]))
		//Concatenate the names.  
		If ($midname{$i}#"")
			$firstname{$i}:=$firstname{$i}+" "+$midname{$i}
		End if 
		$firstname{$i}:=$firstname{$i}+" "+$lastname{$i}
		If (Replace string:C233($firstname{$i}; " "; "")="")  //if it is all spaces- set it to blank
			$firstname{$i}:=""
		End if 
	End for 
	
	COPY ARRAY:C226($firstname; aPeople)
	COPY ARRAY:C226($aPersonID; aPeople_ID)
	If ($ReturnBlob)
		VARIABLE TO BLOB:C532(aPeople; $Return_blb; *)
		VARIABLE TO BLOB:C532(aPeople_ID; $Return_blb; *)
	End if 
	
	//build arrays for Underwater Operations Engineer.  
	QUERY:C277([Personnel:42]; [Personnel:42]Job Code:8=1; *)
	QUERY:C277([Personnel:42];  & ; [Personnel:42]DiveTeam:10=True:C214; *)
	QUERY:C277([Personnel:42];  & ; [Personnel:42]Division No:7="0449"; *)
	QUERY:C277([Personnel:42];  & ; [Personnel:42]Active:11=True:C214)
	If (Records in selection:C76([Personnel:42])=0)
		<>UOEName:="Joseph P. Donahue"  //11/7/2001 ASL
		$k:=Find in array:C230(aPeople; <>UOEName)
		If ($k>0)
			<>UOEID:=aPeople_ID{$k}
			<>UOEUname:="Joseph Donahue"
		Else 
			<>UOEID:=-1
			<>UOEUname:="UnKnown"
		End if 
		aUOE{1}:=<>UOEName
		aUOEID{1}:=<>UOEID
		aUOE{2}:=""
		aUOEID{2}:=0
	Else 
		$k:=Records in selection:C76([Personnel:42])
		SELECTION TO ARRAY:C260([Personnel:42]First Name:3; $firstname; [Personnel:42]Middle Name:4; $midname; [Personnel:42]Last Name:5; $lastname; [Personnel:42]Person ID:1; $aPersonID; [Personnel:42]Division No:7; $aDivNo)
		ARRAY TEXT:C222(aUOE; ($k+1))  // **Replaced old _ o _ARRAY STRING length 44
		ARRAY INTEGER:C220(aUOEID; ($k+1))
		For ($i; 1; $k)
			If ($aDivNo{$i}="0449")  //UW Review Eng is assigned to Div 0449
				<>UOEID:=$aPersonID{$i}
				<>UOEUname:=$firstname{$i}+" "+$lastname{$i}  //name for review access.
			End if 
			If ($midname{$i}#"")
				$firstname{$i}:=$firstname{$i}+" "+$midname{$i}
			End if 
			$firstname{$i}:=$firstname{$i}+" "+$lastname{$i}
			aUOE{$i}:=$firstname{$i}
			aUOEID{$i}:=$aPersonID{$i}
			If ($aDivNo{$i}="0449")  //UW Eng is assigned to Div 0449
				<>UOEName:=$firstname{$i}  //name for Insp forms.
			End if 
		End for 
		aUOE{($k+1)}:=""
		aUOEID{($k+1)}:=0
		
	End if 
	If ($ReturnBlob)
		VARIABLE TO BLOB:C532(<>UOEName; $Return_blb; *)
		VARIABLE TO BLOB:C532(<>UOEUname; $Return_blb; *)
		VARIABLE TO BLOB:C532(<>UOEID; $Return_blb; *)
		VARIABLE TO BLOB:C532(aUOE; $Return_blb; *)
		VARIABLE TO BLOB:C532(aUOEID; $Return_blb; *)
	End if 
	
	//Build arrays for bridge inspection engineer
	QUERY:C277([Personnel:42]; [Personnel:42]Job Code:8=1; *)
	QUERY:C277([Personnel:42];  | ; [Personnel:42]Job Code:8=7; *)  //added 2003-12-24 to check for area engineers
	QUERY:C277([Personnel:42];  & ; [Personnel:42]Active:11=True:C214)
	ORDER BY:C49([Personnel:42]; [Personnel:42]Division No:7; [Personnel:42]Last Name:5; [Personnel:42]First Name:3)
	SELECTION TO ARRAY:C260([Personnel:42]First Name:3; $firstname; [Personnel:42]Middle Name:4; $midname; [Personnel:42]Last Name:5; $lastname; [Personnel:42]Person ID:1; $aPersonID; [Personnel:42]Division No:7; $aDivNo; [Personnel:42]UserID_4D:12; $a4DUserID)
	For ($i; 1; Records in selection:C76([Personnel:42]))
		
		If (False:C215)
			$distNum:=Num:C11(Substring:C12($aDivNo{$i}; 4; 1))
			If (($distNum>0) & ($distNum<9))
				C_TEXT:C284($Username4d_txt; $start_txt; $Pwd_txt)
				C_LONGINT:C283($nbLogin_L)
				C_DATE:C307($lastLogin_d)
				GET USER PROPERTIES:C611($a4DUserID{$i}; $Username4d_txt; $start_txt; $Pwd_txt; $nbLogin_L; $lastLogin_d)
				//◊aDBIEUnames{$distNum}:=$firstname{$i}+" "+$lastname{$i}
				<>aDBIEUnames{$distNum}:=$Username4d_txt
				
			End if 
			
		End if 
		//Concatenate the first and last name.    
		Case of 
			: ($aDivNo{$i}="044@")
				$firstname{$i}:="D-"+Substring:C12($aDivNo{$i}; 4; 1)+"  "+$firstname{$i}
			Else 
				$firstname{$i}:=$aDivNo{$i}+"  "+$firstname{$i}
		End case 
		If ($midname{$i}#"")
			$firstname{$i}:=$firstname{$i}+" "+$midname{$i}
		End if 
		$firstname{$i}:=$firstname{$i}+" "+$lastname{$i}
	End for 
	COPY ARRAY:C226($firstname; aBIE)
	COPY ARRAY:C226($aPersonID; aBIE_ID)
	If ($ReturnBlob)
		VARIABLE TO BLOB:C532(<>aDBIEUnames; $Return_blb; *)
		VARIABLE TO BLOB:C532(aBIE; $Return_blb; *)
		VARIABLE TO BLOB:C532(aBIE_ID; $Return_blb; *)
	End if 
	
	QUERY:C277([Personnel:42]; [Personnel:42]DiveTeam:10=True:C214; *)
	QUERY:C277([Personnel:42];  & ; [Personnel:42]Active:11=True:C214)
	ORDER BY:C49([Personnel:42]; [Personnel:42]Last Name:5; [Personnel:42]First Name:3; [Personnel:42]Middle Name:4)
	SELECTION TO ARRAY:C260([Personnel:42]First Name:3; $firstname; [Personnel:42]Middle Name:4; $midname; [Personnel:42]Last Name:5; $lastname; [Personnel:42]Person ID:1; $aPersonID)
	
	For ($i; 1; Records in selection:C76([Personnel:42]))
		//Concatenate the names.  
		If ($midname{$i}#"")
			$firstname{$i}:=$firstname{$i}+" "+$midname{$i}
		End if 
		$firstname{$i}:=$firstname{$i}+" "+$lastname{$i}
	End for 
	
	COPY ARRAY:C226($firstname; aDiveMaster)
	COPY ARRAY:C226($aPersonID; aDiveMasterID)
	//End Change ASL
	If ($ReturnBlob)
		VARIABLE TO BLOB:C532(aDiveMaster; $Return_blb; *)
		VARIABLE TO BLOB:C532(aDiveMasterID; $Return_blb; *)
	End if 
	
End if   //If ($ResetAll)

//Build arrays for team leader
QUERY:C277([Personnel:42]; [Personnel:42]Job Code:8<=2; *)
QUERY:C277([Personnel:42];  | ; [Personnel:42]Job Code:8=7; *)
QUERY:C277([Personnel:42];  | ; [Personnel:42]Job Code:8=6)
QUERY SELECTION:C341([Personnel:42]; [Personnel:42]Active:11=True:C214)

If ($Agency#"")
	If ($Agency="MHD@")
		//This allows for a separate listing for MHD Underwater Operations.
		QUERY SELECTION:C341([Personnel:42]; [Personnel:42]Employer:9=$Agency; *)
		$Agency:="Mass. Highway Dept."
		QUERY SELECTION:C341([Personnel:42];  | ; [Personnel:42]Employer:9=$Agency)
	Else 
		QUERY SELECTION:C341([Personnel:42]; [Personnel:42]Employer:9=$Agency)
	End if 
End if 

Case of 
	: (Current form table:C627=->[Inspections:27])
		//check if running under the [inspections] table
		If ($Agency#"")
			
			//for a non-NBI bridge add to the selection of team leaders the people in Pers_group BRI_TeamLeaders for the current agency
			If (Not:C34([Bridge MHD NBIS:1]FHWARecord:174))
				INSP_addTeamLeaders("BRI_TeamLeaders"; $Agency)
			End if 
			
			//for a freeze thaw inspection add to selection of team leaders the people in Pers_group FRZ_TeamLeaders for the current agency
			If ([Inspections:27]Insp Type:6="FRZ")
				INSP_addTeamLeaders("FRZ_TeamLeaders"; $Agency)
			End if 
		End if 
		
	: (Current form table:C627=->[InventoryPhotoInsp:112])
		//check if running under the [InventoryPhotoInsp] table
		INSP_addTeamLeaders("INV_TeamLeaders"; $Agency)
		
	: (Current form table:C627=->[TIN_Inspections:184])
		//Tunnel inspections
		INSP_addTeamLeaders("TIN_TeamLeaders"; $Agency)
		
End case 

ORDER BY:C49([Personnel:42]; [Personnel:42]Last Name:5; [Personnel:42]First Name:3; [Personnel:42]Middle Name:4)

SELECTION TO ARRAY:C260([Personnel:42]First Name:3; $firstname; [Personnel:42]Middle Name:4; $midname; [Personnel:42]Last Name:5; $lastname; [Personnel:42]Person ID:1; $aPersonID)
If ($Agency="Mass. Highway Dept.")
	SELECTION TO ARRAY:C260([Personnel:42]Division No:7; $aDivNo)
	ARRAY TEXT:C222($aSpecialSort; Records in selection:C76([Personnel:42]))  // **Replaced old _ o _ARRAY STRING length 80
	C_TEXT:C284($currdistr)  // **Replaced old C_STRING length 2
	$currDistr:=Substring:C12([Bridge MHD NBIS:1]Item2:60; 2)
	For ($i; 1; Records in selection:C76([Personnel:42]))
		If (Substring:C12($aDivNo{$i}; 4)=$currDistr)
			$aSpecialSort{$i}:="0"+$lastname{$i}+$firstname{$i}
		Else 
			$aSpecialSort{$i}:="1"+$lastname{$i}+$firstname{$i}
		End if 
	End for 
	SORT ARRAY:C229($aSpecialSort; $firstname; $midname; $lastname; $aPersonID)
End if 

For ($i; 1; Records in selection:C76([Personnel:42]))
	//Concatenate the names.  
	If ($midname{$i}#"")
		$firstname{$i}:=$firstname{$i}+" "+$midname{$i}
	End if 
	$firstname{$i}:=$firstname{$i}+" "+$lastname{$i}
End for 

COPY ARRAY:C226($firstname; aTeamLeader)
COPY ARRAY:C226($aPersonID; aTeamLdrID)
If ($ReturnBlob)
	VARIABLE TO BLOB:C532(aTeamLeader; $Return_blb; *)
	VARIABLE TO BLOB:C532(aTeamLdrID; $Return_blb; *)
End if 
//Build arrays for team members
QUERY:C277([Personnel:42]; [Personnel:42]Job Code:8<=3; *)
QUERY:C277([Personnel:42];  | ; [Personnel:42]Job Code:8=7; *)
QUERY:C277([Personnel:42];  | ; [Personnel:42]Job Code:8=6)
QUERY:C277([Personnel:42];  & ; [Personnel:42]Active:11=True:C214)
If ($Agency#"")
	If ($Agency="Mass. Highway Dept.")
		QUERY SELECTION:C341([Personnel:42]; [Personnel:42]Employer:9=$Agency; *)
		QUERY SELECTION:C341([Personnel:42];  | ; [Personnel:42]Employer:9="MHD@")
	Else 
		QUERY SELECTION:C341([Personnel:42]; [Personnel:42]Employer:9=$Agency)
	End if 
	
End if 
ORDER BY:C49([Personnel:42]; [Personnel:42]Last Name:5; [Personnel:42]First Name:3; [Personnel:42]Middle Name:4)
SELECTION TO ARRAY:C260([Personnel:42]First Name:3; $firstname; [Personnel:42]Middle Name:4; $midname; [Personnel:42]Last Name:5; $lastname; [Personnel:42]Person ID:1; $aPersonID)
If ($Agency="Mass. Highway Dept.")
	SELECTION TO ARRAY:C260([Personnel:42]Division No:7; $aDivNo)
	ARRAY TEXT:C222($aSpecialSort; Records in selection:C76([Personnel:42]))  // **Replaced old _ o _ARRAY STRING length 80
	C_TEXT:C284($currdistr)  // **Replaced old C_STRING length 2
	$currDistr:=Substring:C12([Bridge MHD NBIS:1]Item2:60; 2)
	For ($i; 1; Records in selection:C76([Personnel:42]))
		If (Substring:C12($aDivNo{$i}; 4)=$currDistr)
			$aSpecialSort{$i}:="0"+$lastname{$i}+$firstname{$i}
		Else 
			$aSpecialSort{$i}:="1"+$lastname{$i}+$firstname{$i}
		End if 
	End for 
	SORT ARRAY:C229($aSpecialSort; $firstname; $midname; $lastname; $aPersonID)
End if 

For ($i; 1; Records in selection:C76([Personnel:42]))
	//Concatenate the names.  
	If ($midname{$i}#"")
		$firstname{$i}:=$firstname{$i}+" "+$midname{$i}
	End if 
	$firstname{$i}:=$firstname{$i}+" "+$lastname{$i}
End for 

COPY ARRAY:C226($firstname; aTeamMbr)
COPY ARRAY:C226($aPersonID; aTeamMbrID)
If ($ReturnBlob)
	VARIABLE TO BLOB:C532(aTeamMbr; $Return_blb; *)
	VARIABLE TO BLOB:C532(aTeamMbrID; $Return_blb; *)
	$0:=$Return_blb
	SET BLOB SIZE:C606($Return_blb; 0)
End if 

//new for Tunnels
ARRAY TEXT:C222(Insp_DIE_atxt; 0)  //District insp engr
ARRAY LONGINT:C221(Insp_DIE_aL; 0)
ARRAY TEXT:C222(Insp_DTIE_atxt; 0)  //Distr Tunnel insp engr
ARRAY LONGINT:C221(Insp_DTIE_aL; 0)

GRP_GetMembersOfGrps(->Insp_DTIE_aL; ->Insp_DTIE_atxt; "@"; "TunnelInspEng")

GRP_GetMembersOfGrps(->Insp_DIE_aL; ->Insp_DIE_atxt; "@"; "TunnelEngineer")

ARRAY TEXT:C222(TnlInspPrjMgr_atxt; 0)
ARRAY INTEGER:C220(TnlInspPrjMgrID_aL; 0)

If ($Agency#"")
	If ($Agency="Mass. Highway Dept.")
	Else 
		C_TEXT:C284($SQL_txt)
		$SQL_txt:="Select Concat(concat([Personnel].[First Name],' '), [Personnel].[Last Name]), [Personnel].[Person ID] "
		$SQL_txt:=$SQL_txt+" from [Personnel] "
		$SQL_txt:=$SQL_txt+" where [Personnel].[Employer] = '"+$Agency+"' "
		$SQL_txt:=$SQL_txt+" AND [Personnel].[Person ID] IN ( Select [PERS_GroupMembers].[PersonID_I] from [PERS_GroupMembers], [PERS_Groups] "
		$SQL_txt:=$SQL_txt+" where [PERS_GroupMembers].[GroupID_I] = [PERS_Groups].PERS_GroupID_I and "
		$SQL_txt:=$SQL_txt+" ([PERS_Groups].[PERS_GroupName_s]='ConsInspProjMgrs' "
		
		Case of 
			: (Current form table:C627=->[Inspections:27])
				$SQL_txt:=$SQL_txt+" or [PERS_Groups].[PERS_GroupName_s]='BIN_InspProjMgrs' "
				
			: (Current form table:C627=->[TIN_Inspections:184])
				$SQL_txt:=$SQL_txt+" or [PERS_Groups].[PERS_GroupName_s]='TIN_InspProjMgrs' "
		End case 
		
		$SQL_txt:=$SQL_txt+" ) ) "
		$SQL_txt:=$SQL_txt+" order by [Personnel].[Last Name] ASC "
		$SQL_txt:=$SQL_txt+"into :TnlInspPrjMgr_atxt,  :TnlInspPrjMgrID_aL ;"
		Begin SQL
			execute immediate :$SQL_txt
		End SQL
		
	End if 
	REDUCE SELECTION:C351([Personnel:42]; 0)
	If (Not:C34($PersRO_b))
		READ WRITE:C146([Personnel:42])
	End if 
End if 