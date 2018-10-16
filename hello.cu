
#include <stdlib.h>
#include <string.h>
#include <stdio.h>

__global__ void add(int *a, int *b, int *c, int n) 
{ 	
	int index = threadIdx.x + blockIdx.x * blockDim.x;
	if (index < n)
		c[index] = a[index] + b[index];
}

void fill(int *a, int len) {
	while(len--) {
		a[len] = len;
		//printf("file m[%d] = %d\n", len, len);
	}
}

#define N 16
int main(void) 
{ 		
	int *a, *b, *c;       // host copies of a, b, c
	int *a1, *b1, *c1; // device copies of a, b, c
	int nsize = N * sizeof(int);

	cudaMalloc((void **)&a1, nsize); // allocate space for device
	cudaMalloc((void **)&b1, nsize);
	cudaMalloc((void **)&c1, nsize);
	a = (int *)malloc(nsize); // fill-in a with values
	b = (int *)malloc(nsize); // fill-in b with values
	c = (int *)malloc(nsize);
	fill(a, N);
	fill(b, N);
	cudaMemcpy(a1, a, nsize, cudaMemcpyHostToDevice);
	cudaMemcpy(b1, b, nsize, cudaMemcpyHostToDevice);

	// format: add<<< BLOCKS, THREADS >>>  access via blockIdx.x and threadIdx.x
	add<<<N,1>>>(a1, b1, c1, N); // seen as N/THREADS_PER_BLOCK,THREADS_PER_BLOCK or (N + M-1) / M,M	
	cudaMemcpy(c, c1, nsize, cudaMemcpyDeviceToHost); // result back to host

	for(int x = 0; x < N; x++) {
		printf("c[%d] = %d a[%d] + b[%d] = (%d + %d)\n", x, c[x], x, x, a[x], b[x]);
	}
	cudaFree(a1); cudaFree(b1); cudaFree(c1); free(a); free(b); free(c);
	return 0; 	
}
