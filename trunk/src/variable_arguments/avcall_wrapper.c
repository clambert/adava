/*
 *  avcall_wrapper.c
 *  AvCall
 *
 *  Created by Charles Lambert on 9/30/06.
 *  Copyright 2006 Charles Lambert. All rights reserved.
 * 
 * This program is free software; you can redistribute it and/or
 * modify it under the terms of the GNU General Public License
 * as published by the Free Software Foundation; either version 2
 * of the License, or (at your option) any later version.
 * 
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 * 
 * You should have received a copy of the GNU General Public License
 * along with this program; if not, write to the Free Software
 * Foundation, Inc., 51 Franklin Street, Fifth Floor, 
 * Boston, MA  02110-1301, USA.
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
