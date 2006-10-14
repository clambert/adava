procedure Av_Start_<<[ID]>>_Ptr(
	Av_AList     : Void_Access;
	C_Function   : C_Function_Access;
	Return_Value : Void_Access);
pragma Import(C, av_start_<<[CType]>>_Ptr, "av_start_<<[CType]>>_ptr_wrapper");

procedure Av_<<[ID]>>_Ptr(
	Av_AList   : Void_Access;
	C_Function : C_Function_Access);
pragma Import(C, Av_<<[ID]>>_Ptr, "av_<<[CType]>>_ptr_wrapper");

package Registered_<<[ID]>>_Ptr is new Register_Type(
	Any_Convention_C_Type => <<[AdaType]>>,
	Add_Argument          => Av_<<[ID]>>_Ptr);