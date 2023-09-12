/* Group by/Having:
    Projetar as categorias de instrumento tem mais de 3 instrumentos */

        SELECT I.CATEGORIA, COUNT(*) AS NUM_INSTRUMENTOS
        FROM INSTRUMENTO I
        GROUP BY I.CATEGORIA
        HAVING COUNT(*) > 3


/* Junção interna:
     Projetar o nome de todos os shows e o nome de seu respectivo festival */

        SELECT S.NOME, F.NOME
        FROM SHOW S INNER JOIN
        FESTIVAL F ON S.ID_FESTIVAL = F.ID


/* Junção Externa: 
    Projetar os funcionários não trabalham atualmente em nenhum festival */

		SELECT F.NOME
		FROM FUNCIONARIO F LEFT OUTER JOIN
			TRABALHA T ON F.MATRICULA = T.MATRICULA_FUNC
		WHERE T.DATA_ = CURRENT_DATE AND
			T.ID_FESTIVAL IS NULL

/* Semi junção:
    Projetar os telefone de todos os clientes que compraram ingresso em algum festival */
		
        SELECT CLI.TELEFONE_1, CLI.TELEFONE_2
		FROM CLIENTE CLI
		WHERE EXISTS (
    		SELECT C.CPF
			FROM COMPRA C
			WHERE CLI.CPF = C.CPF
        )

/* Anti-junção:
    Projetar o CPF dos clientes que possuem ingresso e não participaram da gincana
    */
        SELECT C.CPF
        FROM COMPRA C
        WHERE NOT EXISTS (
        	SELECT P.NUM_INGRESSO
        	FROM PARTICIPA P
            WHERE P.NUM_INGRESSO = C.NUM
            )

/* Subconsulta do tipo escalar:
    Projetar o nome do chefe do funcionário de matricula X */
		
        SELECT F.NOME
        FROM FUNCIONARIO F
        WHERE F.MAT_CHEFE = (
            SELECT F1.MAT_CHEFE
            FROM FUNCIONARIO F1
            WHERE F1.MATRICULA = 'X'
			)

/* Subconsulta do tipo linha:
    Projetar os shows som o mesmo horário e local do show de código X */

        SELECT S.NOME
        FROM SHOW S
        WHERE (DATA_HORA, LOCAL_) IN (
            SELECT S1.DATA_HORA, S1.LOCAL_
            FROM SHOW S1
            WHERE S1.COD = 'X'
        	)

/* Subconsulta do tipo tabela:
    Projetar o nome de todos os funcionários que trabalham trabalham atualmente em algum festival */

        SELECT F.NOME
        FROM FUNCIONARIO F
        WHERE F.MATRICULA IN (
            SELECT T.MATRICULA_FUNC
            FROM TRABALHA T
            WHERE T.ID_FESTIVAL IS NOT NULL AND
            T.DATA_ = CURRENT_DATE
        	)

/* Operação de Conjunto:
    Projetar o nome de todos os cantores que são músicos */
        
        	SELECT C.NOME
            FROM CANTOR C
        UNION
            SELECT M.NOME
            FROM MUSICO M
