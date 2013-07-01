// Carlos Lazo
// ECE 579D
// Homework 02

char and (char a, char b);
char or (char a, char b);
char not (char a);
char tri (char a, char c);
char resolve (char a, char c);

void and (char a[], char b[], char w[]);
void or (char a[], char b[], char w[]);
void tri (char a[], char c, char w[]);
void resolve (char a[], char b[], char w[]);

char xor (char a, char b);
void fullAdder (char a, char b, char ci, char & co, char & sum);

// File modified to include the definition for a D Flip-Flop

void dff_PAH (char D, char clk, char reset, char&Q);
