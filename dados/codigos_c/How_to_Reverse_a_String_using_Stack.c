/* Problema: How to Reverse a String using Stack
 * Complexidade de Tempo: O(N)
 * Complexidade de Espaco: O(N)
 * Fonte: https://www.geeksforgeeks.org/stack-set-3-reverse-string-using-stack/
 */

// C program to reverse a string using stack
#include <limits.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

// A structure to represent a stack
structStack {
    inttop;
    unsigned capacity;
    char* array;
};

// function to create a stack of given
// capacity. It initializes size of stack as 0
structStack* createStack(unsigned capacity)
{
    structStack* stack
        = (structStack*)malloc(sizeof(structStack));
    stack->capacity = capacity;
    stack->top = -1;
    stack->array
        = (char*)malloc(stack->capacity * sizeof(char));
    returnstack;
}

// Stack is full when top is equal to the last index
intisFull(structStack* stack)
{
    returnstack->top == stack->capacity - 1;
}

// Stack is empty when top is equal to -1
intisEmpty(structStack* stack)
{
    returnstack->top == -1;
}

// Function to add an item to stack.
// It increases top by 1
voidpush(structStack* stack, charitem)
{
    if(isFull(stack))
        return;
    stack->array[++stack->top] = item;
}

// Function to remove an item from stack.
// It decreases top by 1
charpop(structStack* stack)
{
    if(isEmpty(stack))
        returnINT_MIN;
    returnstack->array[stack->top--];
}

// A stack based function to reverse a string
voidreverse(charstr[])
{
    // Create a stack of capacity
    // equal to length of string
    intn = strlen(str);
    structStack* stack = createStack(n);

    // Push all characters of string to stack
    inti;
    for(i = 0; i < n; i++)
        push(stack, str[i]);

    // Pop all characters of string and
    // put them back to str
    for(i = 0; i < n; i++)
        str[i] = pop(stack);
}

// Driver program to test above functions
intmain()
{
    charstr[] = "GeeksQuiz";

    reverse(str);
    printf("Reversed string is %s", str);

    return0;
}
