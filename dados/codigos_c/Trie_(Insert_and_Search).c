/* Problema: Trie | (Insert and Search)
 * Complexidade de Tempo: O(M)
 * Complexidade de Espaco: None
 * Fonte: https://www.geeksforgeeks.org/trie-insert-and-search/
 */

// C implementation of search and insert operations
// on Trie
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <stdbool.h>

#define ARRAY_SIZE(a) sizeof(a)/sizeof(a[0])

// Alphabet size (# of symbols)
#define ALPHABET_SIZE (26)

// Converts key current character into index
// use only 'a' through 'z' and lower case
#define CHAR_TO_INDEX(c) ((int)c - (int)'a')

// trie node
structTrieNode
{
    structTrieNode *children[ALPHABET_SIZE];

    // isEndOfWord is true if the node represents
    // end of a word
    boolisEndOfWord;
};

// Returns new trie node (initialized to NULLs)
structTrieNode *getNode(void)
{
    structTrieNode *pNode = NULL;

    pNode = (structTrieNode *)malloc(sizeof(structTrieNode));

    if(pNode)
    {
        inti;

        pNode->isEndOfWord = false;

        for(i = 0; i < ALPHABET_SIZE; i++)
            pNode->children[i] = NULL;
    }

    returnpNode;
}

// If not present, inserts key into trie
// If the key is prefix of trie node, just marks leaf node
voidinsert(structTrieNode *root, constchar*key)
{
    intlevel;
    intlength = strlen(key);
    intindex;

    structTrieNode *pCrawl = root;

    for(level = 0; level < length; level++)
    {
        index = CHAR_TO_INDEX(key[level]);
        if(!pCrawl->children[index])
            pCrawl->children[index] = getNode();

        pCrawl = pCrawl->children[index];
    }

    // mark last node as leaf
    pCrawl->isEndOfWord = true;
}

// Returns true if key presents in trie, else false
boolsearch(structTrieNode *root, constchar*key)
{
    intlevel;
    intlength = strlen(key);
    intindex;
    structTrieNode *pCrawl = root;

    for(level = 0; level < length; level++)
    {
        index = CHAR_TO_INDEX(key[level]);

        if(!pCrawl->children[index])
            returnfalse;

        pCrawl = pCrawl->children[index];
    }

    return(pCrawl->isEndOfWord);
}

// Driver
intmain()
{
    // Input keys (use only 'a' through 'z' and lower case)
    charkeys[][8] = {"the", "a", "there", "answer", "any",
                     "by", "bye", "their"};

    charoutput[][32] = {"Not present in trie", "Present in trie"};


    structTrieNode *root = getNode();

    // Construct trie
    inti;
    for(i = 0; i < ARRAY_SIZE(keys); i++)
        insert(root, keys[i]);

    // Search for different keys
    printf("%s --- %s\n", "the", output[search(root, "the")] );
    printf("%s --- %s\n", "these", output[search(root, "these")] );
    printf("%s --- %s\n", "their", output[search(root, "their")] );
    printf("%s --- %s\n", "thaw", output[search(root, "thaw")] );

    return0;
}
