//%attributes = {"invisible":true}
//GP BMS_Find_UWInsp
//Copyright © 1999, Thomas D. Nee, All Rights Reserved.

//Try to find BMS (Pontis) inspections that contain only underwater elements.
//This should select most of the incomplete inspections (March 1999).

C_LONGINT:C283($i; $MaxCUs; $CUs)

TRACE:C157

QUERY:C277([BMS Field Trip:56]; [BMS Field Trip:56]Person ID:2=14; *)  //Joe Donahue
QUERY:C277([BMS Field Trip:56];  | ; [BMS Field Trip:56]Person ID:2=9; *)  //Randi Bonica
QUERY:C277([BMS Field Trip:56];  | ; [BMS Field Trip:56]Person ID:2=17; *)  //Jack Fitzgerald
QUERY:C277([BMS Field Trip:56];  | ; [BMS Field Trip:56]Person ID:2=112; *)  //John Desmond
QUERY:C277([BMS Field Trip:56];  | ; [BMS Field Trip:56]Person ID:2=113; *)  //Helmut Ernst
QUERY:C277([BMS Field Trip:56];  | ; [BMS Field Trip:56]Person ID:2=117; *)  //Mark Massery
QUERY:C277([BMS Field Trip:56];  | ; [BMS Field Trip:56]Person ID:2=118)  //Alice Massery
RELATE ONE SELECTION:C349([BMS Field Trip:56]; [BMS Inspections:44])
CREATE SET:C116([BMS Inspections:44]; "U/W Inspections")

QUERY:C277([BMS Inspections:44]; [BMS Inspections:44]Agency:13="MHD Underwater Oper."; *)
QUERY:C277([BMS Inspections:44];  | ; [BMS Inspections:44]TeamLeader:6=14; *)  //Joe Donahue
QUERY:C277([BMS Inspections:44];  | ; [BMS Inspections:44]TeamLeader:6=9; *)  //Randi Bonica
QUERY:C277([BMS Inspections:44];  | ; [BMS Inspections:44]TeamLeader:6=17; *)  //Jack Fitzgerald
QUERY:C277([BMS Inspections:44];  | ; [BMS Inspections:44]TeamLeader:6=112; *)  //John Desmond
QUERY:C277([BMS Inspections:44];  | ; [BMS Inspections:44]TeamLeader:6=113; *)  //Helmut Ernst
QUERY:C277([BMS Inspections:44];  | ; [BMS Inspections:44]TeamLeader:6=117; *)  //Mark Massery
QUERY:C277([BMS Inspections:44];  | ; [BMS Inspections:44]TeamLeader:6=118)  //Alice Massery
CREATE SET:C116([BMS Inspections:44]; "More U/W Inspections")
UNION:C120("U/W Inspections"; "More U/W Inspections"; "U/W Inspections")

//This Block returns too many false positives.  And it takes too long.
//CONFIRM("Do you want to include all inspections with submerged elements?")
//If (OK=1)
//SEARCH([Cond Units];[BMS Elements]Element No>=220;*)  `Submerged elements.
//SEARCH([Cond Units]; & [BMS Elements]Element No<=228)
//  JOIN([Cond Units];[BMS Inspections])
//  CREATE SET([BMS Inspections];"More U/W Inspections")
//  UNION("U/W Inspections";"More U/W Inspections";"U/W Inspections")
//End if 

$MaxCUs:=Num:C11(Request:C163("Max Elements indicating U/W Insp?"; "3"))
//Enter zero to skip this time consuming task.
If ((OK=1) & ($MaxCUs>0))
	ALL RECORDS:C47([BMS Inspections:44])
	For ($i; 1; Records in selection:C76([BMS Inspections:44]))
		COPY NAMED SELECTION:C331([BMS Inspections:44]; "All BMS Inspections")
		RELATE MANY:C262([BMS Inspections:44]Inspection ID:1)
		$CUs:=Records in selection:C76([Cond Units:45])
		If ($CUs<=$MaxCUs)
			QUERY SELECTION:C341([Cond Units:45]; [BMS Elements:47]Element No:2>=240; *)  //Culvert elements
			QUERY SELECTION:C341([Cond Units:45];  & ; [BMS Elements:47]Element No:2<=243)
			If (Records in selection:C76([Cond Units:45])=0)
				//There are no more than $MaxCUs elements and none of them are culvert elements,
				//so include this inspection.
				ADD TO SET:C119([BMS Inspections:44]; "U/W Inspections")
			End if 
		End if 
		USE NAMED SELECTION:C332("All BMS Inspections")
		NEXT RECORD:C51([BMS Inspections:44])
	End for 
	CLEAR NAMED SELECTION:C333("All BMS Inspections")
End if 

USE SET:C118("U/W Inspections")
ORDER BY:C49([BMS Inspections:44]; [Bridge MHD NBIS:1]BDEPT:1; [Bridge MHD NBIS:1]BIN:3)