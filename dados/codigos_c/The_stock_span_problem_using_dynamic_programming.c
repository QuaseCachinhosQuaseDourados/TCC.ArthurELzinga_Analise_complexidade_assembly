/* Problema: The stock span problem using dynamic programming:
 * Complexidade de Tempo: O(N)
 * Complexidade de Espaco: O(N)
 * Fonte: https://www.geeksforgeeks.org/the-stock-span-problem/
 */

// C program for the above approach
#include <limits.h>
#include <stdio.h>
#include <stdlib.h>
#define SIZE 6

// change size of  stack from here
// change this char to int if
// you want to create stack of
// int. rest all program will work fine
typedefintstackentry;

typedefstructstack {
    stackentry entry[SIZE];
    inttop;
} STACK;

// stack is initialized by setting top pointer = -1.
voidinitialiseStack(STACK* s) { s->top = -1; }

// to check if stack is full.
intIsStackfull(STACK s)
{
    if(s.top == SIZE - 1) {
        return(1);
    }
    return(0);
}

// to check if stack is empty.
intIsStackempty(STACK s)
{
    if(s.top == -1) {
        return(1);
    }
    else{
        return(0);
    }
}

// to push elements into the stack.
voidpush(stackentry d, STACK* s)
{
    if(!IsStackfull(*s)) {

        s->entry[(s->top) + 1] = d;
        s->top = s->top + 1;
    }
}

// to pop element from stack.
stackentry pop(STACK* s)
{
    stackentry ans;
    if(!IsStackempty(*s)) {
        ans = s->entry[s->top];
        s->top = s->top - 1;
    }
    else{

        // '\0'  will be returned if
        // stack is empty and of
        // char type.
        if(sizeof(stackentry) == 1)
            ans = '\0';
        else
            // INT_MIN  will be returned
            // if stack is empty
            // and of int type.
            ans = INT_MIN;
    }
    return(ans);
}

// The code for implementing stock
// span problem is written
// here in main function.
intmain()
{
    // Just to store prices on 7 adjacent days
    intprice[6] = { 10, 4, 5, 90, 120, 80 };

    // in span array , span of each day will be stored.
    intspan[6] = { 0 };
    inti;

    // stack 's' will store stock values of each
    // day. stack 'temp' is temporary stack
    STACK s, temp;

    // setting top pointer to -1.
    initialiseStack(&s);
    initialiseStack(&temp);

    // count basically signifies span of
    // particular day.
    intcount = 1;

    // since first day span is 1 only.
    span[0] = 1;
    push(price[0], &s);

    // calculate span of remaining days.
    for(i = 1; i < 6; i++) {

        // count will be span of that particular day.
        count = 1;

        // if current day stock is larger than previous day
        // span, then it will be popped out into temp stack.
        // popping will be carried out till span gets over
        // and count will be incremented .

        while(!IsStackempty(s)
               && s.entry[s.top] <= price[i]) {
            push(pop(&s), &temp);
            count++;
        }

        // now, one by one all stocks from temp will be
        // popped and pushed back to s.
        while(!IsStackempty(temp)) {
            push(pop(&temp), &s);
        }

        // pushing current stock
        push(price[i], &s);

        // appending span of that particular
        // day into output array.
        span[i] = count;
    }

    // printing the output.
    for(i = 0; i < 6; i++)
        printf("%d ", span[i]);
}
