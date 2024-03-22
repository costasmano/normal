//%attributes = {"invisible":true}
// Modified by: costasmanousakis-(Designer)-(7/1/2005 16:26:05)
// Modified Forms : 
//[TownLineInfo];"TownLineOUT"
//  `Replaced Field BDEPT wiht Variable sBDEPT.
// Modified Form Methods : 
//[TownLineInfo];"TownLineOUT"
//  `Added code to fill sBDEPT with "_" if BDEPT is a blank.

// Modified by: costasmanousakis-(Designer)-(7/6/2005 14:21:05)
// Modified Forms : 
//[Bridge MHD NBIS];"Rpt Mstr"
//  `Added a Header1 section, adjusted  Break location.
// Modified Methods : 
//M_MasterList
//  `Changed to use Header1 and Footer from Rpt Mstr form.

// Modified by: costasmanousakis-(Designer)-(7/7/2005 17:30:15)
// Modified Form Methods : 
//[Inspections];"Damage Pg1"
//[Inspections];"FC Pr (Pg 1)"
//[Inspections];"SpecialExtra"
//  `Modified format for vH20_ vType3_ v3S2_ variables to "##0;N;0" so that -1 will show as N.