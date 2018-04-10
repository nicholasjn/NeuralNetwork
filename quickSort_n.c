#include <stdio.h>
#include <stdlib.h>
#include <time.h>

#define MAX_ARRAY 10

//Function Prototype
void swap(int* a, int* b);
int partition(int arr[], int low, int high);
void quickSort(int arr[], int low, int high);
void displayArray(int arr[], int size);

void quickSort(int arr[], int low, int high){
	int par;
	if(low < high){
		par = partition(arr, low, high);
		
		quickSort(arr, low, par - 1);
		quickSort(arr, par + 1, high);
	}
}

int partition(int arr[], int low, int high){
	int pivot, i, j;
	pivot = arr[high];
	i = (low - 1);
	
	for(j = low; j <= high-1; j++){
		if(arr[j] <= pivot){
			i++;
			swap(&arr[i], &arr[j]);
		}
	}
	swap(&arr[i + 1], &arr[high]);
	return (i + 1);
}

void swap(int* a, int* b){
	int temp = *a;
	*a = *b;
	*b = temp;
}

void displayArray(int arr[], int size){
	int i;
	for(i = 0; i < size; i++){
		printf("%d ", arr[i]);
	}
	printf("\n");
}

int main(){
	clock_t start, finish;
	int* arr = (int* ) malloc(sizeof(int) * MAX_ARRAY);
	int c;
	for(c = 0; c < MAX_ARRAY; c++){
		arr[c] = rand() % 100;
	}
	int length = sizeof(arr) / sizeof(arr[0]);
	printf("Array Awal: \n");
	displayArray(arr, length);
	
	start = clock();
	
	quickSort(arr, 0, length-1);
	
	finish = clock();
	double time_spent = (double)(finish - start) / CLOCKS_PER_SEC;

	printf("\nArray Akhir: \n");
	displayArray(arr, length);
	printf("\nTime = %f", time_spent);
	free(arr);
	return 0;
}
