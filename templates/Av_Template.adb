	procedure Av_Start_<<[ID]>>(
		Av_AList     : Void_Access;
		C_Function   : C_Function_Access;
		Return_Value : Void_Access);
	pragma Import(C, Av_Start_<<[ID]>>, "av_start_<<[ID]>>_wrapper");
	----------------------------------------------------------------------------
	procedure Av_<<[ID]>>(
		Av_AList   : Void_Access;
		C_Function : C_Function_Access);
	pragma Import(C, Av_<<[ID]>>, "av_<<[ID]>>_wrapper");
	----------------------------------------------------------------------------
	package Registered_<<[ID]>> is 
		new Variable_Arguments.For_Implementors.Register_Type(
			Any_Convention_C_Type => <<[AdaType]>>,
			Add_Argument          => Av_<<[ID]>>);
	----------------------------------------------------------------------------
	function "&"(Left : Argument_List; Right : <<[AdaType]>>) 
		renames Registered_<<[ID]>>.Append;
	----------------------------------------------------------------------------