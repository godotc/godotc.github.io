## BM29 二叉树中和为某一值的路径
```cpp
   bool assertSum(TreeNode* node,int temp, int sum) {
        if(!node){
            return false; 
        }
        temp+= node->val;
        
        if(temp==sum){
            if(!node->left&&!node->right)
                return true;
        }
        // key or operator
        return assertSum(node->left, temp, sum)||assertSum(node->right, temp, sum);
    }
    
    bool hasPathSum(TreeNode* root, int sum) {
        // write code here
        int temp =0;
        return assertSum(root,temp,sum);
    }
```