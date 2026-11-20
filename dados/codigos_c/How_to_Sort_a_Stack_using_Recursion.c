/* Problema: How to Sort a Stack using Recursion
 * Complexidade de Tempo: O(N2)
 * Complexidade de Espaco: O(N)
 * Fonte: https://www.geeksforgeeks.org/sort-a-stack-using-recursion/
 */

// C program to sort a stack using recursion
#include <stdio.h>
#include <stdlib.h>

// Stack is represented using linked list
structstack {
    intdata;
    structstack* next;
};

// Utility function to initialize stack
voidinitStack(structstack** s) { *s = NULL; }

// Utility function to check if stack is empty
intisEmpty(structstack* s)
{
    if(s == NULL)
        return1;
    return0;
}

// Utility function to push an item to stack
voidpush(structstack** s, intx)
{
    structstack* p = (structstack*)malloc(sizeof(*p));

    if(p == NULL) {
        fprintf(stderr, "Memory allocation failed.\n");
        return;
    }

    p->data = x;
    p->next = *s;
    *s = p;
}

// Utility function to remove an item from stack
intpop(structstack** s)
{
    intx;
    structstack* temp;

    x = (*s)->data;
    temp = *s;
    (*s) = (*s)->next;
    free(temp);

    returnx;
}

// Function to find top item
inttop(structstack* s) { return(s->data); }

// Recursive function to insert an item x in sorted way
voidsortedInsert(structstack** s, intx)
{
    // Base case: Either stack is empty or newly inserted
    // item is greater than top (more than all existing)
    if(isEmpty(*s) || x > top(*s)) {
        push(s, x);
        return;
    }

    // If top is greater, remove the top item and recur
    inttemp = pop(s);
    sortedInsert(s, x);

    // Put back the top item removed earlier
    push(s, temp);
}

// Function to sort stack
voidsortStack(structstack** s)
{
    // If stack is not empty
    if(!isEmpty(*s)) {
        // Remove the top item
        intx = pop(s);

        // Sort remaining stack
        sortStack(s);

        // Push the top item back in sorted stack
        sortedInsert(s, x);
    }
}

// Utility function to print contents of stack
voidprintStack(structstack* s)
{
    while(s) {
        printf("%d ", s->data);
        s = s->next;
    }
    printf("\n");
}

// Driver code
intmain(void)
{
    structstack* top;

    initStack(⊤);
    push(⊤, 30);
    push(⊤, -5);
    push(⊤, 18);
    push(⊤, 14);
    push(⊤, -3);

    printf("Stack elements before sorting:\n");
    printStack(top);

    sortStack(⊤);
    printf("\n\n");

    printf("Stack elements after sorting:\n");
    printStack(top);

    return0;
}
