CREATE DATABASE sinal_app;
USE sinal_app;

CREATE TABLE usuarios(
	id_user INT PRIMARY KEY AUTO_INCREMENT,
    nome_user VARCHAR(50) NOT NULL,
    email_user VARCHAR(100) NOT NULL,
    senha_user VARCHAR(70) NOT NULL,
    telefone_user VARCHAR(15) NOT NULL
);

CREATE TABLE registros(
	id_registros INT PRIMARY KEY AUTO_INCREMENT,
    descricao_registros VARCHAR(100),
    dt_hr_registros DATETIME,
    id_user_reg INT,
    CONSTRAINT FK_user_reg FOREIGN KEY(id_user) REFERENCES usuarios(id_user)
);

CREATE TABLE logg(
	id_log INT PRIMARY KEY AUTO_INCREMENT,
    descricao_log VARCHAR(150),
    observacoes_log VARCHAR(100),
    dt_hr_log DATETIME
);

CREATE ROLE permissoes_user_admin;
GRANT ALL PRIVILEGES ON *.* TO permissoes_user_admin WITH GRANT OPTION;
CREATE USER 'administrador'@'localhost' IDENTIFIED BY 'adminuser123';
GRANT permissoes_user_admin TO 'administrador'@'localhost';
SET DEFAULT ROLE permissoes_user_admin TO 'administrador'@'localhost';

CREATE TABLE backups LIKE registros;
ALTER TABLE backups MODIFY	COLUMN id_registros INT;
ALTER TABLE backups DROP PRIMARY KEY;

ALTER TABLE backups
ADD id_back INT PRIMARY KEY AUTO_INCREMENT FIRST;

ALTER TABLE backups 
ADD dt_hr_back DATETIME DEFAULT NOW() AFTER id_back;

DELIMITER //
CREATE PROCEDURE fazer_backup()
BEGIN
	INSERT INTO backups(id_registros, descricao_registros, dt_hr_registros, id_user_reg, dt_hr_back)
    SELECT id_registros, descricao_registros, dt_hr_registros, id_user_reg, NOW()
    FROM registros;
END //
DELIMITER ;

CREATE EVENT evento_backup
ON SCHEDULE EVERY 3 MINUTE
STARTS NOW()
DO
	CALL fazer_backup();
    
SET GLOBAL event_scheduler = ON

DELIMITER //
CREATE PROCEDURE limpar_backup()
BEGIN
    INSERT INTO logg(descricao_log, dt_hr_log)
    VALUES('Backup iniciado', NOW());
    
    DELETE FROM backups 
    WHERE dt_hr_back < NOW() - INTERVAL 1 MONTH;

	INSERT INTO logg(descricao_log, dt_hr_log)
    VALUES('Backup finalizado com sucesso', NOW());
END //
DELIMITER ;

CREATE EVENT evento_limpar_backups 
ON SCHEDULE EVERY 1 MONTH
STARTS NOW()
DO
	CALL limpar_backup();

DELIMITER //
CREATE PROCEDURE adicionar_user (
	in p_nome_user VARCHAR(50),
    in p_email_user VARCHAR(100),
    in p_senha_user VARCHAR(70),
    in p_telefone_user VARCHAR(15)
)

	BEGIN
		INSERT INTO usuarios(nome_user, email_user, senha_user, telefone_user)
		values(p_nome_user, p_email_user, p_senha_user, p_telefone_user);

	END //
DELIMITER ;

DELIMITER //
CREATE TRIGGER trg_user_log
AFTER INSERT ON usuarios 
FOR EACH ROW

BEGIN
	INSERT INTO logg(descricao_log, observacoes_log, dt_hr_log)
	VALUES(CONCAT('Usuário, ', NEW.nome_user, ', cadastrado com sucesso'),
		   CONCAT('Dados cadastrados:', CHAR(10), 'Email: ',NEW.email_user, CHAR(10),
				  'Telefone: ', NEW.telefone_user),
		   NOW()
		  );
END //
DELIMITER ; 

DELIMITER  //
CREATE PROCEDURE insercao_registro(
	IN p_descricao_registros VARCHAR(100),
    IN p_dt_hr_registros DATETIME,
    IN p_id_user INT
)
BEGIN

	DECLARE d_nome_user varchar(50);
    
    SELECT nome_user INTO d_nome_user
    FROM usuarios 
    WHERE p_id_user = id_user;
    
	INSERT INTO registros(descricao_registros, dt_hr_registros, id_user)
    VALUES(CONCAT('O usuário: ', d_nome_user, p_descricao_registros), 
				  p_dt_hr_registros, 
                   p_id_user
);
END //
DELIMITER ;

DELIMITER //
CREATE TRIGGER trg_reg_log
AFTER INSERT ON registros
FOR EACH ROW

BEGIN
	DECLARE nome_usuario VARCHAR(50);
    
    SELECT nome_user INTO nome_usuario
    FROM usuarios 
    WHERE id_user = NEW.id_user;
    
    INSERT INTO logg(descricao_logg, dt_hr_logg)
    VALUES(CONCAT('O usuário: ', nome_usuario, NEW.descricao_registros, CHAR(10), 'Data e hora: ',NOW()) 
    );
END //
DELIMITER ;

DEMILITER //
CREATE PROCEDURE erro_log(
	IN p_descricao_log VARCHAR(150)
    IN p_observacoes_log VARCHAR(150)
)

BEGIN
	INSERT INTO logg(descricao_log, observacoes_log, dt_hr_log)
    VALUES(p_descricao_log, p_observacoes_log, NOW())
END //
DELIMITER ;

DELIMITER // 
CREATE PROCEDURE editar_excluir_registro(
	IN p_acao VARCHAR(15),
    IN p_id_registros INT,
    IN p_descricao_registros VARCHAR(150)
)

BEGIN
	IF LOWER(p_acao) ='editar' THEN
		UPDATE registros
		SET descricao_registros = p_descricao_registros
		WHERE id_registros = p_id_registros;
    ELSEIF LOWER(p_acao) = 'excluir' THEN
		DELETE FROM registros
		WHERE id_registros = p_id_registros;
	ELSE
		SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Ação inválida! Escolher uma função válida, editar ou excluir';
    END IF;
END //
DELIMITER ;

DELIMITER //
CREATE TRIGGER update_reg_log
AFTER UPDATE ON registros
FOR EACH ROW 

BEGIN
	INSERT INTO logg(descricao_log, dt_hr_log)
    VALUES(CONCAT('Registro ', NEW.id_registros, ' editado com sucesso!' ,CHAR(10),'De :' ,OLD.descricao_registros, 'para: ', NEW.descricao_registros),
    NOW()
    );
END //
DELIMITER ;

DELIMITER //
CREATE TRIGGER delete_reg_log
AFTER DELETE ON registros
FOR EACH ROW 

BEGIN
	INSERT INTO logg(descricao_log, dt_hr_log)
    VALUES(CONCAT('Registro ', OLD.id_registros, ' excluído com sucesso!' , 'Registro excluído: ' ,OLD.descricao_registros),
    NOW()
    );
END //
DELIMITER ;
