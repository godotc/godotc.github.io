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

### 282. Trie Tree (前缀树)
Source url : https://github.com/godotc/All-Go-Rhyme/blob/master/leetcode/208.cc

现在是 2022/9/11 5:11 AM

浪费了5个小时，想了一堆逻辑来判定返回值 (startWith()), 结果只需要 return true 就行了
我是不是开始老年痴呆了？
或者说，这就应该是我本来的水平?

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