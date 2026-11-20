/* Problema: Convert Infix expression to Postfix expression
 * Complexidade de Tempo: O(N)
 * Complexidade de Espaco: O(N)
 * Fonte: https://www.geeksforgeeks.org/convert-infix-expression-to-postfix-expression/
 */

// C code to convert infix to postfix expression

#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#define MAX_EXPR_SIZE 100

// Function to return precedence of operators
intprecedence(charoperator)
{
    switch(operator) {
    case'+':
    case'-':
        return1;
    case'*':
    case'/':
        return2;
    case'^':
        return3;
    default:
        return-1;
    }
}

// Function to check if the scanned character 
// is an operator
intisOperator(charch)
{
    return(ch == '+'|| ch == '-'|| ch == '*'|| ch == '/'
            || ch == '^');
}

// Main functio to convert infix expression
// to postfix expression
char* infixToPostfix(char* infix)
{
    inti, j;
    intlen = strlen(infix);
    char* postfix = (char*)malloc(sizeof(char) * (len + 2));
    charstack[MAX_EXPR_SIZE];
    inttop = -1;

    for(i = 0, j = 0; i < len; i++) {
        if(infix[i] == ' '|| infix[i] == '\t')
            continue;
      
        // If the scanned character is operand
        // add it to the postfix expression
        if(isalnum(infix[i])) {
            postfix[j++] = infix[i];
        }
      
        // if the scanned character is '('
        // push it in the stack
        elseif(infix[i] == '(') {
            stack[++top] = infix[i];
        }
      
        // if the scanned character is ')'
        // pop the stack and add it to the 
        // output string until empty or '(' found
        elseif(infix[i] == ')') {
            while(top > -1 && stack[top] != '(')
                postfix[j++] = stack[top--];
           
                top--;
        }
      
        // If the scanned character is an operator
        // push it in the stack
        elseif(isOperator(infix[i])) {
            while(top > -1
                   && precedence(stack[top])
                          >= precedence(infix[i]))
                postfix[j++] = stack[top--];
            stack[++top] = infix[i];
        }
    }

    // Pop all remaining elements from the stack
    while(top > -1) {
        if(stack[top] == '(') {
            return"Invalid Expression";
        }
        postfix[j++] = stack[top--];
    }
    postfix[j] = '\0';
    returnpostfix;
}

// Driver code
intmain()
{
    charinfix[MAX_EXPR_SIZE] = "a+b*(c^d-e)^(f+g*h)-i";
  
    // Function call
    char* postfix = infixToPostfix(infix);
    printf("%s\n", postfix);
    free(postfix);
    return0;
}
