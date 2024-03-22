//%attributes = {"invisible":true}
//GP DISPL_PONT_INSP
//Copyright © 1996, Thomas D. Nee, All Rights Reserved.
//Select and sort Pontis BMS Inspection records for this structure.

RELATE MANY:C262([Bridge MHD NBIS:1])
ORDER BY:C49([BMS Inspections:44]; [BMS Inspections:44]Insp Date:4; <; [BMS Inspections:44]Span Group No:3; >)