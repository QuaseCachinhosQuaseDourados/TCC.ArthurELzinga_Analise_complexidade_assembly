/* Problema: Find Next Greater Element using Stack:
 * Complexidade de Tempo: O(N)
 * Complexidade de Espaco: O(N)
 * Fonte: https://www.geeksforgeeks.org/next-greater-element/
 */

// A Stack based C program to find next
//  greater element for all array elements.
#include <stdbool.h>
#include <stdio.h>
#include <stdlib.h>
#define STACKSIZE 100

// stack structure
structstack {
    inttop;
    intitems[STACKSIZE];
};

// Stack Functions to be used by printNGE()
voidpush(structstack* ps, intx)
{
    if(ps->top == STACKSIZE - 1) {
        printf("Error: stack overflown");
        getchar();
        exit(0);
    }
    else{
        ps->top += 1;
        inttop = ps->top;
        ps->items[top] = x;
    }
}

boolisEmpty(structstack* ps)
{
    return(ps->top == -1) ? true: false;
}

intpop(structstack* ps)
{
    inttemp;
    if(ps->top == -1) {
        printf("Error: stack underflow n");
        getchar();
        exit(0);
    }
    else{
        inttop = ps->top;
        temp = ps->items[top];
        ps->top -= 1;
        returntemp;
    }
}

/* prints element and NGE pair for all elements of
arr[] of size n */
voidprintNGE(intarr[], intn)
{
    inti = 0;
    structstack s;
    s.top = -1;
    intelement, next;

    /* push the first element to stack */
    push(&s, arr[0]);

    // iterate for rest of the elements
    for(i = 1; i < n; i++) {
        next = arr[i];

        if(isEmpty(&s) == false) {
            // if stack is not empty, then pop an element
            // from stack
            element = pop(&s);

            /* If the popped element is smaller than next,
               then a) print the pair b) keep popping while
               elements are smaller and stack is not empty
             */
            while(element < next) {
                printf("n %d --> %d", element, next);
                if(isEmpty(&s) == true)
                    break;
                element = pop(&s);
            }

            /* If element is greater than next, then push
               the element back */
            if(element > next)
                push(&s, element);
        }

        /* push next to stack so that we can find
           next greater for it */
        push(&s, next);
    }

    /* After iterating over the loop, the remaining
       elements in stack do not have the next greater
       element, so print -1 for them */
    while(isEmpty(&s) == false) {
        element = pop(&s);
        next = -1;
        printf("n %d --> %d", element, next);
    }
}

/* Driver code */
intmain()
{
    intarr[] = { 11, 13, 21, 3 };
    intn = sizeof(arr) / sizeof(arr[0]);
    printNGE(arr, n);
    getchar();
    return0;
}
