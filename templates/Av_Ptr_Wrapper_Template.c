void av_start_<<[ID]>>_ptr_wrapper(av_alist * alist, (func *)(), 
		<<[CType]>> ** value) {
	av_start_ptr(*alist, func, <<[CType]>> *, value);
}

void av_<<[ID]>>_ptr_wrapper(av_alist * alist, <<[CType]>> * value) {
	av_ptr(*alist, <<[CType]>> *, value);
}