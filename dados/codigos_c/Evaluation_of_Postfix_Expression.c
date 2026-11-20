/* Problema: Evaluation of Postfix Expression
 * Complexidade de Tempo: O(N)
 * Complexidade de Espaco: O(N)
 * Fonte: https://www.geeksforgeeks.org/evaluation-of-postfix-expression/
 */

// C program to evaluate value of a postfix expression
#include <ctype.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

// Stack type
structStack {
    inttop;
    unsigned capacity;
    int* array;
};

// Stack Operations
structStack* createStack(unsigned capacity)
{
    structStack* stack
        = (structStack*)malloc(sizeof(structStack));

    if(!stack)
        returnNULL;

    stack->top = -1;
    stack->capacity = capacity;
    stack->array
        = (int*)malloc(stack->capacity * sizeof(int));

    if(!stack->array)
        returnNULL;

    returnstack;
}

intisEmpty(structStack* stack)
{
    returnstack->top == -1;
}

charpeek(structStack* stack)
{
    returnstack->array[stack->top];
}

charpop(structStack* stack)
{
    if(!isEmpty(stack))
        returnstack->array[stack->top--];
    return'$';
}

voidpush(structStack* stack, charop)
{
    stack->array[++stack->top] = op;
}

// The main function that returns value 
// of a given postfix expression
intevaluatePostfix(char* exp)
{
    // Create a stack of capacity equal to expression size
    structStack* stack = createStack(strlen(exp));
    inti;

    // See if stack was created successfully
    if(!stack)
        return-1;

    // Scan all characters one by one
    for(i = 0; exp[i]; ++i) {
        
        // If the scanned character is an operand 
        // (number here), push it to the stack.
        if(isdigit(exp[i]))
            push(stack, exp[i] - '0');

        // If the scanned character is an operator, 
        // pop two elements from stack apply the operator
        else{
            intval1 = pop(stack);
            intval2 = pop(stack);
            switch(exp[i]) {
            case'+':
                push(stack, val2 + val1);
                break;
            case'-':
                push(stack, val2 - val1);
                break;
            case'*':
                push(stack, val2 * val1);
                break;
            case'/':
                push(stack, val2 / val1);
                break;
            }
        }
    }
    returnpop(stack);
}

// Driver code
intmain()
{
    charexp[] = "231*+9-";
  
    // Function call
    printf("postfix evaluation: %d", evaluatePostfix(exp));
    return0;
}
