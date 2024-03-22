//%attributes = {"invisible":true}
//GP EZSetRelation
//Copyright © 1998, Thomas D. Nee, All Rights Reserved.

//A relation has been set...

Case of 
	: (rbEqual=1)
		asShowRel{vBuildCount}:="Equal To"
	: (rbNotEqual=1)
		asShowRel{vBuildCount}:="Not Equal To"
	: (rbLess=1)
		asShowRel{vBuildCount}:="Less Than"
	: (rbLessEqual=1)
		asShowRel{vBuildCount}:="Less Than or Equal To"
	: (rbGreater=1)
		asShowRel{vBuildCount}:="Greater Than"
	: (rbGreaterEq=1)
		asShowRel{vBuildCount}:="Greater Than or Equal To"
	: (rbStarts=1)
		asShowRel{vBuildCount}:="Starts With"
	: (rbContains=1)
		asShowRel{vBuildCount}:="Contains"
	: (rbNotCont=1)
		asShowRel{vBuildCount}:="Does Not Contain"
End case 