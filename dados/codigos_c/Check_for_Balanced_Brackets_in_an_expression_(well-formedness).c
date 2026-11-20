/* Problema: Check for Balanced Brackets in an expression (well-formedness)
 * Complexidade de Tempo: O(N)
 * Complexidade de Espaco: O(N)
 * Fonte: https://www.geeksforgeeks.org/check-for-balanced-parentheses-in-an-expression/
 */

#include <stdio.h>
#include <stdlib.h>
#define bool int

// Structure of a stack node
structsNode {
    chardata;
    structsNode* next;
};

// Function to push an item to stack
voidpush(structsNode** top_ref, intnew_data);

// Function to pop an item from stack
intpop(structsNode** top_ref);

// Returns 1 if character1 and character2 are matching left
// and right Brackets
boolisMatchingPair(charcharacter1, charcharacter2)
{
    if(character1 == '('&& character2 == ')')
        return1;
    elseif(character1 == '{'&& character2 == '}')
        return1;
    elseif(character1 == '['&& character2 == ']')
        return1;
    else
        return0;
}

// Return 1 if expression has balanced Brackets
boolareBracketsBalanced(charexp[])
{
    inti = 0;

    // Declare an empty character stack
    structsNode* stack = NULL;

    // Traverse the given expression to check matching
    // brackets
    while(exp[i]) {
        // If the exp[i] is a starting bracket then push
        // it
        if(exp[i] == '{'|| exp[i] == '('|| exp[i] == '[')
            push(&stack, exp[i]);

        // If exp[i] is an ending bracket then pop from
        // stack and check if the popped bracket is a
        // matching pair*/
        if(exp[i] == '}'|| exp[i] == ')'
            || exp[i] == ']') {

            // If we see an ending bracket without a pair
            // then return false
            if(stack == NULL)
                return0;

            // Pop the top element from stack, if it is not
            // a pair bracket of character then there is a
            // mismatch.
            // his happens for expressions like {(})
            elseif(!isMatchingPair(pop(&stack), exp[i]))
                return0;
        }
        i++;
    }

    // If there is something left in expression then there
    // is a starting bracket without a closing
    // bracket
    if(stack == NULL)
        return1; // balanced
    else
        return0; // not balanced
}

// Driver code
intmain()
{
    charexp[100] = "{()}[]";

    // Function call
    if(areBracketsBalanced(exp))
        printf("Balanced \n");
    else
        printf("Not Balanced \n");
    return0;
}

// Function to push an item to stack
voidpush(structsNode** top_ref, intnew_data)
{
    // allocate node
    structsNode* new_node
        = (structsNode*)malloc(sizeof(structsNode));

    if(new_node == NULL) {
        printf("Stack overflow n");
        getchar();
        exit(0);
    }

    // put in the data
    new_node->data = new_data;

    // link the old list of the new node
    new_node->next = (*top_ref);

    // move the head to point to the new node
    (*top_ref) = new_node;
}

// Function to pop an item from stack
intpop(structsNode** top_ref)
{
    charres;
    structsNode* top;

    // If stack is empty then error
    if(*top_ref == NULL) {
        printf("Stack overflow n");
        getchar();
        exit(0);
    }
    else{
        top = *top_ref;
        res = top->data;
        *top_ref = top->next;
        free(top);
        returnres;
    }
}
