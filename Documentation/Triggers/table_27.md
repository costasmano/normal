Table of inspection reports by record in the [Bridge MHD NBIS] table  
+ 2001-09 : Changed Relation with Bridge MHD NBIS table to 'Auto One to many'. Helps in searches.  
+ 2001-12 : Added fields InspApproved , InspReviewed : integer (0,1,2).  field InspComplete : boolean. InspApprCmts, InspRevCmts : text.  
+ 2002-01 : Made table read write to all ReadWrite users. Added Blob Field InspComments for comments.  
+ 2002-02 : Changed Accesibility fields from boolean to Alpha(2)  
+ 2002-10 : Changed width of AccessOther field to Alpha(20)  
+ 2002-11 : Renamed field TeamMember to OrientationNS  and changed it to Boolean. If true N-S ; False : E-W. Renamed Field ExpsedFoot to Item60UW_i, Sheeting to Item61UW_i, Rip Rap to Item62UW_i all Alpha(2).  Added Fields Item 62 Cur, Item61_i, Item62_i Alpha(2).  
+ 2002-12 : Added fields BarrelHeight,width,number, CulvertCoating,Material,Shape for use by Culvert Inspections.  
+ 2003-01 : Renamed field WaterCondition to UW BrgAccess to be used for UW inspections. Made Current A30.  
+ 2003-02 : Changed fields for Signs in Place to A2.  
+ 2003-05 : Made field InspDate Indexed.  
+ 2003-10-17 : Made field InspApproved, InspReviewed, ModifiedBy Indexed.  
+ 2003-12-19 : Made Field Barrier Type A30.  
+ 2004-02-13 : Changed Field ownercode to Item21/A2/Invis. Added fld Item22/A2/Invis , Item106/Int/Invis, TeamMembrAddl/Boolean.