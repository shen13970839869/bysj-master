数据库
create database onlinetest charset utf8;

create user 'zj'@'localhost' identified by '123';

grant all on onlinetest.*to 'zj'@'localhost';

mysql -u zj -p123 onlinetest


角色表
create table role(
roleid int(11) not null auto_increment,
rolename varchar(20) default null,
primary key(roleid));

INSERT INTO role VALUES ('1', '老师');
INSERT INTO role VALUES ('2', '学生');
INSERT INTO role VALUES ('3', '管理员');

班级表
create table pjclass(
classid int(11) not null  auto_increment,
classname varchar(20) default null,
primary key(classid) );

INSERT INTO pjclass VALUES ('1', '软件17-1');
INSERT INTO pjclass VALUES ('2', '软件17-2');
INSERT INTO pjclass VALUES ('3', '计网17-1');
INSERT INTO pjclass VALUES ('4', '无');
用户表
create table users (
userid int(11) not null auto_increment,
roleid int(11) default null,
username varchar(20) default null,
userpwd varchar(20) default null,
truename varchar(30) default null,
classid int(11),
primary key(userid),
unique key (username),
key fk_relationship_1(roleid),
constraint fk_relationship_1 foreign key(roleid)references role(roleid));

INSERT INTO users VALUES ('1', '3', 'admin', '12345', '管理员','1');
INSERT INTO users VALUES ('2','1', 'rj0001', '12345', '王林','1');
INSERT INTO users VALUES ('3', '2', '17510001', '11111', '张三丰','1');
INSERT INTO users VALUES ('4', '2', '17510002', '12345', '李四','2');
INSERT INTO users VALUES ('5', '2', '17510003', '12345', '王五','1');


create table course (
cno  int(11) not null auto_increment,
cname varchar(20) not null,
primary key(cno)
);
INSERT INTO course VALUES ('1','软件工程');
INSERT INTO course VALUES ('2','软件测试');

考试表
create table exam(
eid int(11) not null auto_increment,
pname varchar(20) not null,
cno int(11) not null,
userid int(11) not null,
classid int(11) not null,
singlenumber int(3) not null,
singlecore int(3) not null,
multiplenumber int(3) not null,
multiplecore int(3) not null,
examdate date not null,
examtime date not null,
testtime int(3) not null,
primary key(eid),
key fk_relationship_2 (userid),
constraint fk_relationship_2 foreign key(userid)references users(userid),
key fk_relationship_3 (classid),
constraint fk_relationship_3 foreign key(classid)references pjclass(classid),
key fk_relationship_4 (cno),
constraint fk_relationship_4 foreign key(cno)references course(cno));

问题类型表
create table type (
stype int(3) not null auto_increment,
name varchar(30) not null,
primary key(stype));
INSERT INTO type VALUES ('1','一，单选题');
INSERT INTO type VALUES ('2','二，多选题');
试题表
create table subject(
sid int(11) not null auto_increment,
cno int(11) not null,
stype int (3) not null,
scontent varchar(255) not null,
sa varchar(255) not null,
sb varchar(255) not null,
sc varchar(255) not null,
sd varchar(255) not null,
skey varchar(255) not null,
primary key(sid),
unique key (scontent),
key fk_relationship_5 (cno),
constraint fk_relationship_5 foreign key(cno)references  course(cno)
);
insert into subject values('1','2','1', '软件测试的目的是(___)', '试验性运行软件', '发现软件错误', '证明软件正确', '找出软件中全部错误', 'B');
insert into subject values ('2', '2','1','在一个长度为n的顺序表的表尾插入一个新元素的渐进时间复杂度为', 'O (n)', 'O (1)', 'O (n2 )', 'O (log2 n)', 'A');
insert into subject values ('3','1','1', '计算机系统中的存贮器系统是指', 'RAM存贮器', 'ROM存贮器', '主存贮器', 'cache、主存贮器和外存贮器', 'D');
insert into subject values ('4','1','1', '某机字长32位，其中1位符号位，31位表示尾数。若用定点小数表示，则最大正小数为', '+（1 – 2-32）', '+（1 – 2-31）', '2-32', '2-31', 'B');
insert into subject values('5', '1','1','算术 / 逻辑运算单元74181ALU可完成', '16种算术运算功能', '16种逻辑运算功能', '16种算术运算功能和16种逻辑运算功能', '4位乘法运算和除法运算功能', 'C');
insert into subject values('6','1', '1','存储单元是指', '存放一个二进制信息位的存贮元', '存放一个机器字的所有存贮元集合', '存放一个字节的所有存贮元集合', '存放两个字节的所有存贮元集合；', 'B');


成绩表
create table studentexam(
seid int(11) not null auto_increment,
userid int(11) not null,
classid int(11) not null,
eid int(11) not null,
pname varchar(20) not null,
zscore int(3) not null,
score int(3) not null,
tjtime datetime not null,
primary key(seid),
key fk_relationship_6 (userid),
constraint fk_relationship_6 foreign key(userid)references users(userid),
key fk_relationship_7 (classid),
constraint fk_relationship_7 foreign key(classid)references pjclass(classid),
key fk_relationship_8 (eid),
constraint fk_relationship_8 foreign key(eid)references exam(eid)
);

答卷表
create table studentsubject(
ssid int(11) not null auto_increment,
seid int(11) not null ,
userid int(11) not null,
eid int(11) not null,
sid int(11) not null,
studentkey varchar(10) not null,
primary key(ssid),
key fk_relationship_9 (seid),
constraint fk_relationship_9 foreign key(seid)references studentexam(seid),
key fk_relationship_10(userid),
constraint fk_relationship_10 foreign key(userid)references users(userid),
key fk_relationship_11(eid),
constraint fk_relationship_11 foreign key(eid)references exam(eid),
key fk_relationship_12(sid),
constraint fk_relationship_12 foreign key(sid)references subject(sid));

试卷题表
create table paper(
pid int(11) not null auto_increment,
eid  int(11) not null,
sid  int(11) not null,
cno int(11) not null,
stype int (3) not null,
scontent varchar(255) not null,
sa varchar(255) not null,
sb varchar(255) not null,
sc varchar(255) not null,
sd varchar(255) not null,
skey varchar(255) not null,
primary key(pid),
key fk_relationship_13(eid),
constraint fk_relationship_13 foreign key(eid)references exam(eid),
key fk_relationship_14(sid),
constraint fk_relationship_14 foreign key(sid)references subject(sid));


 @GeneratedValue(strategy =GenerationType.IDENTITY)
