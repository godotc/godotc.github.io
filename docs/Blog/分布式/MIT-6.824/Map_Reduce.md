# Map Reduce : Simplified data processing on large Cluster

> 阅读 Map Reduce 进行记录的引用
> https://www.usenix.org/legacy/event/osdi04/tech/full_papers/dean/dean_html/
## Situation
1. Crawled documents 处理爬取的文档
2. Handle failures and conspire to obscure 处理失败耗费大量的代码来处理

## Section
1. Introduction
2. Basic programing model
3. Cluster environment implementation
4. Refinements (改良品) of programing model
5. Performance measurements (of implementation in variety tasks)
6.  Explores about actual use, rewrite production indexing system （生产索引系统）
7. Discuss future relate work

## Content
### 2. Programming model
- Input: set of key-value pairs
- Output:  same set of key-value pairs

#### - Map
>_Map_, written by the user, takes an input pair and produces a set of _intermediate_ key/value pairs. The MapReduce library groups together all intermediate values associated with the same intermediate key $I$ and passes them to the _Reduce_ function.

1.Take input pairs
2. Produce (生成) **intermediate** pairs
3. Groups/Classify 
4. Make *Intermediate* values **associated** same *intermediate* key
5. Passes to *Reduce*

#### - Reduce
>The _Reduce_ function, also written by the user, accepts an intermediate key ![$I$](https://www.usenix.org/legacy/event/osdi04/tech/full_papers/dean/dean_html/img1.png) and a set of values for that key. It merges together these values to form a possibly smaller set of values. Typically just zero or one output value is produced per _Reduce_ invocation. The intermediate values are supplied to the user's reduce function via an iterator. This allows us to handle lists of values that are too large to fit in memory.

1. Accepts *Intermediate* key **$I$** and **a set of values for $I$ 
2. Merges together these value possibly to a **smaller** set of value
3. Typically (一般) generate 0~1 output 
4. Reduce too large data to fit in memory

#### - Example
- 统计关键词，先map每个词的 occurrence times， 在 Reduce 计算出 给定的 **n** 个key word
- 首页排序， 先 map 出所有帖子的热度， 在reduce出顺序
- ...
![](attachments/Pasted%20image%2020220906015451.png)
### 3. Execution Overview
####  1. Master Data Structures
- State: idle, in-progress, completed
- Worker identity(none-idle)
- Reduce files' regions: locations, size

#### 2. Fault Tolerance
#####  Worker Failure
- Method: Periodically *ping* from master to worker in a certain time
- Handle:
	1. Any map/reduce tasks completed by **this worker** are reset to initial **idle** state
	2. Become eligible（合适的）Scheduling (调度) on other workers

#####  Master Failure
1. Write/Record checkpoints of master **data structure** 
2. A new copy started in the last checkpointed state when exception

##### Semantics in the Presence of Failures
(失败情况下的语义)
> A reduce task produces one such file, and a map task produces $R$ such files (one per reduce task). When a map task completes, the worker sends a message to the master and includes the names of the $R$ temporary files in the message. If the master receives a completion message for an already completed map task, it ignores the message. Otherwise, it records the names of $R$ files in a master data structure.
- complete task

>When a reduce task completes, the reduce worker atomically renames its temporary output file to the final output file. If the same reduce task is executed on multiple machines, multiple rename calls will be executed for the same final output file. We rely on the atomic rename operation provided by the underlying file system to guarantee that the final file system state contains just the data produced by one execution of the reduce task.
- Atomic operator (rename output file)

#### 3. Locality (本地化)
- 多副本， 本地地进行M and R, 减少网络开销
- 3 copies in multiple machines
- Map locations (映射位置) in every machines
- If failed, replica a task near the input data, reduce network cost
#### 4. Task Granularity(任务粒度)
- 负载均衡
- R:M 200000 : 5000 , 2000 worker machines

#### 5. Backup Tasks
- straggler (掉队者)  lengthens the total time
- Mark as completed and back-up to a **almost complete** task

### 4. Refinements(优化)
1. Partitioning Function(拆解函数/流程)
2. Ordering Guarantees (M_P 顺序保证)
3. Combiner Function
4. Input and Output Types
	1. text treats each-line as key-value
	2. Input automatically **split** into meaningful range of sperate MAP task 
5. Side-effects(没理解到)
6. Skipping Bad Records
7. Local Execution
8. Status Information (内置 http 主页， 显示集群健康)
9. Counters (统计，实时观测进度，避免重复taski; 校验完整性)

### 5. Performance
Some experiment test output data shows the performance promote.

### 6. Experience
-   大规模的机械学习的问题，
-   集群问题的谷歌新闻和Froogle产品，
-   提取的数据用来制作报告的流行查询 (例如谷歌的时代精神的),
-   提取的特性的网页的新实验 产品(例如提取的地理位置，从一个大的网页为本地化的搜索)，
-   大规模曲线图计算。

### 7. Relate Work


## Conclusion
- Effective model
- Easy to use (even coder without distribution experience)
- Distribution and Parallel get more **fault-tolerance** by limit in model
- Network resource are scarcity(稀缺的)， Optimizer for local execution and reduce data-send and cross-regions
- Partitioning Function and redundancy(冗余的) steps can reduce the effect of slow machines and "straggler"(掉队者) . Can handle exception of machine and data lose (检查点)