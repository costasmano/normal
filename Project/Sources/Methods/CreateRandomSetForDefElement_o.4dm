//%attributes = {"invisible":true}
If (False:C215)
	//CreateRandomSetForDefElement_o 
	//SJH  4/30/2004
	//copied and modified from CreateRandomSet
	//purpose: create a random set of bridges  from the Search Def Element dialog
	
	Mods_2004_CM03
	Mods_2004_CM04
	Mods_2004_CM12
	// Modified by: costasmanousakis-(Designer)-(9/10/05 12:24:46) 
	Mods_2005_CM16
	Mods_2005_CM17
	Mods_2011_06  // CJ Miller`06/14/11, 10:40:14      ` Type all local variables for v11
	// Modified by: Costas Manousakis-(Designer)-(1/13/12 16:41:32)
	Mods_2012_01
	//  `Exclude Freeze Thaw inspections in the search. Elements do not follow normal coding
	// Modified by: Costas Manousakis-(Designer)-(6/7/17 16:05:40)
	Mods_2017_06_bug
	//  `Account for other routine type, Spec memb, Fract crit, and damage inspections besides the
	//  // highway ones.
	//  // use method ELMSRCH_ElementFilter
	// Modified by: Costas Manousakis-(Designer)-(2021-12-23T00:00:00 18:30:33)
	Mods_2021_12_bug
	//  `Instead of looping through records use arrays to filter inspections.
	//  `don't go trhough filtering again, unless needed. only time it needs to be done is
	//  `if the condition on the status of the report is changed (level of approval)
End if 

C_TEXT:C284($s)  //<--- Added// Command Replaced was o _C_STRING length was 30
If ((vAddTo=True:C214) & (Records in set:C195("Random Set")=0))
	CREATE SET:C116([Bridge MHD NBIS:1]; "Random Set")
End if 
If ((Records in set:C195("TotalElmtsFound")=0))
	CREATE SET:C116([ElementsSafety:29]; "TotalElmtsFound")
End if 

OBJECT SET ENABLED:C1123(bFind; False:C215)  // Command Replaced was o _DISABLE BUTTON 

C_OBJECT:C1216(SRC_BridgeElemParams_o)
C_BOOLEAN:C305($ElementsFiltered)
$ElementsFiltered:=OB Get:C1224(SRC_BridgeElemParams_o; "ElementsFiltered"; Is boolean:K8:9)

C_LONGINT:C283($progressBar_L)
$progressBar_L:=Progress New

If (Not:C34($ElementsFiltered))
	
	Progress SET TITLE($progressBar_L; "Searching for Inspections")
	Progress SET BUTTON ENABLED($progressBar_L; False:C215)
	
	//SHORT_MESSAGE ("Searching…")
	If (vAddTo)
		USE NAMED SELECTION:C332("UserRegionA")
	Else 
		USE NAMED SELECTION:C332("StartSearch")
	End if 
	
	ARRAY TEXT:C222($asInspBIN; 0)  //Command Replaced was o_ARRAY string length was 5
	RELATE MANY SELECTION:C340([Inspections:27]BIN:1)
	Progress SET MESSAGE($progressBar_L; "Applying criteria..")
	QUERY SELECTION:C341([Inspections:27]; [Inspections:27]Insp Type:6#"FRZ")
	Case of 
		: (vbAnyCompleted)
			QUERY SELECTION:C341([Inspections:27]; [Inspections:27]InspComplete:168=True:C214)
		: (vbAnyApprvDBIE)
			QUERY SELECTION:C341([Inspections:27]; [Inspections:27]InspReviewed:12=BMS Approved)
		: (vInspApproved)
			QUERY SELECTION:C341([Inspections:27]; [Inspections:27]InspApproved:167=BMS Approved)
	End case 
	Progress SET MESSAGE($progressBar_L; "Sorting..")
	C_BOOLEAN:C305($useRecords_b)
	$useRecords_b:=False:C215
	ORDER BY:C49([Inspections:27]; [Inspections:27]BIN:1; >; [Inspections:27]Insp Date:78; <)
	If ($useRecords_b)
		CREATE SET:C116([Inspections:27]; "SetInspectionStart")
	End if 
	C_TEXT:C284($StartBIN)  //<--- Added// Command Replaced was o_C_STRING length was 3
	GOTO SELECTED RECORD:C245([Inspections:27]; 1)
	C_BOOLEAN:C305($RtnFound; $SpecFnd; $FrcFnd; $DamFnd)
	$RtnFound:=False:C215
	$SpecFnd:=False:C215
	$FrcFnd:=False:C215
	$DamFnd:=False:C215
	$StartBIN:=[Inspections:27]BIN:1
	$RtnFound:=(([Inspections:27]Insp Type:6="RT@") | ([Inspections:27]Insp Type:6="CUL")\
		 | ([Inspections:27]Insp Type:6="PED")\
		 | ([Inspections:27]Insp Type:6="RRR")\
		 | ([Inspections:27]Insp Type:6="RRA")\
		 | ([Inspections:27]Insp Type:6="RRC")\
		 | ([Inspections:27]Insp Type:6="TAL"))
	$SpecFnd:=([Inspections:27]Insp Type:6="CMI")\
		 | ([Inspections:27]Insp Type:6="RRS")\
		 | ([Inspections:27]Insp Type:6="TSP")\
		 | ([Inspections:27]Insp Type:6="TOV")
	$FrcFnd:=([Inspections:27]Insp Type:6="FCR")\
		 | ([Inspections:27]Insp Type:6="RRF")
	$DamFnd:=([Inspections:27]Insp Type:6="DAM")\
		 | ([Inspections:27]Insp Type:6="RRD")\
		 | ([Inspections:27]Insp Type:6="TDA")
	C_LONGINT:C283($i)
	Progress SET MESSAGE($progressBar_L; "Filtering inspections")
	Progress SET PROGRESS($progressBar_L; 0)
	If ($useRecords_b)
		For ($i; 2; Records in selection:C76([Inspections:27]))
			GOTO SELECTED RECORD:C245([Inspections:27]; $i)
			If ([Inspections:27]BIN:1=$StartBIN)
				//remove from list
				If ($RtnFound)
					REMOVE FROM SET:C561([Inspections:27]; "SetInspectionStart")
				Else 
					Case of 
						: (([Inspections:27]Insp Type:6="RT@") | ([Inspections:27]Insp Type:6="CUL")\
							 | ([Inspections:27]Insp Type:6="PED")\
							 | ([Inspections:27]Insp Type:6="RRR")\
							 | ([Inspections:27]Insp Type:6="RRA")\
							 | ([Inspections:27]Insp Type:6="RRC")\
							 | ([Inspections:27]Insp Type:6="TAL"))
							$RtnFound:=True:C214
							
						: ([Inspections:27]Insp Type:6="CMI")\
							 | ([Inspections:27]Insp Type:6="RRS")\
							 | ([Inspections:27]Insp Type:6="TSP")\
							 | ([Inspections:27]Insp Type:6="TOV")
							If ($SpecFnd)
								REMOVE FROM SET:C561([Inspections:27]; "SetInspectionStart")
							Else 
								$SpecFnd:=True:C214
							End if 
							
						: ([Inspections:27]Insp Type:6="FCR")\
							 | ([Inspections:27]Insp Type:6="RRF")
							If ($FrcFnd)
								REMOVE FROM SET:C561([Inspections:27]; "SetInspectionStart")
							Else 
								$FrcFnd:=True:C214
							End if 
						: ([Inspections:27]Insp Type:6="DAM")\
							 | ([Inspections:27]Insp Type:6="RRD")\
							 | ([Inspections:27]Insp Type:6="TDA")
							If ($DamFnd)
								REMOVE FROM SET:C561([Inspections:27]; "SetInspectionStart")
							Else 
								$DamFnd:=True:C214
							End if 
							
						Else 
							REMOVE FROM SET:C561([Inspections:27]; "SetInspectionStart")
					End case 
					
				End if 
				
			Else 
				$StartBIN:=[Inspections:27]BIN:1
				$RtnFound:=(([Inspections:27]Insp Type:6="RT@") | ([Inspections:27]Insp Type:6="CUL")\
					 | ([Inspections:27]Insp Type:6="PED")\
					 | ([Inspections:27]Insp Type:6="RRR")\
					 | ([Inspections:27]Insp Type:6="RRA")\
					 | ([Inspections:27]Insp Type:6="RRC")\
					 | ([Inspections:27]Insp Type:6="TAL"))
				$SpecFnd:=([Inspections:27]Insp Type:6="CMI")\
					 | ([Inspections:27]Insp Type:6="RRS")\
					 | ([Inspections:27]Insp Type:6="TSP")\
					 | ([Inspections:27]Insp Type:6="TOV")
				$FrcFnd:=([Inspections:27]Insp Type:6="FCR")\
					 | ([Inspections:27]Insp Type:6="RRF")
				$DamFnd:=([Inspections:27]Insp Type:6="DAM")\
					 | ([Inspections:27]Insp Type:6="RRD")\
					 | ([Inspections:27]Insp Type:6="TDA")
			End if 
			Progress SET PROGRESS($progressBar_L; $i/Records in selection:C76([Inspections:27]))
		End for 
		
		USE SET:C118("SetInspectionStart")
		CLEAR SET:C117("SetInspectionStart")
		
	Else 
		ARRAY TEXT:C222($BINS_; 0)
		ARRAY TEXT:C222($Types_; 0)
		ARRAY LONGINT:C221($recordnumbers_; 0)
		SELECTION TO ARRAY:C260([Inspections:27]; $recordnumbers_; [Inspections:27]BIN:1; $BINS_; [Inspections:27]Insp Type:6; $Types_)
		For ($i; 2; Records in selection:C76([Inspections:27]))
			
			If ($BINS_{$i}=$StartBIN)
				//remove from list
				If ($RtnFound)
					$recordnumbers_{$i}:=0
				Else 
					Case of 
						: (($Types_{$i}="RT@") | ($Types_{$i}="CUL")\
							 | ($Types_{$i}="PED")\
							 | ($Types_{$i}="RRR")\
							 | ($Types_{$i}="RRA")\
							 | ($Types_{$i}="RRC")\
							 | ($Types_{$i}="TAL"))
							$RtnFound:=True:C214
							
						: ($Types_{$i}="CMI")\
							 | ($Types_{$i}="RRS")\
							 | ($Types_{$i}="TSP")\
							 | ($Types_{$i}="TOV")
							If ($SpecFnd)
								$recordnumbers_{$i}:=0
							Else 
								$SpecFnd:=True:C214
							End if 
							
						: ($Types_{$i}="FCR")\
							 | ($Types_{$i}="RRF")
							If ($FrcFnd)
								$recordnumbers_{$i}:=0
							Else 
								$FrcFnd:=True:C214
							End if 
						: ($Types_{$i}="DAM")\
							 | ($Types_{$i}="RRD")\
							 | ($Types_{$i}="TDA")
							If ($DamFnd)
								$recordnumbers_{$i}:=0
							Else 
								$DamFnd:=True:C214
							End if 
							
						Else 
							$recordnumbers_{$i}:=0
					End case 
					
				End if 
				
			Else 
				
				$StartBIN:=$BINS_{$i}
				$RtnFound:=(($Types_{$i}="RT@") | ($Types_{$i}="CUL")\
					 | ($Types_{$i}="PED")\
					 | ($Types_{$i}="RRR")\
					 | ($Types_{$i}="RRA")\
					 | ($Types_{$i}="RRC")\
					 | ($Types_{$i}="TAL"))
				$SpecFnd:=($Types_{$i}="CMI")\
					 | ($Types_{$i}="RRS")\
					 | ($Types_{$i}="TSP")\
					 | ($Types_{$i}="TOV")
				$FrcFnd:=($Types_{$i}="FCR")\
					 | ($Types_{$i}="RRF")
				$DamFnd:=($Types_{$i}="DAM")\
					 | ($Types_{$i}="RRD")\
					 | ($Types_{$i}="TDA")
			End if 
			Progress SET PROGRESS($progressBar_L; $i/Records in selection:C76([Inspections:27]))
		End for 
		
		Progress SET MESSAGE($progressBar_L; "Cleaning up")
		
		C_LONGINT:C283($records_)
		$records_:=Size of array:C274($recordnumbers_)
		For ($i; $records_; 1; -1)
			If ($recordnumbers_{$i}<1)
				DELETE FROM ARRAY:C228($recordnumbers_; $i)
			End if 
		End for 
		
		CREATE SELECTION FROM ARRAY:C640([Inspections:27]; $recordnumbers_)
		
	End if 
	
	Progress SET MESSAGE($progressBar_L; "Getting Elements")
	RELATE MANY SELECTION:C340([ElementsSafety:29]InspID:4)
	
	ELMSRCH_ElementFilter
	//save the set of elements for subsequent searches
	CREATE SET:C116([ElementsSafety:29]; "ELMTSFILTERED")
	//Indicate that we've saved it.
	OB SET:C1220(SRC_BridgeElemParams_o; "ElementsFiltered"; True:C214)
	
Else 
	
	USE SET:C118("ELMTSFILTERED")
	
End if 

G_DeficientElmtQuery

Progress QUIT($progressBar_L)

//CLOSE WINDOW
OBJECT SET ENABLED:C1123(bFind; True:C214)  // Command Replaced was o_ENABLE BUTTON 
GOTO OBJECT:C206(cboDefOp)  //set focus on Deficiency Operator combo box
CREATE SET:C116([ElementsSafety:29]; "ElmtsFoundThisTime")
If (Records in set:C195("TotalElmtsFound")=0)
	If (vAddTo=False:C215)
		CREATE EMPTY SET:C140([ElementsSafety:29]; "TotalElmtsFound")
	End if 
End if 
UNION:C120("TotalElmtsFound"; "ElmtsFoundThisTime"; "TotalElmtsFound")
CLEAR SET:C117("ElmtsFoundThisTime")

RELATE ONE SELECTION:C349([ElementsSafety:29]; [Inspections:27])
RELATE ONE SELECTION:C349([Inspections:27]; [Bridge MHD NBIS:1])

CREATE SET:C116([Bridge MHD NBIS:1]; "Found Bridge Recs Set")
If (Records in set:C195("Random Set")=0)
	If (vAddTo=False:C215)
		CREATE EMPTY SET:C140([Bridge MHD NBIS:1]; "Random Set")
	End if 
End if 
UNION:C120("Random Set"; "Found Bridge Recs Set"; "Random Set")
CLEAR SET:C117("Found Bridge Recs Set")