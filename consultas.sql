/* Goup by/Having
	Projetar as categorias de instrumento que tem mais de 3 instrumentos */

		SELECT I.CATEGORIA, COUNT(*) AS NUM_INSTRUMENTOS
		FROM INSTRUMENTO I
		GROUP BY I.CATEGORIA
		HAVING COUNT(*) > 3;

/* Junção interna:
	Projetar o nome de todos os shows e o nome de seu respectivo festival */

		SELECT S.NOME, F.NOME
		FROM SHOW S INNER JOIN
			FESTIVAL F ON S.ID_FESTIVAL = F.ID;

/* Junção Extetna:
	Projetar o nome dos clientes que não compraram ingresso */

		SELECT CLI.NOME
		FROM CLIENTE CLI LEFT OUTER JOIN
			COMPRA C ON CLI.CPF = C.CPF
		WHERE C.CPF IS NULL;

/* Semi junção:
	Projetar os telefones de todos os clientes que compraram ingresso para algum festival */

		SELECT CLI.TELEFONE_1, CLI.TELEFONE_2
		FROM CLIENTE CLI
		WHERE EXISTS (
			SELECT C.CPF
			FROM COMPRA C
			WHERE CLI.CPF = C.CPF
			);

/* Anti-junção:
	Projetar o CPF dos clientes que possuem ingresso e não participaram da gincana */

		SELECT C.CPF
		FROM COMPRA C
		WHERE NOT EXISTS (
			SELECT P.NUM_INGRESSO
			FROM PARTICIPA P
			WHERE P.NUM_INGRESSO = C.NUM
			);

/* Subconsulta do tipo escalar:
	Projetar o nome do chefe do funcionário de matrícula M007 */

		SELECT F.NOME
		FROM FUNCIONARIO F
		WHERE F.MATRICULA = (
			SELECT F1.MAT_CHEFE
			FROM FUNCIONARIO F1
			WHERE F1.MATRICULA = 'M007'
			);

/* Subconsulta do tipo linha:
	Projetar os shows com o mesmo dia e local do show de código S009 */

		SELECT S.NOME
		FROM SHOW S
		WHERE (TO_CHAR(S.DATA_HORA, 'DD-MM-YYYY'), S.LOCAL_) IN (
			SELECT TO_CHAR(S1.DATA_HORA, 'DD-MM-YYYY'), S1.LOCAL_
			FROM SHOW S1
			WHERE S1.COD = 'S009'
			);

/* Subconsulta do tipo tabela:
	Projetar o nome e a categoria de todos os instrumentos que todos os músicos tocam */

		SELECT I.NOME, I.CATEGORIA
		FROM INSTRUMENTO I
		WHERE I.CADASTRO IN (
    			SELECT T.CAD_INST
    			FROM TOCA T
    			WHERE T.CPF_MUSICO IN (
    				SELECT M.CPF
    				FROM MUSICO M
    				)
			);

/* Operação de Conjunto:
	Projetar o nome de todos os cantores que também são músicos */

			SELECT C.NOME
			FROM CANTOR C
		INTERSECT
			SELECT M.NOME
			FROM MUSICO M;
