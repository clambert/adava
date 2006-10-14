/*
 *  Wrapper.c
 *  AvCall
 *
 *  Created by Charles Lambert on 10/6/06.
 *  Copyright 2006 Charles Lambert. All rights reserved.
 *
 */

#include <avcall.h>
#include <stdlib.h>

<<[Insert:code]>>

void av_start_void_wrapper(av_alist * alist, (func *)()) {
	av_start_void(*alist, func);
}

void av_call_wrapper(av_alist * alist) {
	av_call(*alist);
}

av_alist * av_alist_malloc() {
	return (av_alist *)malloc(sizeof(av_alist));
}

void av_alist_free(av_alist * alist) {
	free(alist);
}

