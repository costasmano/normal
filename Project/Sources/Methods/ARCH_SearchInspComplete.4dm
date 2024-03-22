//%attributes = {"invisible":true}
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 12/30/10, 13:43:29
	// ----------------------------------------------------
	// Method: ARCH_SearchInspComplete
	// Description
	//  ` Search the unsent entries in Activity log for InspComplete=Y
	//  ` and email to DBIE the list that has not been downloaded to the District server.
	// 
	// Parameters
	// ----------------------------------------------------
	
	Mods_2010_12
	Mods_2011_06  // CJ Miller`06/20/11, 10:28:54      ` Type all local variables for v11
End if 
READ ONLY:C145([Activity Log:59])
READ ONLY:C145([Owners of Data:62])
READ ONLY:C145([Personnel:42])
READ ONLY:C145([Bridge MHD NBIS:1])
READ ONLY:C145([PERS_GroupMembers:110])
READ ONLY:C145([PERS_Groups:109])
C_TEXT:C284($Distr_txt)
QUERY:C277([Activity Log:59]; [Activity Log:59]Status:9=0)
ORDER BY:C49([Activity Log:59]; [Activity Log:59]RefID:28; <)
REDUCE SELECTION:C351([Activity Log:59]; 10000)
QUERY SELECTION:C341([Activity Log:59]; [Activity Log:59]Destination:1="District@")
QUERY SELECTION:C341([Activity Log:59]; [Activity Log:59]Destination:1#"District 6@")
QUERY SELECTION:C341([Activity Log:59]; [Activity Log:59]FileID Local:24=Table:C252(->[Inspections:27]))
QUERY SELECTION:C341([Activity Log:59]; [Activity Log:59]Activity Type:3="GRP")
FIRST RECORD:C50([Activity Log:59])
CREATE EMPTY SET:C140([Activity Log:59]; "ACTLOGNOTDOWNLOADED")
SET CURSOR:C469(128)
While (Not:C34(End selection:C36([Activity Log:59])))
	QUERY:C277([Owners of Data:62]; [Owners of Data:62]RefID:1=[Activity Log:59]RefID:28)
	$Distr_txt:=Substring:C12([Activity Log:59]Destination:1; Length:C16("District x"); 1)
	QUERY SELECTION:C341([Owners of Data:62]; [Owners of Data:62]Owner Name:2="District"+$Distr_txt+" Server")
	If (Records in selection:C76([Owners of Data:62])=0)
		ADD TO SET:C119([Activity Log:59]; "ACTLOGNOTDOWNLOADED")
	End if 
	NEXT RECORD:C51([Activity Log:59])
End while 
SET CURSOR:C469(0)

If (Records in set:C195("ACTLOGNOTDOWNLOADED")>0)
	USE SET:C118("ACTLOGNOTDOWNLOADED")
	
	C_TEXT:C284($FieldNumber_txt; $Data_txt)
	$FieldNumber_txt:="["+String:C10(Field:C253(->[Inspections:27]InspComplete:168))+"] : "+Field name:C257(->[Inspections:27]InspComplete:168)+"="
	FIRST RECORD:C50([Activity Log:59])
	C_LONGINT:C283($NumRecs; $i; $InspID_L)
	$NumRecs:=Records in selection:C76([Activity Log:59])
	C_BOOLEAN:C305($InspComplete_b)
	C_TEXT:C284($Bin_s)
	SET AUTOMATIC RELATIONS:C310(False:C215; False:C215)
	ARRAY TEXT:C222($DBIEEmails_atxt; 0)
	ARRAY TEXT:C222(ComplInspType_atxt; 0)
	ARRAY TEXT:C222(ComplInspBIN_atxt; 0)
	ARRAY TEXT:C222(ComplInspBDEPT_atxt; 0)
	ARRAY TEXT:C222(ComplInspDate_atxt; 0)
	ARRAY TEXT:C222(ComplInspItem2_atxt; 0)
	ARRAY TEXT:C222(ComplInspResp_atxt; 0)
	ARRAY TEXT:C222(ComplInspAgency_atxt; 0)
	ARRAY LONGINT:C221($CompleteINSPIDs_aL; 0)
	
	C_TEXT:C284($DefaultEmail_txt; $DBIEEmail_txt)
	$DefaultEmail_txt:=ut_GetSysParameter("MAIL_BRGSTATFROM")
	For ($i; 1; $NumRecs)
		$Data_txt:=fGrpBlob2Text([Activity Log:59]Data:10)
		If (Position:C15($FieldNumber_txt; $Data_txt)>0)
			$InspComplete_b:=(Substring:C12($Data_txt; (Position:C15($FieldNumber_txt; $Data_txt)+Length:C16($FieldNumber_txt)); 1)="Y")
			If ($InspComplete_b)
				$InspID_L:=Num:C11([Activity Log:59]Local ID:15)
				$Bin_s:=[Activity Log:59]Parent ID:14
				QUERY:C277([Inspections:27]; [Inspections:27]InspID:2=$InspID_L)
				If (Records in selection:C76([Inspections:27])=1)
					FIRST RECORD:C50([Inspections:27])
					QUERY:C277([Bridge MHD NBIS:1]; [Bridge MHD NBIS:1]BIN:3=[Inspections:27]BIN:1)
					QUERY:C277([Personnel:42]; [Personnel:42]Person ID:1=[Inspections:27]DBrInspEngr:3)
					QUERY:C277([Inspection Type:31]; [Inspection Type:31]Code:1=[Inspections:27]Insp Type:6)
					$DBIEEmail_txt:=$DefaultEmail_txt
					
					If (Records in selection:C76([Personnel:42])=1)
						If ([Personnel:42]EmailAddress_s:14#"")
							$DBIEEmail_txt:=[Personnel:42]EmailAddress_s:14
						End if 
					End if 
					APPEND TO ARRAY:C911($DBIEEmails_atxt; $DBIEEmail_txt)
					APPEND TO ARRAY:C911($CompleteINSPIDs_aL; $InspID_L)
					APPEND TO ARRAY:C911(ComplInspType_atxt; [Inspection Type:31]Description:2)
					APPEND TO ARRAY:C911(ComplInspBIN_atxt; [Inspections:27]BIN:1)
					APPEND TO ARRAY:C911(ComplInspBDEPT_atxt; [Bridge MHD NBIS:1]BDEPT:1)
					APPEND TO ARRAY:C911(ComplInspItem2_atxt; [Bridge MHD NBIS:1]Item2:60)
					APPEND TO ARRAY:C911(ComplInspResp_atxt; [Bridge MHD NBIS:1]InspResp:173)
					APPEND TO ARRAY:C911(ComplInspDate_atxt; String:C10([Inspections:27]Insp Date:78))
					APPEND TO ARRAY:C911(ComplInspAgency_atxt; [Inspections:27]Agency:156)
				End if 
				
			End if 
			
		End if 
		
		NEXT RECORD:C51([Activity Log:59])
	End for 
	
	If (Size of array:C274($CompleteINSPIDs_aL)>0)
		
		MULTI SORT ARRAY:C718($DBIEEmails_atxt; >; ComplInspBDEPT_atxt; >; $CompleteINSPIDs_aL; ComplInspType_atxt; ComplInspBIN_atxt; ComplInspDate_atxt; ComplInspItem2_atxt; ComplInspResp_atxt; ComplInspAgency_atxt)
		C_TEXT:C284($EmailBody_txt; $CurrEmailAddr_txt; $FromAddr_txt; $EmailHeader_txt; $EMaiLineTmpl_txt; $EMaiLine_txt; $EmailSubj_txt)
		$EMaiLineTmpl_txt:=Char:C90(13)+"<!--#4DVAR ComplInspBDEPT_atxt{Comp_loop_L}-->"
		$EMaiLineTmpl_txt:=$EMaiLineTmpl_txt+" (<!--#4DVAR ComplInspBIN_atxt{Comp_loop_L}-->)"
		$EMaiLineTmpl_txt:=$EMaiLineTmpl_txt+"  District: <!--#4DVAR ComplInspItem2_atxt{Comp_loop_L}-->"
		$EMaiLineTmpl_txt:=$EMaiLineTmpl_txt+"  Insp.Resp: <!--#4DVAR ComplInspResp_atxt{Comp_loop_L}-->"
		$EMaiLineTmpl_txt:=$EMaiLineTmpl_txt+"  Done By: <!--#4DVAR ComplInspAgency_atxt{Comp_loop_L}-->"
		$EMaiLineTmpl_txt:=$EMaiLineTmpl_txt+"  Inspection Type: <!--#4DVAR ComplInspType_atxt{Comp_loop_L}-->"
		$EMaiLineTmpl_txt:=$EMaiLineTmpl_txt+"  Inspection Date: <!--#4DVAR ComplInspDate_atxt{Comp_loop_L}-->"
		
		$EmailHeader_txt:="The following Inspections that are marked as completed have not been downloaded y"+"et :"+Char:C90(13)
		C_LONGINT:C283(Comp_loop_L)
		$EmailBody_txt:=$EmailHeader_txt
		Comp_loop_L:=1
		PROCESS 4D TAGS:C816($EMaiLineTmpl_txt; $EMaiLine_txt)
		$EmailBody_txt:=$EmailHeader_txt+$EMaiLine_txt
		$CurrEmailAddr_txt:=$DBIEEmails_atxt{Comp_loop_L}
		
		QUERY:C277([PERS_Groups:109]; [PERS_Groups:109]PERS_GroupName_s:2="AssistantDBIE")
		If (Records in selection:C76([PERS_Groups:109])=1)
			FIRST RECORD:C50([PERS_Groups:109])
			QUERY:C277([PERS_GroupMembers:110]; [PERS_GroupMembers:110]GroupID_I:1=[PERS_Groups:109]PERS_GroupID_I:1)
			If (Records in selection:C76([PERS_GroupMembers:110])>0)
				ARRAY INTEGER:C220($AssistIDs_ai; Records in selection:C76([PERS_GroupMembers:110]))
				SELECTION TO ARRAY:C260([PERS_GroupMembers:110]PersonID_I:2; $AssistIDs_ai)
				QUERY WITH ARRAY:C644([Personnel:42]Person ID:1; $AssistIDs_ai)
				QUERY SELECTION:C341([Personnel:42]; [Personnel:42]Division No:7=("044"+ComplInspItem2_atxt{Comp_loop_L}))
				QUERY SELECTION:C341([Personnel:42]; [Personnel:42]EmailAddress_s:14#"")
				If (Records in selection:C76([Personnel:42])>0)
					ORDER BY:C49([Personnel:42]; [Personnel:42]Last Name:5)
					ARRAY TEXT:C222($AssistEmails_atxt; Records in selection:C76([Personnel:42]))
					SELECTION TO ARRAY:C260([Personnel:42]EmailAddress_s:14; $AssistEmails_atxt)
					C_LONGINT:C283($loop_L)
					For ($loop_L; 1; Size of array:C274($AssistEmails_atxt))
						$CurrEmailAddr_txt:=$CurrEmailAddr_txt+", "+$AssistEmails_atxt{$loop_L}
					End for 
				End if 
			End if 
		End if 
		
		$FromAddr_txt:="Do Not Reply to <donotreply@state.ma.us>"
		$EmailSubj_txt:="Consultant Inspection Completed Notification"
		C_BOOLEAN:C305(<>SHOWERRORS)
		<>SHOWERRORS:=False:C215
		For (Comp_loop_L; 2; Size of array:C274($DBIEEmails_atxt))
			If ($DBIEEmails_atxt{Comp_loop_L}=$CurrEmailAddr_txt)
			Else 
				//mail what we have up to now
				SET TEXT TO PASTEBOARD:C523($EmailBody_txt)
				ut_SendEmail($CurrEmailAddr_txt; $FromAddr_txt; $DefaultEmail_txt; ""; $EmailBody_txt; $EmailSubj_txt)
				$CurrEmailAddr_txt:=$DBIEEmails_atxt{Comp_loop_L}
				QUERY:C277([PERS_Groups:109]; [PERS_Groups:109]PERS_GroupName_s:2="AssistantDBIE")
				If (Records in selection:C76([PERS_Groups:109])=1)
					FIRST RECORD:C50([PERS_Groups:109])
					QUERY:C277([PERS_GroupMembers:110]; [PERS_GroupMembers:110]GroupID_I:1=[PERS_Groups:109]PERS_GroupID_I:1)
					If (Records in selection:C76([PERS_GroupMembers:110])>0)
						ARRAY INTEGER:C220($AssistIDs_ai; Records in selection:C76([PERS_GroupMembers:110]))
						SELECTION TO ARRAY:C260([PERS_GroupMembers:110]PersonID_I:2; $AssistIDs_ai)
						QUERY WITH ARRAY:C644([Personnel:42]Person ID:1; $AssistIDs_ai)
						QUERY SELECTION:C341([Personnel:42]; [Personnel:42]Division No:7=("044"+ComplInspItem2_atxt{Comp_loop_L}))
						QUERY SELECTION:C341([Personnel:42]; [Personnel:42]EmailAddress_s:14#"")
						If (Records in selection:C76([Personnel:42])>0)
							ORDER BY:C49([Personnel:42]; [Personnel:42]Last Name:5)
							ARRAY TEXT:C222($AssistEmails_atxt; Records in selection:C76([Personnel:42]))
							SELECTION TO ARRAY:C260([Personnel:42]EmailAddress_s:14; $AssistEmails_atxt)
							C_LONGINT:C283($loop_L)
							For ($loop_L; 1; Size of array:C274($AssistEmails_atxt))
								$CurrEmailAddr_txt:=$CurrEmailAddr_txt+", "+$AssistEmails_atxt{$loop_L}
							End for 
							
						End if 
						
					End if 
					
				End if 
				$EmailBody_txt:=$EmailHeader_txt
			End if 
			PROCESS 4D TAGS:C816($EMaiLineTmpl_txt; $EMaiLine_txt)
			$EmailBody_txt:=$EmailBody_txt+$EMaiLine_txt
		End for 
		SET TEXT TO PASTEBOARD:C523($EmailBody_txt)
		ut_SendEmail($CurrEmailAddr_txt; $FromAddr_txt; $DefaultEmail_txt; ""; $EmailBody_txt; $EmailSubj_txt)
		$EmailBody_txt:=""
		
	End if 
	
	$Data_txt:=""
	ARRAY TEXT:C222($DBIEEmails_atxt; 0)
	ARRAY TEXT:C222(ComplInspType_atxt; 0)
	ARRAY TEXT:C222(ComplInspBIN_atxt; 0)
	ARRAY TEXT:C222(ComplInspBDEPT_atxt; 0)
	ARRAY TEXT:C222(ComplInspDate_atxt; 0)
	ARRAY TEXT:C222(ComplInspItem2_atxt; 0)
	ARRAY TEXT:C222(ComplInspResp_atxt; 0)
	ARRAY TEXT:C222(ComplInspAgency_atxt; 0)
	ARRAY LONGINT:C221($CompleteINSPIDs_aL; 0)
	
	
End if 

CLEAR SET:C117("ACTLOGNOTDOWNLOADED")

READ WRITE:C146([Activity Log:59])
READ WRITE:C146([Owners of Data:62])
READ WRITE:C146([Personnel:42])
READ WRITE:C146([Bridge MHD NBIS:1])
READ WRITE:C146([PERS_GroupMembers:110])
READ WRITE:C146([PERS_Groups:109])
