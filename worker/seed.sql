-- seed.sql  (run once after schema: wrangler d1 execute knowledge-museum --file=seed.sql)

INSERT OR IGNORE INTO wings (id, name, era, img, description, sort_order) VALUES
('jvm',    'JVM',           'Renaissance · 文艺复兴',    'https://upload.wikimedia.org/wikipedia/commons/thumb/e/ec/Mona_Lisa%2C_by_Leonardo_da_Vinci%2C_from_C2RMF_retouched.jpg/402px-Mona_Lisa%2C_by_Leonardo_da_Vinci%2C_from_C2RMF_retouched.jpg', 'Just as Brunelleschi''s dome unified structure and grace, the JVM is the invisible cathedral beneath every Java program.', 1),
('conc',   'Concurrency',   'Baroque · 巴洛克',           'https://upload.wikimedia.org/wikipedia/commons/thumb/4/4a/The_Fighting_Temeraire%2C_JMW_Turner%2C_National_Gallery.jpg/1280px-The_Fighting_Temeraire%2C_JMW_Turner%2C_National_Gallery.jpg', 'Caravaggio''s chiaroscuro — light wrestling shadow. Threads contend, synchronize, and yield in perpetual dramatic tension.', 2),
('coll',   'Collections',   'Rococo · 洛可可',             'https://upload.wikimedia.org/wikipedia/commons/thumb/3/36/The_Swing-Fragonard.jpg/800px-The_Swing-Fragonard.jpg', 'Fragonard''s gilded swings and layered gardens. The Collections Framework — delicate, intricate, exquisitely wrought.', 3),
('mysql',  'MySQL',         'Neoclassicism · 新古典主义', 'https://upload.wikimedia.org/wikipedia/commons/thumb/3/3b/Jacques-Louis_David_-_The_Death_of_Socrates_-_Metropolitan_Museum_of_Art.jpg/1280px-Jacques-Louis_David_-_The_Death_of_Socrates_-_Metropolitan_Museum_of_Art.jpg', 'David''s austere columns and rational composition. MySQL: rigorous, structured, its indices marching in perfect B+ formation.', 4),
('redis',  'Redis',         'Romanticism · 浪漫主义',     'https://upload.wikimedia.org/wikipedia/commons/thumb/b/b9/Caspar_David_Friedrich_-_Wanderer_above_the_sea_of_fog.jpg/800px-Caspar_David_Friedrich_-_Wanderer_above_the_sea_of_fog.jpg', 'Caspar Friedrich''s wanderer above the fog. Redis: soaring above disk I/O, ephemeral yet powerful, memory as landscape.', 5),
('spring', 'Spring',        'Realism · 现实主义',          'https://upload.wikimedia.org/wikipedia/commons/thumb/8/8e/Gustave_Courbet_-_Bonjour_Monsieur_Courbet_-_Google_Art_Project.jpg/1280px-Gustave_Courbet_-_Bonjour_Monsieur_Courbet_-_Google_Art_Project.jpg', 'Courbet painted laborers, not gods. Spring is the unglamorous engine of production Java — honest, industrial, indispensable.', 6),
('sys',    'System Design', 'Impressionism · 印象派',     'https://upload.wikimedia.org/wikipedia/commons/thumb/a/a4/Claude_Monet_-_Water_Lilies_-_1906%2C_Ryerson.jpg/1280px-Claude_Monet_-_Water_Lilies_-_1906%2C_Ryerson.jpg', 'Monet''s water lilies dissolve into pure light. Distributed systems blur the lines between machines — emergent, luminous, vast.', 7),
('net',    'Network & OS',  'Post-Impressionism · 后印象派','https://upload.wikimedia.org/wikipedia/commons/thumb/e/ea/Van_Gogh_-_Starry_Night_-_Google_Art_Project.jpg/1280px-Van_Gogh_-_Starry_Night_-_Google_Art_Project.jpg', 'Cézanne rebuilt the apple with geometry. TCP, epoll, the kernel — beneath every abstraction, a rigorous geometric truth.', 8),
('algo',   'Algorithms',    'Modern Art · 现代艺术',       'https://upload.wikimedia.org/wikipedia/commons/thumb/a/a4/Piet_Mondrian%2C_1930_-_Mondrian_Composition_II_in_Red%2C_Blue%2C_and_Yellow.jpg/800px-Piet_Mondrian%2C_1930_-_Mondrian_Composition_II_in_Red%2C_Blue%2C_and_Yellow.jpg', 'Mondrian stripped painting to grid and primary color. Algorithms strip problems to their combinatorial essence — no ornament.', 9),
('proj',   'DynamoDB',      'Contemporary · 当代艺术',     'https://upload.wikimedia.org/wikipedia/commons/thumb/b/b4/Vincent_Willem_van_Gogh_128.jpg/1024px-Vincent_Willem_van_Gogh_128.jpg', 'An installation that evolves. Your lived engineering experience at Amazon — context no leetcode grinder can replicate.', 10);

INSERT OR IGNORE INTO pieces (id, wing_id, name, url, status, sort_order) VALUES
-- JVM
('jvm_1','jvm','类加载机制','https://javaguide.cn/java/jvm/class-loading-process.html','learning',1),
('jvm_2','jvm','双亲委派模型','https://javaguide.cn/java/jvm/classloader.html','learning',2),
('jvm_3','jvm','运行时数据区（堆/栈/方法区）','https://javaguide.cn/java/jvm/memory-area.html','todo',3),
('jvm_4','jvm','垃圾回收算法','https://javaguide.cn/java/jvm/jvm-garbage-collection.html','todo',4),
('jvm_5','jvm','GC 收集器（G1 / ZGC）','','todo',5),
('jvm_6','jvm','对象创建与内存布局','','todo',6),
('jvm_7','jvm','JVM 调优实战','','todo',7),
-- Concurrency
('conc_1','conc','线程生命周期与状态','','todo',1),
('conc_2','conc','synchronized 底层原理（Monitor）','','todo',2),
('conc_3','conc','volatile 与 Java 内存模型','https://javaguide.cn/java/concurrent/java-memory-model.html','todo',3),
('conc_4','conc','AQS 框架源码','https://javaguide.cn/java/concurrent/aqs.html','todo',4),
('conc_5','conc','线程池原理与参数调优','https://javaguide.cn/java/concurrent/java-thread-pool-summary.html','todo',5),
('conc_6','conc','ConcurrentHashMap 分段锁→CAS','','todo',6),
('conc_7','conc','ThreadLocal 原理与内存泄漏','','todo',7),
-- Collections
('coll_1','coll','HashMap 底层（1.8 红黑树）','','todo',1),
('coll_2','coll','ArrayList vs LinkedList','','todo',2),
('coll_3','coll','CopyOnWriteArrayList','','todo',3),
('coll_4','coll','PriorityQueue 堆结构','','todo',4),
('coll_5','coll','LinkedHashMap 与 LRU','','todo',5),
-- MySQL
('mysql_1','mysql','索引原理与 B+ 树结构','https://xiaolincoding.com/mysql/index/index_interview.html','todo',1),
('mysql_2','mysql','事务 ACID 与隔离级别','','todo',2),
('mysql_3','mysql','MVCC 原理与 ReadView','https://xiaolincoding.com/mysql/transaction/mvcc.html','todo',3),
('mysql_4','mysql','锁机制（行锁/间隙锁/意向锁）','','todo',4),
('mysql_5','mysql','执行计划与慢查询优化','','todo',5),
('mysql_6','mysql','主从复制原理','','todo',6),
('mysql_7','mysql','分库分表策略','','todo',7),
-- Redis
('redis_1','redis','五种数据结构及底层实现','https://xiaolincoding.com/redis/data_struct/command.html','todo',1),
('redis_2','redis','持久化 RDB 与 AOF','','todo',2),
('redis_3','redis','过期策略与内存淘汰算法','','todo',3),
('redis_4','redis','分布式锁（Redlock）','','todo',4),
('redis_5','redis','缓存雪崩/击穿/穿透','https://xiaolincoding.com/redis/cluster/cache_problem.html','todo',5),
('redis_6','redis','集群模式与哨兵','','todo',6),
-- Spring
('spring_1','spring','IoC 容器与 Bean 生命周期','','todo',1),
('spring_2','spring','AOP 原理（JDK动态代理/CGLIB）','','todo',2),
('spring_3','spring','Spring 事务传播机制','','todo',3),
('spring_4','spring','SpringBoot 自动配置原理','','todo',4),
('spring_5','spring','SpringMVC 请求处理链','','todo',5),
('spring_6','spring','Netty 线程模型与 NIO','','todo',6),
-- System Design
('sys_1','sys','CAP / BASE 理论','','todo',1),
('sys_2','sys','分布式事务（Saga / TCC / 2PC）','','todo',2),
('sys_3','sys','消息队列（Kafka 架构与原理）','','todo',3),
('sys_4','sys','限流（令牌桶/漏斗）熔断降级','','todo',4),
('sys_5','sys','一致性哈希','','todo',5),
('sys_6','sys','API 幂等设计','','todo',6),
('sys_7','sys','海量数据处理（BloomFilter/分片）','','todo',7),
-- Network & OS
('net_1','net','TCP 三次握手/四次挥手','https://xiaolincoding.com/network/3_tcp/tcp_interview.html','todo',1),
('net_2','net','HTTP/HTTPS/HTTP2 对比','','todo',2),
('net_3','net','I/O 多路复用（epoll 原理）','','todo',3),
('net_4','net','进程与线程的区别','','todo',4),
('net_5','net','虚拟内存与内存管理','','todo',5),
-- Algorithms
('algo_1','algo','二叉树 DFS / BFS 系列','','todo',1),
('algo_2','algo','动态规划（背包/区间/路径）','','todo',2),
('algo_3','algo','双指针 / 滑动窗口','','todo',3),
('algo_4','algo','单调栈 / 单调队列','','todo',4),
('algo_5','algo','图论（Dijkstra / Union-Find）','','todo',5),
('algo_6','algo','二分查找变体','','todo',6),
-- DynamoDB
('proj_1','proj','DynamoDB 整体架构','','todo',1),
('proj_2','proj','一致性哈希在 DynamoDB 的应用','','todo',2),
('proj_3','proj','向量时钟与版本冲突解决','','todo',3),
('proj_4','proj','Gossip 协议','','todo',4),
('proj_5','proj','最终一致性调优','','todo',5),
('proj_6','proj','我负责模块的实现亮点（STAR）','','todo',6);
