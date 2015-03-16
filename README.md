Please feel free to contact us with questions concerning this project on the mailing list (see the adava discussion group in the links list)


Mission Statement:
	To provide a complete community driven open source solution for calling variable argument functions written in the C programming language from within software written in the ada programming language. This solution should be easy for ada developers to understand, use, and integrate into their existing applications through a standardized api that allows for improvments to the back end with minimal or no impact on the developer using this solution.

Features:

  * Simple concatination operator usage such as:
    {{{
My_Proc(Item1, Start_Argument_List & Item2 & Item3);
}}}

  * Simple API to map to the corresponding C function:
    {{{
package body Example is
        procedure C_My_Proc; -- import the c function
        pragma Import(C, C_My_Proc, 'c_my_proc');

        -- create the proper call procedure or function
        procedure Call is new Av_Call_No_Return(
                Av_Start => Av_Start_Int'Access,
                C_Func   => C_My_Proc'Access);

        -- write your procedure or function
        procedure My_Proc(Item1 : Integer; AList : Argument_List) is
        begin
            Prepend(AList, Item1); -- add your items to the front of
                                   -- the list
            Call(AList);           -- call the c function
        end My_Proc;
    end Example;
}}}

  * Concatination operators defined for all of the types in Interfaces.C

  * Autogeneration of Ada and C code to make concatination operators 
    and parameter passing posible for new types

  * uses ffcall's avcall to handle parameter passing. This also allows
    anyone with basic knowledge of C and C macros to provide custom
    functionality for special situations

Requirements

  * ffcall (see ffcall's homepage in links list)













