// Carlos Lazo
// ECE 579D
// Homework 02

char and (char a, char b)
{
	if ((a=='0')||(b=='0')) return '0';
	else if ((a=='1')&&(b=='1')) return '1';
	else return 'X';
}

char or (char a, char b)
{
	if ((a=='1')||(b=='1')) return '1';
	else if ((a=='0')&&(b=='0')) return '0';
	else return 'X';
}

char not (char a)
{
	if (a=='1') return '0';
	else if (a=='0') return '1';
	else return 'X';
}

char tri (char a, char c)
{
	if (c=='1') return a;
	else return 'Z';
}

char resolve (char a, char b)
{
	if (a=='Z' || a==b) return b;
	else if (b=='Z') return a;
	else return 'X';
}

void and (char a[], char b[], char w[])
{
	int i=0;
	while (a[i] != '\0') {
		w[i] = and (a[i], b[i]);
		i++;
	};
	w[i] = '\0';
}

void or (char a[], char b[], char w[])
{
	int i=0;
	while (a[i] != '\0') {
		w[i] = or (a[i], b[i]);
		i++;
	};
	w[i] = '\0';
}

void tri (char a[], char c, char w[])
{
	int i=0;
	while (a[i] != '\0') {
		w[i] = tri (a[i], c);
		i++;
	};
	w[i] = '\0';
}

void resolve (char a[], char b[], char w[])
{
	int i=0;
	while (a[i] != '\0') {
		w[i] = resolve (a[i], b[i]);
		i++;
	};
	w[i] = '\0';
}

char xor (char a, char b)
{
	if ((a=='X')||(b=='X')||(a=='Z')||(b=='Z')) return 'X';
	else if (a==b) return '0';
	else return '1';
}

void fullAdder (char a, char b, char ci, char & co, char & sum)
{
	char axb, ab, abc;

	axb = xor (a, b);
	ab  = and (a, b);
	abc = and (axb, ci);
	co = or (ab, abc);
	sum = xor (axb, ci);
}

// File modified to include the definition for a D Flip-Flop.
// It clocks on posedge, is asynchronous, and is active-low.

void dff_PAH (char D, char clk, char reset, char&Q)
{
  if (reset == '1')
      Q = '0';
  else if (clk == 'P')
      Q = D;
}
