#a
SELECT * from baiviet,theloai  WHERE baiviet.ma_tloai = theloai.ma_tloai and theloai.ten_tloai = "Nhạc trữ tình";
#b
SELECT * FROM baiviet,tacgia WHERE baiviet.ma_tgia = tacgia.ma_tgia and tacgia.ten_tgia = "Nhacvietplus";
#c
SELECT theloai.ten_tloai FROM theloai LEFT JOIN baiviet on theloai.ma_tloai = baiviet.ma_tloai WHERE baiviet.ma_tloai is Null;
#d
SELECT baiviet.ma_bviet, baiviet.tieude, baiviet.ten_bhat, tacgia.ten_tgia, theloai.ten_tloai, baiviet.ngayviet FROM baiviet,tacgia,theloai 
where baiviet.ma_tgia = tacgia.ma_tgia and baiviet.ma_tloai = theloai.ma_tloai;
#e
SELECT theloai.ten_tloai, COUNT(*) AS soLuong
FROM baiviet,theloai where baiviet.ma_tloai = theloai.ma_tloai
GROUP BY theloai.ten_tloai
ORDER BY soLuong DESC
LIMIT 1;

SELECT theloai.ten_tloai, COUNT(*) AS so_bai_viet
FROM baiviet
INNER JOIN theloai ON baiviet.ma_tloai = theloai.ma_tloai
GROUP BY baiviet.ma_tloai
HAVING COUNT(*) = (SELECT COUNT(*) AS so_bai_viet
                   FROM baiviet
                   GROUP BY ma_tloai
                   ORDER BY so_bai_viet DESC
                   LIMIT 1);
#f
SELECT tacgia.ten_tgia, COUNT(*) AS soLuong
FROM baiviet,tacgia where baiviet.ma_tgia = tacgia.ma_tgia
GROUP BY tacgia.ma_tgia
ORDER BY soLuong DESC
LIMIT 2;

#g
SELECT baiviet.tieude FROM baiviet where baiviet.ten_bhat  
like '%yêu%' or baiviet.ten_bhat like '%thương%' or baiviet.ten_bhat like '%anh%' or baiviet.ten_bhat like '%em%';

#h
SELECT baiviet.tieude FROM baiviet where baiviet.ten_bhat  
like '%yêu%' or baiviet.ten_bhat like '%thương%' or baiviet.ten_bhat like '%anh%' or baiviet.ten_bhat 
like '%em%' or baiviet.tieude LIKE '%thương%' or baiviet.tieude LIKE '%anh%' or baiviet.tieude 
LIKE '%yêu%' or baiviet.tieude LIKE '%em%';

SELECT baiviet.tieude
FROM baiviet
WHERE baiviet.ten_bhat REGEXP 'yêu|thương|anh|em'
   OR baiviet.tieude REGEXP 'yêu|thương|anh|em';

#i
CREATE VIEW vw_Music AS 
SELECT baiviet.ma_bviet,baiviet.tieude,baiviet.ten_bhat,baiviet.tomtat,baiviet.noidung,baiviet.ngayviet,baiviet.hinhanh,theloai.ten_tloai,tacgia.ten_tgia
FROM baiviet 
JOIN theloai ON baiviet.ma_tloai = theloai.ma_tloai
JOIN tacgia ON baiviet.ma_tgia = tacgia.ma_tgia;


#j

DELIMITER //
CREATE PROCEDURE sp_DSBaiViet (IN tenTL VARCHAR(50))
BEGIN
   DECLARE maTL varchar(50);
   SELECT ma_tloai INTO maTL FROM theloai WHERE ten_tloai = tenTL;
   IF maTL IS NULL THEN
      SELECT 'Khong tim thay the loai ' AS 'Error';
   ELSE
      SELECT baiviet.ma_bviet, baiviet.tieude, tacgia.ten_tgia 
      FROM baiviet 
      JOIN tacgia ON baiviet.ma_tgia = tacgia.ma_tgia 
      WHERE baiviet.ma_tloai = maTL;
   END IF;
END//

DELIMITER ;
#gọi procedure
CALL sp_DSBaiViet('Rock')




