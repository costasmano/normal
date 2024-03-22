//%attributes = {"invisible":true}

//----------------------------------------------------
//User name (OS): Charles Miller
//Date and time: 04/03/14, 12:17:09
//----------------------------------------------------
//Method: ut_CreateNewLightingRecords
//Description
//Description
//This method will import from a tab delimited document
//first name/ initial
//last name
// count in our personnel table
//mhd first name
//number with following def (comma delimited)
//Name
//Company
//Roles (comma delinited)
//Roles are as follows:
//  `3 team member
//  `2 team leader
//  `1 project manager
// Parameters
// ----------------------------------------------------
If (False:C215)
	// 
	//Modified by: Charles Miller (4/3/14 12:17:11)
	
End if 
CONFIRM:C162("Are You sure you wish to Import Lighting Personnel")
If (OK=1)
	vsforward:=""
	
	ut_CNLPersonnelGroupRecords
	
	
	
	C_TEXT:C284($GroupName_txt; $GroupName1_txt; $ProcessedLine_txt)
	C_LONGINT:C283($NewID_L; $C0)
	C_DATE:C307($BlankDate_d)
	C_TEXT:C284($P1; $P2; $P3; $P4; $N1; $N2; $NewUserPW_txt)
	
	$GroupName_txt:="LSS %"
	
	$GroupName1_txt:="Mass DOT Rep"
	ON ERR CALL:C155("SQL_Error")
	ARRAY LONGINT:C221($GroupIDS_aL; 0)
	ARRAY TEXT:C222($GroupName_atxt; 0)
	
	Begin SQL
		select
		[PERS_Groups].[PERS_GroupID_I],
		[PERS_Groups].[PERS_GroupName_s]
		from 
		[PERS_Groups]
		where
		[PERS_Groups].[PERS_GroupName_s] = :$GroupName1_txt
		or
		[PERS_Groups].[PERS_GroupName_s] like :$GroupName_txt
		into
		:$GroupIDS_aL,
		:$GroupName_atxt;
	End SQL
	C_BOOLEAN:C305($Complete_b)
	C_LONGINT:C283($UserArrayPosition_L)
	C_TIME:C306($Doc_tm)
	C_TEXT:C284($Line_txt; $Name_txt; $FirstName_txt; $ProcessedLine_txt)
	$Doc_tm:=Open document:C264(""; "txt"; Read mode:K24:5)
	READ WRITE:C146([Personnel:42])
	READ WRITE:C146([PERS_GroupMembers:110])
	//TEXT TO BLOB(NotFoundRefPersonName_atxt{$Loop_L}+Char(Tab );$Report_blb;Mac text without length ;*)
	//
	//TEXT TO BLOB(NotFoundRefPersonCompany_atxt{$Loop_L}+Char(Tab );$Report_blb;Mac text without length ;*)
	//TEXT TO BLOB($Roles_txt+Char(Carriage return );$Report_blb;Mac text without length ;*)
	
	C_BLOB:C604($Duplicates_blb)
	SET BLOB SIZE:C606($Duplicates_blb; 0)
	C_BLOB:C604($Report_blb)
	SET BLOB SIZE:C606($Report_blb; 0)
	ARRAY TEXT:C222($ProcessedNames_atxt; 0)
	ARRAY TEXT:C222($ProcessedCompany_atxt; 0)
	ARRAY TEXT:C222($ProcessedAll_atxt; 0)
	START TRANSACTION:C239
	C_LONGINT:C283($Pos_L; $GroupMemberRecordCount_L; $Size_L)
	Repeat 
		ARRAY TEXT:C222($TextParts_atxt; 0)
		ARRAY TEXT:C222($Roles_atxt; 0)
		ARRAY TEXT:C222($Names_atxt; 0)
		
		RECEIVE PACKET:C104($Doc_tm; $Line_txt; Char:C90(Carriage return:K15:38))
		If (OK=1)
			ARRAY TEXT:C222($TextParts_atxt; 0)
			$Line_txt:=Replace string:C233($Line_txt; Char:C90(Line feed:K15:40); "")
			$Line_txt:=Replace string:C233($Line_txt; Char:C90(Double quote:K15:41); "")
			ut_TextToArray($Line_txt; ->$TextParts_atxt; Char:C90(Tab:K15:37))  //; True)//to be ver
			ut_TextToArray($TextParts_atxt{3}; ->$Roles_atxt; ",")
			ut_TextToArray($TextParts_atxt{1}; ->$Names_atxt; " ")
			
			$FirstName_txt:=$Names_atxt{1}
			//$Name_txt:=$TextParts_atxt{1}+" "+$Names_atxt{2}
			C_LONGINT:C283($Size_L)
			
			
			
			QUERY:C277([Personnel:42]; [Personnel:42]Last Name:5=$Names_atxt{2}; *)
			QUERY:C277([Personnel:42];  & ; [Personnel:42]First Name:3=$FirstName_txt; *)
			QUERY:C277([Personnel:42];  & ; [Personnel:42]Employer:9=$TextParts_atxt{2})
			
			C_BOOLEAN:C305($CreatePersonnelRecord_b)
			$CreatePersonnelRecord_b:=True:C214
			C_TEXT:C284($All_txt)
			C_LONGINT:C283($Position_L)
			
			$All_txt:=$FirstName_txt+$Names_atxt{2}+$TextParts_atxt{2}
			$Position_L:=Find in array:C230($ProcessedAll_atxt; $All_txt)
			If ($Position_L>0)
				
				TEXT TO BLOB:C554($FirstName_txt+Char:C90(Tab:K15:37)+$Names_atxt{2}+Char:C90(Tab:K15:37)+$TextParts_atxt{2}+Char:C90(Carriage return:K15:38); $Duplicates_blb; Mac text without length:K22:10; *)
				
				$CreatePersonnelRecord_b:=False:C215
			Else 
				
			End if 
			Case of 
				: (Records in selection:C76([Personnel:42])=0) & ($CreatePersonnelRecord_b)
					InitChangeStack(1)
					CREATE RECORD:C68([Personnel:42])
					Inc_Sequence("Personnel"; ->[Personnel:42]Person ID:1)
					[Personnel:42]Last Name:5:=$Names_atxt{2}
					[Personnel:42]First Name:3:=$FirstName_txt
					[Personnel:42]Employer:9:=$TextParts_atxt{2}
					[Personnel:42]Active:11:=True:C214
					[Personnel:42]UserID_4D:12:=0
					LogNewRecord(->[Personnel:42]Person ID:1; ->[Personnel:42]Person ID:1; ->[Personnel:42]Person ID:1; 4; "Personnel")
					PushChange(1; ->[Personnel:42]Last Name:5)
					PushChange(1; ->[Personnel:42]First Name:3)
					PushChange(1; ->[Personnel:42]Employer:9)
					PushChange(1; ->[Personnel:42]UserID_4D:12)
					PushChange(1; ->[Personnel:42]Active:11)
					FlushGrpChgs(1; ->[Personnel:42]Person ID:1; ->[Personnel:42]Person ID:1; ->[Personnel:42]Person ID:1; 1)
					SAVE RECORD:C53([Personnel:42])
					$ProcessedLine_txt:="Created personnel record for "+$FirstName_txt+" "+$Names_atxt{2}+Char:C90(Tab:K15:37)+$TextParts_atxt{2}+Char:C90(Carriage return:K15:38)
					
				: (Records in selection:C76([Personnel:42])=1) & ($CreatePersonnelRecord_b)
					$ProcessedLine_txt:="personnel record for "+$FirstName_txt+" "+$Names_atxt{2}+Char:C90(Tab:K15:37)+$TextParts_atxt{2}+Char:C90(Carriage return:K15:38)
					
				Else 
			End case 
			
			If (Find in array:C230($Roles_atxt; "1")>0)  //project manager
				$Pos_L:=Find in array:C230($GroupName_atxt; "LSS Project Manager")
				SET QUERY DESTINATION:C396(Into variable:K19:4; $GroupMemberRecordCount_L)
				QUERY:C277([PERS_GroupMembers:110]; [PERS_GroupMembers:110]GroupID_I:1=$GroupIDS_aL{$Pos_L}; *)
				QUERY:C277([PERS_GroupMembers:110];  & [PERS_GroupMembers:110]PersonID_I:2=[Personnel:42]Person ID:1)
				SET QUERY DESTINATION:C396(Into current selection:K19:1)
				If ($GroupMemberRecordCount_L=0)
					$ProcessedLine_txt:=$ProcessedLine_txt+"Group LSS Project Manager created "+Char:C90(Tab:K15:37)
					
					CREATE RECORD:C68([PERS_GroupMembers:110])
					[PERS_GroupMembers:110]GroupID_I:1:=$GroupIDS_aL{$Pos_L}
					[PERS_GroupMembers:110]PersonID_I:2:=[Personnel:42]Person ID:1
					
					LogNewRecord(->[PERS_Groups:109]PERS_GroupID_I:1; ->[PERS_GroupMembers:110]GroupID_I:1; ->[PERS_GroupMembers:110]PersonID_I:2; 3; ""; ->[Personnel:42]Person ID:1)
					SAVE RECORD:C53([PERS_GroupMembers:110])
				Else 
					$ProcessedLine_txt:=$ProcessedLine_txt+"LSS Project Manager Group previously created"+Char:C90(Tab:K15:37)
				End if 
			End if 
			If (Find in array:C230($Roles_atxt; "2")>0)  //team leader
				$Pos_L:=Find in array:C230($GroupName_atxt; "LSS Team Leader")
				SET QUERY DESTINATION:C396(Into variable:K19:4; $GroupMemberRecordCount_L)
				QUERY:C277([PERS_GroupMembers:110]; [PERS_GroupMembers:110]GroupID_I:1=$GroupIDS_aL{$Pos_L}; *)
				QUERY:C277([PERS_GroupMembers:110];  & [PERS_GroupMembers:110]PersonID_I:2=[Personnel:42]Person ID:1)
				SET QUERY DESTINATION:C396(Into current selection:K19:1)
				If ($GroupMemberRecordCount_L=0)
					$ProcessedLine_txt:=$ProcessedLine_txt+"Group LSS Team Leader created "+Char:C90(Tab:K15:37)
					
					CREATE RECORD:C68([PERS_GroupMembers:110])
					[PERS_GroupMembers:110]GroupID_I:1:=$GroupIDS_aL{$Pos_L}
					[PERS_GroupMembers:110]PersonID_I:2:=[Personnel:42]Person ID:1
					LogNewRecord(->[PERS_Groups:109]PERS_GroupID_I:1; ->[PERS_GroupMembers:110]GroupID_I:1; ->[PERS_GroupMembers:110]PersonID_I:2; 3; ""; ->[Personnel:42]Person ID:1)
					SAVE RECORD:C53([PERS_GroupMembers:110])
				Else 
					$ProcessedLine_txt:=$ProcessedLine_txt+"LSS Team Leader Group previously created"+Char:C90(Tab:K15:37)
				End if 
			End if 
			If (Find in array:C230($Roles_atxt; "3")>0)  //team member
				$Pos_L:=Find in array:C230($GroupName_atxt; "LSS Team Member")
				SET QUERY DESTINATION:C396(Into variable:K19:4; $GroupMemberRecordCount_L)
				QUERY:C277([PERS_GroupMembers:110]; [PERS_GroupMembers:110]GroupID_I:1=$GroupIDS_aL{$Pos_L}; *)
				QUERY:C277([PERS_GroupMembers:110];  & [PERS_GroupMembers:110]PersonID_I:2=[Personnel:42]Person ID:1)
				SET QUERY DESTINATION:C396(Into current selection:K19:1)
				If ($GroupMemberRecordCount_L=0)
					
					$ProcessedLine_txt:=$ProcessedLine_txt+"Group LSS Team Member created "+Char:C90(Tab:K15:37)
					CREATE RECORD:C68([PERS_GroupMembers:110])
					[PERS_GroupMembers:110]GroupID_I:1:=$GroupIDS_aL{$Pos_L}
					[PERS_GroupMembers:110]PersonID_I:2:=[Personnel:42]Person ID:1
					LogNewRecord(->[PERS_Groups:109]PERS_GroupID_I:1; ->[PERS_GroupMembers:110]GroupID_I:1; ->[PERS_GroupMembers:110]PersonID_I:2; 3; ""; ->[Personnel:42]Person ID:1)
					SAVE RECORD:C53([PERS_GroupMembers:110])
				Else 
					$ProcessedLine_txt:=$ProcessedLine_txt+"LSS Team Member Group previously created"+Char:C90(Tab:K15:37)
				End if 
			End if 
			If (Find in array:C230($Roles_atxt; "4")>0)  //mass dot employees
				$Pos_L:=Find in array:C230($GroupName_atxt; "Mass DOT Rep")
				SET QUERY DESTINATION:C396(Into variable:K19:4; $GroupMemberRecordCount_L)
				QUERY:C277([PERS_GroupMembers:110]; [PERS_GroupMembers:110]GroupID_I:1=$GroupIDS_aL{$Pos_L}; *)
				QUERY:C277([PERS_GroupMembers:110];  & [PERS_GroupMembers:110]PersonID_I:2=[Personnel:42]Person ID:1)
				SET QUERY DESTINATION:C396(Into current selection:K19:1)
				If ($GroupMemberRecordCount_L=0)
					$ProcessedLine_txt:=$ProcessedLine_txt+"Group Mass DOT Rep created "+Char:C90(Tab:K15:37)
					
					CREATE RECORD:C68([PERS_GroupMembers:110])
					[PERS_GroupMembers:110]GroupID_I:1:=$GroupIDS_aL{$Pos_L}
					[PERS_GroupMembers:110]PersonID_I:2:=[Personnel:42]Person ID:1
					LogNewRecord(->[PERS_Groups:109]PERS_GroupID_I:1; ->[PERS_GroupMembers:110]GroupID_I:1; ->[PERS_GroupMembers:110]PersonID_I:2; 3; ""; ->[Personnel:42]Person ID:1)
					SAVE RECORD:C53([PERS_GroupMembers:110])
				Else 
					$ProcessedLine_txt:=$ProcessedLine_txt+"LSS Mass DOT Rep Group previously created"+Char:C90(Tab:K15:37)
				End if 
			End if 
			$ProcessedLine_txt:=$ProcessedLine_txt+Char:C90(Carriage return:K15:38)
			TEXT TO BLOB:C554($ProcessedLine_txt; $Report_blb; Mac text without length:K22:10; *)
			$ProcessedLine_txt:=""
		End if 
		
	Until (OK=0)
	//ARRAY TEXT($ProcessedNames_atxt;0)
	//ARRAY LONGINT($ProcessedCount_aL;0)
	//ARRAY BOOLEAN($IsMassDOT_ab;0)
	//ARRAY LONGINT($CreatedPersonnelRecordCount_aL;0)
	//ARRAY LONGINT($FirstPersonnelKey_aL;0)
	C_TEXT:C284($Path_txt; $DocName_txt)
	$Path_txt:=Select folder:C670("Select Folder to store Lighting Documents"; "")
	$DocName_txt:="CreatedPersonnel_"+Substring:C12(ut_ReturnTimeStampFromDate(Current date:C33); 1; 12)+".txt"
	$Doc_tm:=Create document:C266($Path_txt+$DocName_txt)
	CLOSE DOCUMENT:C267($Doc_tm)
	BLOB TO DOCUMENT:C526(Document; $Report_blb)
	If (BLOB size:C605($Duplicates_blb)>0)
		$Doc_tm:=Create document:C266("")
		$DocName_txt:="CreatedErrors_"+Substring:C12(ut_ReturnTimeStampFromDate(Current date:C33); 1; 12)+".txt"
		
		CLOSE DOCUMENT:C267($Doc_tm)
		BLOB TO DOCUMENT:C526(Document; $Duplicates_blb)
		
	End if 
End if 

VALIDATE TRANSACTION:C240

CANCEL TRANSACTION:C241
//End ut_CreateNewLightingRecords

