
#include <stdlib.h>
#include <string.h>
#include <stdio.h>

__global__ void mykernel(void) 
{ 	
}

int main(void) 
{ 		
	mykernel<<<1,1>>>(); // tirple brackets mark call from host to device	
	printf("Hello World!\n"); 		
	return 0; 	
}

