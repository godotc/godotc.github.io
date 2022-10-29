### 9. Palindrome
```c++
bool isPalindrome(int x){
	auto str = std::to_string（x);

	int l=0, r=size-1;
	while(l<r){
		if(str[l]==str[r])
		{++l;--r;}
		else return false;
	}
	return true;
}
```

```c++
    bool isPalindrome(int x) {

       if(x<0) return false;
        long long  y =x;
        long long  temp = 0;
       while(y>0){
           temp=temp*10+y%10;
           y/=10;
       }


      return temp==x?true:false;
    }
```
---
### 155. 包含min函数的栈
用一个栈来存储，一个栈来记录最小值

---
### 138. 复杂链表的复制
1. Hash Map 存储每个节点对应的node
```cpp
 Node* copyRandomList(Node* head) {
        if (!head) return nullptr;
        Node* it = head;
        map<Node*,Node*> kv;
        // 创建与原来链表对应的节点
        while(it){
            kv[it] = new Node(it->val);
            it = it ->next;
        }
		// 附上原链表对应的指针的map的值
        it = head;
        while(it){
            kv[it]->next= kv[it->next];
            kv[it]->random = kv[it->random];
            it = it -> next;
        }

        return kv[head];
```
2. 拼接原链表，三次遍历
```cpp
    Node* copyRandomList(Node* head) {
        if (!head) return nullptr;
        Node* it = head;
		// 创造复制节点
        while(it){
            Node* temp = it->next;
            it->next = new Node(it->val);
            it->next->next = temp;
            it = it->next->next;
        }
        // 复制 random 指针
        it = head;
        while(it){
            Node* copy = it->next;    
            if(it->random){
                copy->random=it->random->next;
            }
            it=copy->next;
        }
        // 拼接复原两个链表
        it = head;
        Node* ret = head->next;
        Node* copy = ret;
        while(it->next->next){
            it->next = it->next->next;
            copy->next = copy->next->next;
            it=it->next;
            copy=copy->next;
        }
        
        it->next = nullptr; 
        return ret;
    }
```

---

### 282. Trie Tree (前缀树)
Source url : https://github.com/godotc/All-Go-Rhyme/blob/master/leetcode/208.cc

现在是 2022/9/11 5:11 AM

浪费了5个小时，想了一堆逻辑来判定返回值 (startWith()), 结果只需要 return true 就行了
我是不是开始老年痴呆了？
或者说，这就应该是我本来的水平?

---
### 412. Fizz Buzz
[ 转字符串](../C_Cpp/字符串处理.md#1%20转字符串)

---
### 828. 统计字串中的唯一字符
- Timeout method
```cpp
- old 
int countUniqueChars(string& s){ 
	int ret =0;
	vector<int> chars(128,0); 
	for(char i : s){ 
		chars[i]+=1; 
	}
	for(int i : chars){ 
		if(i==1) ret+=1; 
	}
	return ret;
}
- in dp
int countUniqueChars(string& s){
	int ret =0;
	vector<int> close(128,-1);
	vector<int> secondClose(128,-1);
	for(int i =0; i<s.size(); ++i){
		char ch = s[i];
		if(close[ch]==-1){
			++ret;
			close[ch]==i;
		}else{
			if(secondClose[ch]==-1){
				--ret;
				secondClose[ch]=close[ch];
				close[ch]=i;
			}
		}
	}
}

void generateAllSubStrs(string& s, int idx, vector<string>&substrs){
	for(int i =s.size();i>idx; --i)
	{ 
		substrs.push_back(s.substr(idx,i-idx)); 
	} 																   } 

int uniqueLetterString(string s) 
{ 
	int n = s.size();
	vector<string> substrs;
	for(int i = 0;i<n;++i){
		 generateAllSubStrs(s , i, substrs);
	 }
	int ret = 0;
	for(auto s: substrs){
	    ret += countUniqueChars(s); 
	}
	return ret; 
}								 
```
- Dynamic Plan
```cpp

```

### 866. Prime Palindrome
```c++
// Origin ver. timeout...
int primePalindrome(int n) {
	if(n==1)return 2;
	int origin = n;
	while(1)
	{
		int i = 2;
		for(; i<=n;++i){
			if(n%i==0){
				break;
			}
		}
		if(i>=origin){
			if(isPalindrome(i))
				return n;
		} 
		n++;
	}
	return n;
}
```
- [ ] TODO: update is_prime algoritme

---
### 950. 按递增顺序显示卡牌
思路：将查看牌的操作倒过来，我们每次放入卡片的时候，先将底部的卡片放到顶上来
```cpp
vector<int> deckRevealedIncreasing(vector<int>& deck) {

	sort(deck.begin(),deck.end(),greater<int>());
	deque<int>  deq;
	int n= deck.size();

	for(int i =0;i<n;++i)
	{
		if(!deq.empty()){
			deq.push_front(deq.back());
			deq.pop_back();
		}
		deq.push_front(deck[i]);
	}

	return vector<int>(deq.begin(),deq.end());
}
```


---
### offer 12 dfs
```cpp
#include <iostream>
#include <vector>

using namespace std;

class Solution {
 public:
  int m, n;
  int len;

  bool dfs(int x, int y, vector<vector<char>> &board, int idx, string &word,
           vector<vector<bool>> &visited) {
    if (idx == len) return true;

    for (int i = -1; i <= 1; ++i) {
      if (x + i < 0 || x + i >= m) continue;

      for (int j = -1; j <= 1; ++j) {
        if (i == 0 && j == 0) continue; // 本身
		if(i==j || i==-1) continue; //四角
        if (y + j < 0 || y + j >= n) continue; // 越界
        if (visited[x + i][y + j]) continue; // 前置节点
        if (board[x + i][y + j] == word[idx]) {
          visited[x + i][y + j] = true;
          int ret = dfs(x + i, y + j, board, idx + 1, word, visited);
			if(ret) return true;
        }
      }
    }
    visited[x][y] = false;
    return false;
  }

  bool exist(vector<vector<char>> &board, string word) {
    m = board.size();
    n = board[0].size();
    len = word.size();

    vector<vector<bool>> visited(m, {vector<bool>(n, false)});

    char ch = word[0];

    for (int i = 0; i < m; ++i) {
      for (int j = 0; j < n; ++j) {
        if (board[i][j] == ch) {
          visited[i][j] = true;
          bool ret = dfs(i, j, board, 1, word, visited);
          if (ret) return true;
        }
      }
    }

    return false;
  }
};

int main() {
  vector<vector<char>> test = {
      {'A', 'B', 'C', 'E'}, {'S', 'F', 'C', 'S'}, {'A', 'D', 'E', 'E'}};

  string word = "ABCCED";

  Solution s;

  cout << s.exist(test, word);
```
