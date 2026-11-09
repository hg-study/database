-- =======================================
-- 파일 업로드와 다운로드
-- longblob 컬럼에 파일 저장(load_file)하고 파일로 내려받기(into dumpfile)
-- =======================================
-- load_file(), into dumpfile은 secure_file_priv로 지정된 폴더의 파일만 사용할 수 있다
create database testdb;
use testdb;

create table tbl_file(
	title varchar(50),
    filedata longblob
);

desc tbl_file;
select * from tbl_file;

delete from tbl_file;
select * from tbl_file;

-- 업로드
insert into tbl_file
values('test1.exe',load_file('c:\\sql\\test1.exe'));

insert into tbl_file
values('test2.jpg',load_file('c:\\sql\\test2.jpg'));

use testdb;
select * from tbl_file;

-- 다운로드
select filedata from tbl_file where title='test1.exe'
into dumpfile 'c:\\sql\\test1_copy.exe';
