/*
 *  avcall_wrapper.c
 *  AvCall
 *
 *  Created by Charles Lambert on 9/30/06.
 *  Copyright 2006 Charles Lambert. All rights reserved.
 *
 */

#include <avcall.h>
#include <stdio.h>
av_alist * av_alist_malloc() {
	printf("malloc\n");
	return (av_alist*)malloc(sizeof(av_alist));
}

void av_alist_free(av_alist * alist) {
printf("free\n");
	free(alist);
}
