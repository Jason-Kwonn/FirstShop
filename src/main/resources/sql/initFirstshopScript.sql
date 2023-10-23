# MySql ver.

DROP TABLE IF EXISTS transaction;
DROP TABLE IF EXISTS product;
DROP TABLE IF EXISTS users;

# Oracle version create sequence
# DROP SEQUENCE ;
# DROP SEQUENCE seq_transaction_tran_no;
# CREATE SEQUENCE 	 	INCREMENT BY 1 START WITH 10000;
# CREATE SEQUENCE seq_transaction_tran_no	INCREMENT BY 1 START WITH 10000;
USE firstshop;

CREATE TABLE users (
                       user_pk BIGINT NOT NULL AUTO_INCREMENT PRIMARY KEY,
                       user_id VARCHAR(20) NOT NULL,
                       user_name VARCHAR(50) NOT NULL,
                       password VARCHAR(10) NOT NULL,
                       role VARCHAR(5) DEFAULT 'user',
                       ssn VARCHAR(13),
                       cell_phone VARCHAR(14),
                       addr VARCHAR(100),
                       email VARCHAR(50),
                       reg_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP
) AUTO_INCREMENT=10000;


CREATE TABLE product (
                         prod_no INT AUTO_INCREMENT PRIMARY KEY,
                         prod_name VARCHAR(100) NOT NULL,
                         prod_detail VARCHAR(200),
                         manufacture_day VARCHAR(8),
                         price INT,
                         quantity INT,
                         likes INT,
                         see INT,
                         image_file VARCHAR(100),
                         reg_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP
) AUTO_INCREMENT=10000;

# ALTER TABLE product ADD COLUMN (
#     quantity INT,
#     likes INT,
#     see INT
#     );
#
# select *
# from product;



CREATE TABLE transaction (
                             tran_no INT AUTO_INCREMENT PRIMARY KEY,
                             prod_no INT NOT NULL,
                             buyer_id VARCHAR(20) NOT NULL,
                             payment_option CHAR(3),
                             receiver_name VARCHAR(20),
                             receiver_phone VARCHAR(14),
                             dlvy_addr VARCHAR(100),
                             dlvy_request VARCHAR(100),
                             tran_status_code CHAR(3),
                             order_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
                             dlvy_date TIMESTAMP
) AUTO_INCREMENT=10000;



INSERT
INTO users (user_id, user_name, password, role, ssn, cell_phone, addr, email, reg_date )
VALUES ('admin', 'admin', '1234', 'admin', NULL, NULL, '서울시 서초구', 'admin@mvc.com', str_to_date('2012/01/14 10:48:43', '%Y/%m/%d %H:%i:%s'));

INSERT
INTO users ( user_id, user_name, password, role, ssn, cell_phone, addr, email, reg_date )
VALUES ( 'manager', 'manager', '1234', 'admin', NULL, NULL, NULL, 'manager@mvc.com', str_to_date('2012/01/14 10:48:43', '%Y/%m/%d %H:%i:%s'));

INSERT INTO users ( user_id, user_name, password, role, ssn, cell_phone, addr, email, reg_date )
VALUES ( 'user01', 'SCOTT', '1111', 'user', NULL, NULL, NULL, NULL, NOW());

INSERT INTO users ( user_id, user_name, password, role, ssn, cell_phone, addr, email, reg_date )
VALUES ( 'user02', 'SCOTT', '2222', 'user', NULL, NULL, NULL, NULL, NOW());

INSERT INTO users ( user_id, user_name, password, role, ssn, cell_phone, addr, email, reg_date )
VALUES ( 'user03', 'SCOTT', '3333', 'user', NULL, NULL, NULL, NULL, NOW());

INSERT INTO users ( user_id, user_name, password, role, ssn, cell_phone, addr, email, reg_date )
VALUES ( 'user04', 'SCOTT', '4444', 'user', NULL, NULL, NULL, NULL, NOW());

INSERT INTO users ( user_id, user_name, password, role, ssn, cell_phone, addr, email, reg_date )
VALUES ( 'user05', 'SCOTT', '5555', 'user', NULL, NULL, NULL, NULL, NOW());

INSERT INTO users ( user_id, user_name, password, role, ssn, cell_phone, addr, email, reg_date )
VALUES ( 'user06', 'SCOTT', '6666', 'user', NULL, NULL, NULL, NULL, NOW());

INSERT INTO users ( user_id, user_name, password, role, ssn, cell_phone, addr, email, reg_date )
VALUES ( 'user07', 'SCOTT', '7777', 'user', NULL, NULL, NULL, NULL, NOW());

INSERT INTO users ( user_id, user_name, password, role, ssn, cell_phone, addr, email, reg_date )
VALUES ( 'user08', 'SCOTT', '8888', 'user', NULL, NULL, NULL, NULL, NOW());

INSERT INTO users ( user_id, user_name, password, role, ssn, cell_phone, addr, email, reg_date )
VALUES ( 'user09', 'SCOTT', '9999', 'user', NULL, NULL, NULL, NULL, NOW());

INSERT INTO users ( user_id, user_name, password, role, ssn, cell_phone, addr, email, reg_date )
VALUES ( 'user10', 'SCOTT', '1010', 'user', NULL, NULL, NULL, NULL, NOW());

INSERT INTO users ( user_id, user_name, password, role, ssn, cell_phone, addr, email, reg_date )
VALUES ( 'user11', 'SCOTT', '1111', 'user', NULL, NULL, NULL, NULL, NOW());

INSERT INTO users ( user_id, user_name, password, role, ssn, cell_phone, addr, email, reg_date )
VALUES ( 'user12', 'SCOTT', '1212', 'user', NULL, NULL, NULL, NULL, NOW());

INSERT INTO users ( user_id, user_name, password, role, ssn, cell_phone, addr, email, reg_date )
VALUES ( 'user13', 'SCOTT', '1313', 'user', NULL, NULL, NULL, NULL, NOW());

INSERT INTO users ( user_id, user_name, password, role, ssn, cell_phone, addr, email, reg_date )
VALUES ( 'user14', 'SCOTT', '1414', 'user', NULL, NULL, NULL, NULL, NOW());

INSERT INTO users ( user_id, user_name, password, role, ssn, cell_phone, addr, email, reg_date )
VALUES ( 'user15', 'SCOTT', '1515', 'user', NULL, NULL, NULL, NULL, NOW());

INSERT INTO users ( user_id, user_name, password, role, ssn, cell_phone, addr, email, reg_date )
VALUES ( 'user16', 'SCOTT', '1616', 'user', NULL, NULL, NULL, NULL, NOW());

INSERT INTO users ( user_id, user_name, password, role, ssn, cell_phone, addr, email, reg_date )
VALUES ( 'user17', 'SCOTT', '1717', 'user', NULL, NULL, NULL, NULL, NOW());

INSERT INTO users ( user_id, user_name, password, role, ssn, cell_phone, addr, email, reg_date )
VALUES ( 'user18', 'SCOTT', '1818', 'user', NULL, NULL, NULL, NULL, NOW());

INSERT INTO users ( user_id, user_name, password, role, ssn, cell_phone, addr, email, reg_date )
VALUES ( 'user19', 'SCOTT', '1919', 'user', NULL, NULL, NULL, NULL, NOW());

INSERT INTO users ( user_id, user_name, password, role, ssn, cell_phone, addr, email, reg_date )
VALUES ( 'user20', 'SCOTT', '2020', 'user', NULL, NULL, NULL, NULL, NOW());

INSERT INTO users ( user_id, user_name, password, role, ssn, cell_phone, addr, email, reg_date )
VALUES ( 'user21', 'SCOTT', '2121', 'user', NULL, NULL, NULL, NULL, NOW());

INSERT INTO users ( user_id, user_name, password, role, ssn, cell_phone, addr, email, reg_date )
VALUES ( 'user22', 'SCOTT', '2222', 'user', NULL, NULL, NULL, NULL, NOW());

INSERT INTO users ( user_id, user_name, password, role, ssn, cell_phone, addr, email, reg_date )
VALUES ( 'user23', 'SCOTT', '2323', 'user', NULL, NULL, NULL, NULL, NOW());


insert into product(prod_name, prod_detail, manufacture_day, price, image_file, reg_date)
values ('vaio vgn FS70B','소니 바이오 노트북 신동품','20120514',2000000, 'AHlbAAAAtBqyWAAA.jpg',str_to_date('2012/12/14 11:27:27', '%Y/%m/%d %H:%i:%s'));
insert into product(prod_name, prod_detail, manufacture_day, price, image_file, reg_date)
values ('자전거','자전거 좋아요~','20120514',10000, 'AHlbAAAAvetFNwAA.jpg',str_to_date('2012/11/14 10:48:43', '%Y/%m/%d %H:%i:%s'));
insert into product(prod_name, prod_detail, manufacture_day, price, image_file, reg_date)
values ('보르도','최고 디자인 신품','20120201',1170000, 'AHlbAAAAvewfegAB.jpg',str_to_date('2012/10/14 10:49:39', '%Y/%m/%d %H:%i:%s'));
insert into product(prod_name, prod_detail, manufacture_day, price, image_file, reg_date)
values ('보드세트','한시즌 밖에 안썼습니다. 눈물을 머금고 내놓음 ㅠ.ㅠ','20120217', 200000, 'AHlbAAAAve1WwgAC.jpg',str_to_date('2012/11/14 10:50:58', '%Y/%m/%d %H:%i:%s'));
insert into product(prod_name, prod_detail, manufacture_day, price, image_file, reg_date)
values ('인라인','좋아욥','20120819', 20000, 'AHlbAAAAve37LwAD.jpg',str_to_date('2012/11/14 10:51:40', '%Y/%m/%d %H:%i:%s'));
insert into product(prod_name, prod_detail, manufacture_day, price, image_file, reg_date)
values ('삼성센스 2G','sens 메모리 2Giga','20121121',800000, 'AHlbAAAAtBqyWAAA.jpg',str_to_date('2012/11/14 18:46:58', '%Y/%m/%d %H:%i:%s'));
insert into product(prod_name, prod_detail, manufacture_day, price, image_file, reg_date)
values ('연꽃','정원을 가꿔보세요','20121022',232300, 'AHlbAAAAtDPSiQAA.jpg',str_to_date('2012/11/15 17:39:01', '%Y/%m/%d %H:%i:%s'));
insert into product(prod_name, prod_detail, manufacture_day, price, image_file, reg_date)
values ('삼성센스','노트북','20120212',600000, 'AHlbAAAAug1vsgAA.jpg',str_to_date('2012/11/12 13:04:31', '%Y/%m/%d %H:%i:%s'));


delete
from users
where user_pk = 10025;

select *
from users;
# where user_id = 'temp01';