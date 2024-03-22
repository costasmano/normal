//%attributes = {"invisible":true}
//GP FindZeroElemEnv

//Find all bridges with a pontis inspection containing a zero
//element ID or zero environment.

QUERY:C277([Cond Units:45]; [Cond Units:45]Element ID:3=0; *)
QUERY:C277([Cond Units:45];  | ; [Cond Units:45]Environment:4=0)
//JOIN([Cond Units];[Bridge MHD NBIS])
RELATE ONE SELECTION:C349([Cond Units:45]; [BMS Inspections:44])
//Search District 1.
//SEARCH SELECTION([Bridge MHD NBIS];[Bridge MHD NBIS]Item2="01")
//SORT SELECTION([Bridge MHD NBIS];[Bridge MHD NBIS]Item2;[Bridge MHD NBIS]BDEPT)
ORDER BY:C49([BMS Inspections:44]; [BMS Inspections:44]Inspection ID:1)