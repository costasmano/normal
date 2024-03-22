//%attributes = {"invisible":true}
If (False:C215)
	//CreateRandomSetForDefElement 
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
	// Modified by: Costas Manousakis-(Designer)-(2023-02-23 09:13:55)
	Mods_2023_02
	//  `modifications
	//  `-Clean up code to remove parts that were using the "GOTO Record" methodology 
	//  `create two steps when searching for elements :
	//  ` 1 - run through above water inspections starting from the latest routine type, but consider any multiple
	//  `     inspections types after the routine. Exclude only FRZ inspections.
	//  ` 2 - run through underwater inspections starting from the latest routine type (DVE or DVL), and consider any multiple
	//  `     inspections types after the routine. Create Set "DVELMTSFILTERED"
	
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
	
	ORDER BY:C49([Inspections:27]; [Inspections:27]BIN:1; >; [Inspections:27]Insp Date:78; <)
	
	C_TEXT:C284($StartBIN)  //<--- Added// Command Replaced was o_C_STRING length was 3
	C_BOOLEAN:C305($RtnFound; $DiveRtnFnd)
	C_LONGINT:C283($i)
	Progress SET MESSAGE($progressBar_L; "Filtering inspections")
	Progress SET PROGRESS($progressBar_L; 0)
	
	ARRAY TEXT:C222($BINS_; Records in selection:C76([Inspections:27]))
	ARRAY TEXT:C222($Types_; Records in selection:C76([Inspections:27]))
	ARRAY LONGINT:C221($recordIDS_; Records in selection:C76([Inspections:27]))
	ARRAY LONGINT:C221($DiveRecordIDS_; Records in selection:C76([Inspections:27]))
	SELECTION TO ARRAY:C260([Inspections:27]InspID:2; $recordIDS_; [Inspections:27]BIN:1; $BINS_; [Inspections:27]Insp Type:6; $Types_)
	COPY ARRAY:C226($recordIDS_; $DiveRecordIDS_)
	$RtnFound:=False:C215
	$DiveRtnFnd:=False:C215
	
	$StartBIN:=$BINS_{1}
	
	$RtnFound:=(($Types_{1}="RT@")\
		 | ($Types_{1}="CUL")\
		 | ($Types_{1}="PED")\
		 | ($Types_{1}="RRR")\
		 | ($Types_{1}="RRA")\
		 | ($Types_{1}="RRC")\
		 | ($Types_{1}="TAL"))
	
	$DiveRtnFnd:=(($Types_{1}="DVE")\
		 | ($Types_{1}="DVL"))
	
	For ($i; 2; Records in selection:C76([Inspections:27]))
		
		If ($BINS_{$i}=$StartBIN)
			//working with same BIN
			//hanlde above water first
			If ($RtnFound)
				//we already have a routine - exclude this inspection
				$recordIDS_{$i}:=-1
			Else 
				Case of 
					: (($Types_{$i}="RT@")\
						 | ($Types_{$i}="CUL")\
						 | ($Types_{$i}="PED")\
						 | ($Types_{$i}="RRR")\
						 | ($Types_{$i}="RRA")\
						 | ($Types_{$i}="RRC")\
						 | ($Types_{$i}="TAL"))
						$RtnFound:=True:C214  //mark that we found a routine inspection
						
					: ($Types_{$i}="DV@")
						//exclude any Dive inspections
						$recordIDS_{$i}:=-1
				End case 
				
			End if 
			
			//hanlde under water first
			
			If ($DiveRtnFnd)
				$DiveRecordIDS_{$i}:=-1
			Else 
				Case of 
					: (($Types_{1}="DVE")\
						 | ($Types_{1}="DVL"))
						$DiveRtnFnd:=True:C214  //mark that we found a routine Dive inspection
						
					: ($Types_{$i}="DV@")
						// some other type of dive inspection - keep it
					Else 
						// Remove any other non-Dive inspection
						$DiveRecordIDS_{$i}:=-1
				End case 
			End if 
			
		Else 
			//mark start of a new BIN group
			$StartBIN:=$BINS_{$i}
			$RtnFound:=(($Types_{$i}="RT@") | ($Types_{$i}="CUL")\
				 | ($Types_{$i}="PED")\
				 | ($Types_{$i}="RRR")\
				 | ($Types_{$i}="RRA")\
				 | ($Types_{$i}="RRC")\
				 | ($Types_{$i}="TAL"))
			
			$DiveRtnFnd:=(($Types_{1}="DVE")\
				 | ($Types_{1}="DVL"))
			
		End if 
		Progress SET PROGRESS($progressBar_L; $i/Records in selection:C76([Inspections:27]))
	End for 
	
	Progress SET MESSAGE($progressBar_L; "Reducing Above water inspections")
	
	QUERY WITH ARRAY:C644([Inspections:27]InspID:2; $recordIDS_)
	
	Progress SET MESSAGE($progressBar_L; "Getting Above water Elements")
	RELATE MANY SELECTION:C340([ElementsSafety:29]InspID:4)
	
	ELMSRCH_ElementFilter
	//save the set of elements for subsequent searches
	CREATE SET:C116([ElementsSafety:29]; "ELMTSFILTERED")
	
	Progress SET MESSAGE($progressBar_L; "Reducing Above water inspections")
	QUERY WITH ARRAY:C644([Inspections:27]InspID:2; $DiveRecordIDS_)
	Progress SET MESSAGE($progressBar_L; "Getting UW Elements")
	RELATE MANY SELECTION:C340([ElementsSafety:29]InspID:4)
	ELMSRCH_ElementFilter  // apply filter to UW elements
	//save the set of elements for subsequent searches
	CREATE SET:C116([ElementsSafety:29]; "DVELMTSFILTERED")
	
	//Indicate that we've saved it.
	OB SET:C1220(SRC_BridgeElemParams_o; "ElementsFiltered"; True:C214)
	
End if 

If (Records in set:C195("ELMTSFILTERED")>0)
	USE SET:C118("ELMTSFILTERED")
	Progress SET MESSAGE($progressBar_L; "Searching in AboveWater Elements")
	
	G_DeficientElmtQuery
	CREATE SET:C116([ElementsSafety:29]; "$AboveElemtsFound")
Else 
	CREATE EMPTY SET:C140([ElementsSafety:29]; "$AboveElemtsFound")
End if 

If (Records in set:C195("DVELMTSFILTERED")>0)
	USE SET:C118("DVELMTSFILTERED")
	Progress SET MESSAGE($progressBar_L; "Searching in UW Elements")
	
	G_DeficientElmtQuery
	CREATE SET:C116([ElementsSafety:29]; "$UWElemtsFound")
Else 
	CREATE EMPTY SET:C140([ElementsSafety:29]; "$UWElemtsFound")
End if 

UNION:C120("$AboveElemtsFound"; "$UWElemtsFound"; "$AboveElemtsFound")
USE SET:C118("$AboveElemtsFound")
CLEAR SET:C117("$AboveElemtsFound")
CLEAR SET:C117("$UWElemtsFound")

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