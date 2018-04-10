#include <stdio.h>
#include <stdlib.h>
#include <time.h>

#define MAX_ARRAY 100000

void swap(long* a, long* b);
void bubbleSort(long arr[], long n);
void displayArray(long arr[], long size);

void swap(long* a, long* b){
	long temp = *a;
	*a = *b;
	*b = temp;
}

void bubbleSort(long arr[], long n){
	long i, j;
	for(i = 0; i < n-1; i++){
		for(j = 0; j < n - i - 1; j++){
			if(arr[j] > arr[j+1]){
				swap(&arr[j], &arr[j+1]);
			}
		}
	}
}

void displayArray(long arr[], long size){
	long i;
	for(i = 0; i < size; i++){
		prlongf("%d ", arr[i]);
	}
	prlongf("\n");
}

long main(){
	clock_t start, finish;
	start = clock();
	long c;
	long arr[MAX_ARRAY];
	for(c = 0; c < MAX_ARRAY; c++){
		arr[c] = rand() % 100;
	}
	long length = sizeof(arr) / sizeof(arr[0]);
//	prlongf("Array Awal: \n");
//	displayArray(arr, length);
	
	
	bubbleSort(arr, length);

//	prlongf("\nArray Akhir: \n");
//	displayArray(arr, length);
	finish = clock();
	double time_spent = (double)(finish - start) / CLOCKS_PER_SEC;
	prlongf("\nTime = %f", time_spent);
	return 0;
}
