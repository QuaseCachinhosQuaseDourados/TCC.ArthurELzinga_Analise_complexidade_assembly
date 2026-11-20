/* Problema: Introduction and Array Implementation of Queue
 * Complexidade de Tempo: O(1)
 * Complexidade de Espaco: O(N)
 * Fonte: https://www.geeksforgeeks.org/introduction-and-array-implementation-of-queue/
 */

// C program for array implementation of queue
#include <limits.h>
#include <stdio.h>
#include <stdlib.h>

// A structure to represent a queue
structQueue {
    intfront, rear, size;
    unsigned capacity;
    int* array;
};

// function to create a queue
// of given capacity.
// It initializes size of queue as 0
structQueue* createQueue(unsigned capacity)
{
    structQueue* queue = (structQueue*)malloc(
        sizeof(structQueue));
    queue->capacity = capacity;
    queue->front = queue->size = 0;

    // This is important, see the enqueue
    queue->rear = capacity - 1;
    queue->array = (int*)malloc(
        queue->capacity * sizeof(int));
    returnqueue;
}

// Queue is full when size becomes
// equal to the capacity
intisFull(structQueue* queue)
{
    return(queue->size == queue->capacity);
}

// Queue is empty when size is 0
intisEmpty(structQueue* queue)
{
    return(queue->size == 0);
}

// Function to add an item to the queue.
// It changes rear and size
voidenqueue(structQueue* queue, intitem)
{
    if(isFull(queue))
        return;
    queue->rear = (queue->rear + 1)
                  % queue->capacity;
    queue->array[queue->rear] = item;
    queue->size = queue->size + 1;
    printf("%d enqueued to queue\n", item);
}

// Function to remove an item from queue.
// It changes front and size
intdequeue(structQueue* queue)
{
    if(isEmpty(queue))
        returnINT_MIN;
    intitem = queue->array[queue->front];
    queue->front = (queue->front + 1)
                   % queue->capacity;
    queue->size = queue->size - 1;
    returnitem;
}

// Function to get front of queue
intfront(structQueue* queue)
{
    if(isEmpty(queue))
        returnINT_MIN;
    returnqueue->array[queue->front];
}

// Function to get rear of queue
intrear(structQueue* queue)
{
    if(isEmpty(queue))
        returnINT_MIN;
    returnqueue->array[queue->rear];
}

// Driver program to test above functions./
intmain()
{
    structQueue* queue = createQueue(1000);

    enqueue(queue, 10);
    enqueue(queue, 20);
    enqueue(queue, 30);
    enqueue(queue, 40);

    printf("%d dequeued from queue\n\n",
           dequeue(queue));

    printf("Front item is %d\n", front(queue));
    printf("Rear item is %d\n", rear(queue));

    return0;
}
