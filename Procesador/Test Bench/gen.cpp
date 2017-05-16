#include <bits/stdc++.h>
#define endl '\n'
#define debug(X) cout << #X << " = " << X << endl;
#define fori(i,b,e) for (int i = (b); i < (e); ++i)

using namespace std;

typedef long long ll;
typedef vector<int> vi;
typedef pair<int, int> ii;
typedef vector<ii> vii;

const int INF = 1e9;

int main() {
  ios_base::sync_with_stdio(false); cin.tie(0);
  stack<string> qs;
  string s;
  while (cin >> s)
  	qs.push(s);
  for (int i = 0; !qs.empty(); i++) {
  	if (i and (i % 2) == 0) cout << endl;
  	cout << "\"" << qs.top() << "\", ", qs.pop();
  }
  cout << endl;
  return 0;
}